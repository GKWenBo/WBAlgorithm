# 第 4 课：GATT 读写（1 课时）

> 目标：连接后发现服务，读写自建 Characteristic——App 第一次真正「和设备说话」。

## 一、服务发现：为什么每次连接都要做

`discoverServices()` 做的事：主机沿 ATT 协议遍历外设的属性表，把 Service/Characteristic/Descriptor 的 **UUID → 句柄（handle）映射**拉回本地。之后所有读写操作走的都是句柄，不是 UUID。

为什么不能把上次的句柄存下来直接用？因为**句柄表属于「这一次连接看到的这台设备固件」**：设备固件升级、服务结构变化后句柄会重排。双端系统都做了 GATT 缓存加速（安卓缓存服务表，iOS 也缓存），这带来企业开发经典坑：**设备 OTA 后 App 还在用系统缓存的旧表**，读写莫名失败——安卓要靠反射调 `BluetoothGatt#refresh()` 清缓存（FBP 未直接暴露），iOS 靠外设发 Service Changed 指示。课程记住结论：连接后必发现、发现结果不落盘、OTA 后异常先怀疑缓存。

FBP 细节：`discoverServices()` 默认 `subscribeToServicesChanged: true`——自动订阅 GATT 标准的 Service Changed 特征（0x2A05），服务结构变化时插件会收到通知。

## 二、读：一问一答

`characteristic.read()` = ATT Read Request → Read Response，单包最多 **MTU-1 字节**；更长的值协议层有 Read Blob 续传（FBP 自动处理）。读完后 `characteristic.lastValue` 缓存最近一次值，`lastValueStream` 是值变化流（读、写、通知都会喂它——第 5 课订阅时它是主角）。

拿到的是 `List<int>` 裸字节。**GATT 只定义容器，不定义语义**：`[0x64]` 在电池特征里是 100%，在音量特征里可能是最大音量。标准特征的语义查蓝牙 SIG 的 Assigned Numbers 文档；私有特征的语义由厂商协议文档定义——这就是第 6 课私有协议的入口。

## 三、写：企业协议的核心选型题

| | Write **with** Response | Write **without** Response |
|---|---|---|
| ATT 层 | Write Request，外设必须回 Write Response | Write Command，发完即忘 |
| 可靠性 | ATT 层确认，失败会抛错 | 无确认（但链路层仍保证送达顺序与重传†） |
| 吞吐 | 一个连接间隔一般只能一笔 | 一个连接间隔可塞多笔，吞吐高数倍 |
| 单笔上限 | MTU-3；更长可 `allowLongWrite`（Prepared Write 分段） | MTU-3，超了直接失败 |
| 企业用途 | **指令通道**：配置、控制、关键命令 | **数据通道**：OTA 固件包、音频流、日志批量上传 |

† 面试易错点：without response 不是 UDP。BLE 链路层本身有 CRC 校验 + 重传，Write Command 丢的风险主要在**外设应用层缓冲溢出**（发太快对方处理不过来）——所以 OTA 用它时要自己做流控（每 N 包等设备回一个进度通知），这正是第 6 课协议设计的内容之一。

选型口诀：**低频关键写用 with response，高频吞吐写用 without response + 应用层流控**。`write()` 的一个坑：`withoutResponse: true` 时若特征不支持 WNR 属性会抛错，UI 必须按 `properties` 提供选项（我们的写入对话框就是这么做的）。

## 四、本课代码

```
lib/
├── core/
│   ├── hex.dart                 # 十六进制解析/格式化 + UTF-8 尝试解码（纯函数，带单测）
│   └── gatt_names.dart          # 标准 UUID → 中文名（0x180D 心率服务…）
└── features/device/
    ├── device_controller.dart   # 新增：discoverServices / read / write，断线自动清空服务表
    └── gatt_browser.dart        # 服务浏览器：Service 分组 → 特征卡片（属性徽标/值/读写按钮）
```

- 连接成功后**自动**服务发现（企业 App 的标准流程，用户不该关心这一步）；断线时清空 `services`——句柄表跟着连接走，这是第一节理论的代码表达。
- 特征卡片：属性徽标（读/写/免响写/通知/指示）、值的 hex + UTF-8 双显示、读按钮、写按钮（弹框输 hex，可选写类型）。
- hex 工具是纯函数并配了单测——所有字节处理逻辑不碰蓝牙就能测（第 8 课主题的又一次预演）。

## 五、动手任务：自建特征

**正向（安卓当外设，iPhone 跑 App）**：
1. 安卓 nRF Connect → 右上角菜单 → **Configure GATT server** → 添加 Service（自定义 128-bit UUID，或用模板）→ 在该 Service 下添加 Characteristic：属性勾 **Read + Write**，初始值随便填几个字节（如 `01 02 03`）。
2. nRF Connect → ADVERTISER → 新建广播（勾 Connectable），开启。
3. Mac 上 `flutter run` 到 iPhone → 扫描连接 → 服务浏览器找到你的自定义特征 → **读**出 `01 02 03` → **写**入 `48 69`（"Hi"）→ 回 nRF Connect 服务器页看到值已变。

**反向（iPhone 当外设，安卓跑 App）**：
4. LightBlue → Virtual Devices → 新建（选 Blank 或任意模板，确认有可读写特征）→ 安卓打开 wb_ble_app 连接读写一遍。

## 验收

1. 实操 3 的读、写、对端确认三步截图或口述现象。
2. 回答：① 为什么句柄不能跨连接复用？系统 GATT 缓存会带来什么企业级坑？② OTA 固件传输该用哪种写？丢包风险真正来自哪里、怎么防？③ `read()` 回来的 `[0x64]` 是什么意思？——这个问题的正确答案是什么？

## 高频面试题

**Q：为什么每次连接都要做服务发现？句柄能不能存下来复用？**
不能。句柄是外设 ATT 属性表里的「行号」，属于**这一次连接看到的这份固件**——固件升级、服务增删后句柄会重排。双端系统都做了 GATT 缓存来加速发现，于是有了那个经典坑：**设备 OTA 之后，App 还在用系统缓存的旧属性表**，读写莫名其妙失败或读到错的特征。解法：安卓侧反射调 `BluetoothGatt#refresh()` 清缓存后重连；标准做法是外设实现 **Service Changed（0x2A05）指示**，主动告诉主机「我的表变了」，iOS 就靠它失效缓存（所以固件做 OTA 一定要带这条特征）。课程结论三句话：连接后必发现、发现结果不落盘、OTA 后异常先怀疑缓存。

**Q：服务发现很慢怎么办？**
一次全表发现会把所有 Service/Characteristic/Descriptor 都遍历一遍，设备服务多时可能要几百毫秒到数秒（安卓尤甚）。优化手段：① **定向发现**——原生 API 支持只发现指定 UUID 的服务/特征（iOS `discoverServices:` 传数组），业务只用两条特征就没必要拉全表；② 发现完成前不要抢着发读写请求；③ 别为了「刷新」频繁断连重连，那反而每次都要重做发现。

**Q：两种写怎么选？**
**Write with Response**（ATT Write Request）：外设必须回 Response，ATT 层有确认、失败会抛错，但一个连接间隔通常只能走一笔，慢。**Write without Response**（ATT Write Command）：发完即忘，一个连接间隔能塞多笔，吞吐高数倍。选型口诀：**低频关键写用 with response（配置、控制指令），高频吞吐写用 without response + 应用层流控（OTA 固件包、日志上传、音频流）**。单笔上限都是 MTU-3（3 = 1 字节 opcode + 2 字节句柄）；超长且必须一次写完的，可以用 Prepared Write + Execute Write（长写）分段，代价是慢且不是所有固件都实现。

**Q：Write without response 是不是像 UDP，会丢包？**
不是。BLE **链路层本身有 CRC 和重传**，空中包丢失会自动重发，顺序也有保证。真正的丢失风险在**接收端应用层缓冲溢出**——你发得比固件处理得快，固件的接收队列满了就直接丢。所以用它做 OTA 必须自己做**应用层流控**：每 N 包等设备回一个进度通知再继续，或者用带确认的窗口机制。这题答对了很加分，因为大部分人会脱口而出「像 UDP 会丢」。

**Q：读回来一个 `[0x64]`，是什么意思？**
**这个问题本身没有答案**——GATT 只定义「容器」不定义「语义」。`0x64` 在电量特征里是 100%，在音量特征里可能是最大音量，在私有特征里可能是一个命令字。语义只有两个来源：标准特征查蓝牙 SIG 的 Assigned Numbers / GATT Specification Supplement；私有特征查厂商的协议文档。**能识破这是个陷阱题，比背出 100% 更值钱**——这正是第 6 课要自己定义一套协议的原因。

**Q：多个读写请求能并发发吗？**
不能真并发。ATT 层同一时刻只允许一个未完成的事务，安卓原生如果不自己排队、连着发两个 `writeCharacteristic`，第二个直接返回 false 被丢掉——「安卓写多条只成功第一条」的经典 bug 就是这么来的。iOS 和 flutter_blue_plus 内部做了串行队列，所以上层感觉不到，但**跨设备的并发操作仍然要自己控**，且长事务（长写、OTA）期间要避免插入其它请求。

**Q：OTA 固件升级你会怎么设计？**
传输走 **Write without Response** 冲吞吐 + **应用层流控**（每 N 包等一个进度 Notify）+ 分块 CRC + 记录偏移支持**断点续传** + 整包签名校验防刷错固件。传前先协商 MTU 把包切到 MTU-3、尽量把连接间隔调小提速，传完让设备校验后再切分区重启。别忘了两个坑：**升级后属性表变了要发 Service Changed / 清缓存**（不然新固件读写全错），以及重启后 App 要能自动重连（第 7 课）。

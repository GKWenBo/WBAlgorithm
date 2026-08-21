# 第 5 课：订阅通知（1 课时）

> 目标：让数据「活」起来——订阅心率通知，解析标准协议字节，自绘实时曲线。这是企业设备「上报通道」的完整雏形。

## 一、setNotifyValue 背后：往 CCCD 写两个字节

`characteristic.setNotifyValue(true)` 干的事，拆开是两步：

1. **本地注册**：告诉系统蓝牙栈「这个特征的通知到达时叫醒我的 App」。
2. **远端开闸**：向该特征的 **CCCD 描述符（0x2902，Client Characteristic Configuration Descriptor）** 写入 `01 00`（开 Notify）或 `02 00`（开 Indicate）；取消订阅写 `00 00`。

CCCD 是「客户端」配置——**每个连接的主机各有一份**，你订阅了不影响别的主机，断线后外设侧通常复位（所以重连后要重新订阅——第 7 课重连状态机的必做项之一）。

双端差异（面试点）：安卓上这两步是分离的（`setCharacteristicNotification()` + 手动写 CCCD，忘写第二步是安卓原生开发经典 bug——「本地在听，远端没开闸」，一个通知也收不到）；iOS 的 `setNotifyValue:` 一个调用两步全做，**且 CoreBluetooth 不把 CCCD 暴露在描述符列表里**——所以同一台设备，安卓 App 能枚举到 0x2902，iOS 枚举不到，这不是 bug 是平台设计。FBP 把两端差异抹平成一个 `setNotifyValue`。

## 二、Notify vs Indicate

| | Notify | Indicate |
|---|---|---|
| ATT 层确认 | 无，发完即忘 | 有，主机必须回 Confirmation 才能发下一条 |
| 吞吐 | 高，一个连接间隔可多条 | 低，一问一答 |
| 典型用途 | 传感器流（心率/加速度/电量） | 关键事件（Service Changed、血糖记录、告警） |

选型逻辑与第 4 课两种写完全对称：**流数据用 Notify 冲吞吐，关键状态用 Indicate 保送达**。FBP 里 `setNotifyValue(true)` 默认按特征属性自动选（notify 优先），特征两者都支持时可用 `forceIndications: true` 强制走 Indicate。

数据到达的入口是 `onValueReceived` 流（只含读回与通知），UI 层我们统一订阅它；`lastValueStream` 额外混入了写操作的回显，做「值展示」用它，做「上报数据处理」用 `onValueReceived`——语义分清，第 6 课协议层只接后者。

订阅的生命周期管理用 FBP 的 `device.cancelWhenDisconnected(sub)`：把 StreamSubscription 挂到设备上，断线自动取消，避免最常见的订阅泄漏。

## 三、心率测量（0x2A37）解析：第一次读协议文档

蓝牙 SIG 对 Heart Rate Measurement 的定义（GATT Specification Supplement）：

```
字节 0        flags:
  bit0    心率值格式：0 = uint8（字节 1），1 = uint16 小端（字节 1-2）
  bit1-2  传感器接触状态
  bit3    含能量消耗字段（uint16，再占 2 字节）
  bit4    含 RR 间期（每个 uint16，单位 1/1024 秒，可多个）
之后按 flags 依次排布各字段
```

**第一个字节不是心率**——上一课验收题 3 的坑在此兑现。`[0x00, 0x48]` 才是 72 BPM；如果设备上报 `[0x10, 0x48, 0x34, 0x02]`，那是 72 BPM + 一个 RR 间期。解析要点全在「按 flags 逐位决定后续字节怎么读」，这正是第 6 课私有协议帧解析的标准姿势预演：**字节序（小端）、变长字段、位标志**一次全见到。

解析器写成纯函数（`core/heart_rate.dart`），进单测——协议解析永远不碰蓝牙 API，这条纪律贯穿到课程结束。

## 四、本课代码

```
lib/
├── core/heart_rate.dart          # 0x2A37 解析：flags 位域 + uint8/uint16 小端（纯函数+单测）
└── features/device/
    ├── device_controller.dart    # 新增 toggleNotify：setNotifyValue + onValueReceived 订阅
    │                             #（cancelWhenDisconnected 托管），心率样本环形缓存
    ├── gatt_browser.dart         # 通知/指示特征新增「订阅」开关，值实时刷新
    ├── heart_rate_chart.dart     # CustomPaint 自绘实时曲线（零依赖）
    └── device_page.dart          # 订阅心率后顶部出现曲线卡片
```

实现细节里的工程判断：

- 心率样本存 `List<int>` 上限 120 个（约 2 分钟），超了移头——**环形缓存**思想，防止长时间订阅内存无限涨。
- 曲线 Y 轴按当前数据 min/max 自适应并留边距，X 轴固定样本数——传感器曲线的通用画法。
- 订阅开关的状态直接读 `characteristic.isNotifying`（它反查 CCCD 的当前值），不自己存 bool——**单一事实来源**，和第 2 课「isScanning 不自己维护」同一个原则。

## 五、动手任务

1. 安卓 nRF Connect → Configure GATT server → 用模板添加 **Heart Rate 服务**（或手建 0x180D + 0x2A37 Notify 特征）→ ADVERTISER 开播。iPhone 跑 App：连接 → 服务浏览器找到 2A37 → 点「订阅」→ nRF Connect 服务器端修改 2A37 的值（模拟心跳变化）→ App 曲线实时跳动。
2. 反向：iPhone LightBlue 开 Heart Rate 虚拟外设（它会自动周期推模拟心率）→ 安卓 App 连接订阅 → 看曲线自己滚动。
3. 断开重连一次，确认：订阅状态归零（CCCD 复位）、需要重新点订阅——体感「订阅不跨连接」。

## 验收

1. 双向实操成功，曲线实时滚动（截图/口述）。
2. 回答：① `setNotifyValue(true)` 在协议层到底做了什么？安卓原生开发在这里的经典 bug 是什么？② Notify 和 Indicate 怎么选？和第 4 课两种写的选型逻辑有什么对称性？③ 设备上报 `[0x10, 0x48, 0x34, 0x02]`，心率是多少？0x10 和后两个字节分别是什么？

## 高频面试题

**Q：`setNotifyValue(true)` 底层做了什么？**
两件事：① **本地注册**——告诉系统蓝牙栈「这个特征的通知到了叫醒我」；② **远端开闸**——往该特征的 **CCCD 描述符（0x2902）** 写 `01 00` 开 Notify、`02 00` 开 Indicate、`00 00` 取消。安卓原生把这两步拆成了 `setCharacteristicNotification()` 和手动写 CCCD，**只做第一步忘了第二步**是安卓 BLE 最经典的 bug——本地在听、远端没开闸，一条通知都收不到，还完全不报错。iOS 的 `setNotifyValue:` 一步做完两件事，而且 CoreBluetooth **根本不把 CCCD 暴露在描述符列表里**（所以同一设备安卓能枚举到 0x2902、iOS 枚举不到，这是平台设计不是 bug）。flutter_blue_plus 把两端抹平成一个调用。

**Q：Notify 和 Indicate 怎么选？**
Notify 无 ATT 层确认、一个连接间隔可发多条、吞吐高，用于**流数据**（心率、加速度、电量）；Indicate 每条都要主机回 Confirmation 才能发下一条、吞吐低，用于**关键事件**（Service Changed、告警、血糖记录这类漏一条就出事的）。判据一句话：**丢了能自愈的用快的，不能自愈的用可靠的**——和第 4 课两种写完全对称（Write Command ↔ Notify 是快通道，Write Request ↔ Indicate 是可靠通道）。

**Q：CCCD 是「谁」的配置？断线后还在吗？**
CCCD 是 **Client** Characteristic Configuration Descriptor——**每个连接上来的主机各有一份**，你订阅不影响别的主机。未绑定的连接断开后外设侧通常复位（绑定设备可以持久化订阅状态，但别指望）。所以铁律是：**订阅不跨连接，重连后必须重新订阅**，否则就是第 7 课那个「连上了但再也收不到数据」的线上 bug。

**Q：Notify 会丢数据吗？怎么保证不丢？**
链路层有 CRC 和重传，空中基本不丢；真正的丢点在**外设侧**：连接间隔内能发的包数有限，固件产生数据比能发出去的快时，通知队列满了就直接丢弃（大多数协议栈是静默丢）。App 侧无从察觉。所以关键数据不能裸奔，要在应用层加**序号**（收到序号跳变就知道丢了）+ 补传请求，或者干脆改用 Indicate。产品上还有一招：外设把数据先存 flash，App 连上后主动拉取增量，通知只当「有新数据」的提醒。

**Q：通知来得很快，UI 卡了怎么办？**（Flutter 岗位加分题）
一条 100Hz 的通知流意味着每秒上百次平台通道回调 + 上百次 `notifyListeners()` 重建，卡是必然的。四个手段：① **解析下沉成纯函数**，不要在回调里做重活（本项目 `parseHeartRate` 就是纯函数，还带单测）；② **批量/节流刷新**——数据照收进缓冲区，UI 按 16ms 或固定条数合并刷新一次；③ **只重建需要变的那一小块 Widget**，别让整页跟着抖；④ 真的有大批量解码（如 OTA 校验、波形解析）时丢进 `compute`/Isolate。另外样本缓存要**定长环形**（本项目上限 120 条），否则订阅一小时内存就涨穿。

**Q：`onValueReceived` 和 `lastValueStream` 有什么区别？**
`onValueReceived` 只包含**读回值和通知**；`lastValueStream` 还额外混入了**写操作的回显**。做「值展示」用后者省事，做「上报数据处理」必须用前者——否则你自己写下去的指令会被当成设备上报的数据再解析一遍（第 6 课的协议层就只接 `onValueReceived`）。这题考的是有没有真读过库的语义，而不只是抄示例。

**Q：订阅的生命周期怎么管，怎么避免泄漏？**
每个 `setNotifyValue` 都对应一个 StreamSubscription，页面销毁或断线不取消就是泄漏（还会出现「断线后旧回调仍在跑」的诡异现象）。本项目用 FBP 的 `device.cancelWhenDisconnected(sub)` 把订阅挂到设备上，断线自动取消；同时**订阅开关的显示状态直接读 `characteristic.isNotifying`**（它反查 CCCD 实况）而不是自己存 bool——单一事实来源，和第 2 课「不自己维护 isScanning」是同一个原则。

**Q：心率 `[0x10, 0x48, 0x34, 0x02]` 是多少？**
72 BPM，外加一个 RR 间期。字节 0 是 **flags**：bit0=0 表示心率是 uint8（所以字节 1 的 `0x48` = 72 就是心率），bit4=1（`0x10`）表示后面带 RR 间期，`0x34 0x02` 小端 = 0x0234 = 564，单位 1/1024 秒 ≈ 551ms。**要点是「第一个字节不是数据、是位标志」**——按 flags 逐位决定后续字节怎么读、多字节小端、字段变长，这三件事就是所有二进制协议解析的标准姿势，第 6 课自己设计协议时原样再来一遍。

# Flutter BLE 实战课程进度

> 规则：**完成上一课并通过验收，才进入下一课。** 每课验收后在此勾选并记录日期与结论。
>
> 单课时约 1.5 小时：理论讲解 30min + 带练编码 50min + 真机验收 10min。
> 每篇讲义末尾都有一节 **「高频面试题」**（本课题库），第 11 课是跨课串讲 + 进阶专题 + 场景设计题，两者配合刷。
> 测试环境：两台手机——一台跑本 App（Central），另一台用 nRF Connect（安卓）/ LightBlue（iOS）模拟外设（Peripheral）。

## 课程总表

| 状态 | 课时 | 主题 | 验收标准 |
|:---:|---|---|---|
| ✅ | 第 0 课 | 环境与项目初始化 | 双端真机跑起空项目；两台手机装好 nRF Connect / LightBlue |
| ✅ | 第 1 课 | BLE 理论地基（GAP/GATT/广播/MTU） | 能口述一次 BLE 连接的完整生命周期 |
| ✅ | 第 2 课 | 扫描实战（运行时权限 / startScan / RSSI / 广播解析） | App 能扫到并列出另一台手机模拟的外设 |
| ✅ | 第 3 课 | 连接管理（connect / 状态流 / 超时） | 与模拟外设建连断连，UI 状态实时正确 |
| ✅ | 第 4 课 | GATT 读写（discoverServices / read / write） | 读写模拟外设上的自建 Characteristic 成功 |
| ✅ | 第 5 课 | 订阅通知（Notify/Indicate / CCCD / 心率服务实战） | 实时心率数据流稳定刷新 |
| 📝 | 第 6 课 | 私有二进制协议（帧结构 / CRC / 分包组包）★企业核心 | 协议编解码层完成 + 单元测试通过 |
| 📝 | 第 7 课 | 稳定性工程（自动重连状态机 / 异常场景） | 外设消失再出现，App 自动恢复连接 |
| 📝 | 第 8 课 | 架构分层与可测试性（接口抽象 + Mock 双实现） | Mock 下全流程可离线演示 |
| 📝 | 第 9 课 | 双端平台差异与后台（iOS 状态恢复 / Android 前台服务） | 双端后台配置完成，能讲清差异 |
| 📝 | 第 10 课 | 综合项目验收：「设备管家」全流程 | 双端真机演示全流程通过 |
| 📝 | 第 11 课（可选） | 面试冲刺（高频题 / OTA / iBeacon / 配对绑定 / Mesh） | 模拟问答一轮 |

图例：⬜ 未开始 · 🔄 进行中 · 📝 代码与讲义已就绪、待用户验收 · ✅ 已验收

> 第 6–11 课（2026-07-22 由 Claude 一次性编写）：代码 + 讲义已完成、`flutter analyze` 无告警、`flutter test` 40 条全绿、APK 构建通过，**但尚未经用户真机验收**。用户逐课看讲义 + 真机验证通过后，再把对应行改为 ✅。

## 验收记录

### 第 0 课 —— ✅ 已验收（2026-07-04 开课，2026-07-04 验收）
- [x] 创建 Flutter 项目（Android + iOS），引入 flutter_blue_plus
- [x] Android 12+/11- 分层蓝牙权限配置（AndroidManifest.xml）
- [x] iOS 蓝牙用途声明（Info.plist：NSBluetoothAlwaysUsageDescription）
- [x] 安卓手机安装 nRF Connect（Play 商店受限，改用 GitHub Releases 官方 APK 4.29.1 + adb 安装）
- [x] iPhone 安装 LightBlue
- [x] 双端真机 `flutter run` 跑起空项目

备注：本机 Flutter 下载引擎产物需带国内镜像环境变量（`FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn`），否则首次 iOS 构建会因慢速下载假死。
思考题（Android 12 前扫描为何要定位权限 / neverForLocation 的代价）随第 1 课理论一并讲解确认。

### 第 1 课 —— ✅ 已验收（2026-07-04）
- [x] 理论：GAP/GATT、广播包结构、连接生命周期、MTU（讲义 lessons/lesson-01.md）
- [x] 实操：LightBlue 建虚拟外设，nRF Connect 扫描→连接→订阅 0x2A37（过程中实地踩了 iOS 后台广播降级坑：LightBlue 退后台/锁屏后安卓扫不到）
- [x] 验收：三道验收题以讲解答案形式过关（生命周期口述稿、0x180D/Notify 观察、Write+Notify vs 轮询 Read）

备注：验收答案整理在会话中，生命周期口述稿可直接作为面试答案背诵。

### 第 2 课 —— ✅ 已验收（2026-07-04）
- [x] 代码：ScanController（adapterState/scanResults/isScanning 三流订阅）+ 扫描列表 UI + 两条纯逻辑单元测试
- [x] 实操：安卓端扫到 LightBlue 心率外设，服务过滤生效；iPhone 端扫到 nRF Connect 自定义广播
- [x] 验收题：remoteId 双端差异与绑定方案（MAC vs UUID、厂商数据兜底、RPA 补充）、扫描节流/timeout 必要性、removeIfGone 幽灵设备治理

遗留伏笔：removeIfGone 本课讲了原理未开启，第 3 课做连接页时一并加上体验对比。

### 第 3 课 —— ✅ 已验收（2026-07-05）
- [x] 代码：DeviceController（busy/链路状态双层分离、disconnectReason）、DevicePage 骨架、扫描页 removeIfGone + 点击跳转（连接前 stopScan）
- [x] 实操：建连/断连、读链路 RSSI、被动断线实验（LightBlue 关外设→App 感知+原因码）、10s 超时实验、幽灵设备 4s 消失验证
- [x] 验收题：connecting 为何自己维护（UI 状态≠链路状态）、连接的五种死法与流感知、status 133 与 stopScan 军规
- [x] 附加收获：FBP 2.x License 双轨授权（nonprofit/commercial）选型课

遗留伏笔：「离开页面即断开」策略第 7 课推翻；重连决策 = f(disconnectReason) 第 7 课兑现；MTU 默认 512 请求第 6 课回看。

### 第 4 课 —— ✅ 已验收（2026-07-05）
- [x] 代码：连接后自动 discoverServices（断线清空句柄表）、GattBrowser 服务浏览器（属性徽标/HEX+文本双显示/写入对话框含写类型开关）、core/hex.dart 纯函数 + 9 条单测、UUID 短名收敛到 core/gatt_names.dart
- [x] 实操：nRF Connect 自建 GATT server（Read+Write 特征），App 读初始值、写入并读回验证；排查「nRF Connect 配置页不刷新写入值」（配置页显示初始值，运行时状态看对端连接的 SERVER 子页/日志/读回验证）
- [x] 验收题：句柄不跨连接复用与 GATT 缓存坑（refresh()/Service Changed）、OTA 用 WNR + 应用层流控（链路层有 CRC 重传，丢在对端缓冲溢出）、GATT 只定容器不定语义

工程观念沉淀：UI 显示 ≠ 协议状态，调蓝牙以读回验证 + 抓日志为准。

### 第 5 课 —— ✅ 已验收（2026-07-05）
- [x] 代码：toggleNotify（先挂监听后开闸、cancelWhenDisconnected 托管、断线清订阅表）、core/heart_rate.dart（flags 位域解析 + RR 间期，7 条单测）、HeartRateChart（CustomPaint 自绘、120 样本环形缓存）
- [x] 实操：双向订阅（nRF Connect 心率服务 ↔ LightBlue 虚拟外设），曲线实时滚动；断连重连验证 CCCD 复位、需重新订阅
- [x] 验收题：setNotifyValue 两步（本地注册+写 CCCD 01 00）与安卓忘写 CCCD 经典 bug、Notify/Indicate 与两种写的四象限对称、0x2A37 帧逐字节解析（flags/BPM/RR 小端）

四象限选型表成型：Write Request（可靠指令）/ Write Command（高速下发）/ Indicate（可靠上报）/ Notify（高速上报）。重连必须重订阅——第 7 课状态机的必做项。

### 第 6 课 —— 📝 待验收（2026-07-22 编写）
- 代码：core/protocol/packet.dart（Packet / PacketCodec: crc16/encode/chunks / PacketAssembler 组包状态机）、features/protocol/（ProtocolSession + 控制台页），13 条 TDD 单测
- 讲义：lessons/lesson-06.md
- 待用户验收：真机用 nRF Connect GATT server 一写一通知，控制台发帧看对端字节、收回帧看解析/坏帧重同步 + 三道验收题

### 第 7 课 —— 📝 待验收（2026-07-22 编写）
- 代码：DeviceController 内嵌重连状态机（ReconnectPhase、区分主动/意外断开、指数退避、重连后 _resubscribeDesired 重建订阅）、core/backoff.dart（4 条单测）、DevicePage 自动重连开关与实时文案
- 讲义：lessons/lesson-07.md
- 待用户验收：意外掉线→退避重连→订阅自动恢复；主动断开不重连；放弃后手动重连 + 三道验收题

### 第 8 课 —— 📝 待验收（2026-07-22 编写）
- 代码：core/ble/ble_central.dart（抽象接口 + 中立模型）、real_ble_central.dart（FBP 防腐层）、mock_ble_central.dart（虚拟心率带/固件设备/故障注入）、features/demo/mock_demo_page.dart 离线演示页，mock_central 4 条全流程单测
- 讲义：lessons/lesson-08.md
- 待用户验收：模拟器零外设跑通离线演示（心率曲线 + 协议回帧 + 故障注入）+ 三道验收题

### 第 9 课 —— 📝 待验收（2026-07-22 编写）
- 代码：iOS Info.plist 加 UIBackgroundModes(bluetooth-central)、Android Manifest 加前台服务三权限、features/platform/platform_info_page.dart 双端差异信息页
- 讲义：lessons/lesson-09.md
- 待用户验收：平台信息页正确识别平台、iOS 后台连接实验（真机）+ 三道验收题

### 第 10 课 —— 📝 待验收（2026-07-22 编写）
- 代码：features/home/home_page.dart「设备管家」首页整合三入口，main.dart 首页切换
- 讲义：lessons/lesson-10.md（架构总览图 + A-E 五组全流程验收脚本）
- 待用户验收：A-E 清单双端真机（或离线兜底）全过 + 三道验收题

### 第 11 课（可选）—— 📝 待验收（2026-07-22 编写）
- 讲义：lessons/lesson-11.md（面试问答：生命周期/四象限/私有协议/稳定性/双端/进阶专题 + 30 秒电梯陈述），纯文档无代码
- 待用户验收：自测能脱稿讲一遍

—— 全部 6 课的代码质量门槛已过：flutter analyze 无告警、flutter test 40 条全绿、APK 构建通过。等用户逐课真机验收后改 ✅。

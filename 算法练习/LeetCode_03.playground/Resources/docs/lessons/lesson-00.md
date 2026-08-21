# 第 0 课：环境与项目初始化（0.5 课时）

## 本课目标

1. 项目跑通：wb_ble_app 在你的安卓手机和 iPhone 上都能启动。
2. 测试台搭好：另一台手机能扮演 BLE 外设。
3. 理解两件事：为什么蓝牙开发必须真机；为什么权限配置是双端两套逻辑。

## 一、为什么模拟器不能测蓝牙

- **iOS 模拟器**：CoreBluetooth 在模拟器上直接不可用（`CBCentralManager` 状态永远是 `.unsupported`）。模拟器没有蓝牙硬件栈，Apple 也从未桥接宿主 Mac 的蓝牙。
- **安卓模拟器**：新版模拟器有实验性的蓝牙透传，但极不稳定，企业开发没人用。
- **企业现实**：蓝牙团队人手至少一台安卓 + 一台 iPhone + 若干目标硬件。双端蓝牙栈行为差异大（扫描节流、后台策略、缓存机制），只测一端约等于没测。你的「一安卓 + 一 iPhone」正是标准配置。

## 二、我们的测试拓扑

企业场景 95% 是 **手机 App 做 Central（主机），硬件设备做 Peripheral（外设）**。没有硬件时，用另一台手机模拟外设：

```
┌─────────────────┐         BLE          ┌──────────────────────┐
│   手机 A         │ ◄──────────────────► │   手机 B              │
│   wb_ble_app    │   扫描/连接/读写/订阅   │   nRF Connect (安卓)  │
│   角色: Central  │                      │   LightBlue (iOS)    │
└─────────────────┘                      │   角色: Peripheral    │
                                         └──────────────────────┘
```

两台手机可以互换角色。注意：**iPhone 做外设时广播不带 MAC 地址且部分字段受限**（iOS 系统行为），所以模拟外设优先用安卓 + nRF Connect，功能最全。

### 需要安装的工具 App

| 手机 | App | 用途 |
|---|---|---|
| 安卓 | **nRF Connect for Mobile**（Nordic 出品，Play 商店） | 扫描分析 + GATT Server 模拟外设 + 广播自定义数据，蓝牙开发第一神器 |
| iPhone | **LightBlue**（Punch Through 出品，App Store） | iOS 端扫描分析 + 创建虚拟外设 |

> **第三条路（本仓库特有）**：根目录的 [`ESP-32-BLE/`](../../../ESP-32-BLE/docs/PROGRESS.md) 是配套的 ESP32 固件课程，跑起来就是一台**真外设**（真实广播、真 GATT 表、真私有协议）。它的第 1 课（广播）可替代本课程第 2 课的扫描目标，第 2 课（GATT 服务端）可替代第 3–5 课的连接/读写/订阅目标，第 3 课（固件侧私有协议）正是本课程第 6 课的对端。手机模拟外设胜在随时可用，真固件胜在能复现「固件缓冲区攒帧」「重启丢连接」这类模拟器造不出来的现象——两者都留着。

## 三、权限配置（本课已完成，代码里看）

### Android —— [AndroidManifest.xml](../../android/app/src/main/AndroidManifest.xml)

Android 12（API 31）是分水岭，企业开发的第一坑：

| | Android ≤ 11 | Android 12+ |
|---|---|---|
| 扫描 | `BLUETOOTH` + 运行时**定位**权限（历史原因：BLE 广播可做室内定位） | `BLUETOOTH_SCAN`（运行时） |
| 连接 | `BLUETOOTH` / `BLUETOOTH_ADMIN` | `BLUETOOTH_CONNECT`（运行时） |

- 旧权限加 `android:maxSdkVersion="30"`，只在老系统上生效。
- `BLUETOOTH_SCAN` 上声明了 `neverForLocation`：承诺不用扫描结果推位置，就**不再需要定位权限**。代价：系统会过滤掉 iBeacon 等定位类广播。企业里做普通设备连接都这么配；做室内定位/Beacon 的产品则不能加。

### iOS —— [Info.plist](../../ios/Runner/Info.plist)

只需一条：`NSBluetoothAlwaysUsageDescription`（用途文案）。**没有它，App 一调蓝牙 API 直接闪退**，这是 iOS 蓝牙开发最经典的第一次崩溃。iOS 不区分扫描/连接权限，用户只面对一次「是否允许使用蓝牙」弹窗。

## 四、动手任务（你的验收作业）

1. 安卓手机装 **nRF Connect**，iPhone 装 **LightBlue**。
2. 分别在两台真机上运行项目：
   ```bash
   cd ~/Desktop/wb_ble_app/app
   flutter devices          # 确认两台手机都被识别（iPhone 需信任电脑；首跑需在 Xcode 里配置签名 Team）
   flutter run -d <设备id>
   ```
3. 打开 nRF Connect 的 SCANNER 页随便扫一扫，感受一下周围的 BLE 广播世界（第 1 课我们会逐字段解读它显示的内容）。

三项都完成后告诉我，勾掉 [PROGRESS.md](../PROGRESS.md) 里的验收项，进入第 1 课。

## 本课思考题（下课口头回答）

1. 为什么 Android 12 之前扫描蓝牙要定位权限，而 iOS 从来不要？
2. `neverForLocation` 省掉了定位权限，代价是什么？什么产品不能加它？

## 高频面试题

**Q：蓝牙功能怎么做自动化测试？总不能每次都插真机吧。**
分两层答。① **真机不可替代**：iOS 模拟器里 `CBCentralManager` 状态恒为 `.unsupported`（没有蓝牙硬件栈），安卓模拟器的蓝牙透传不稳定，任何涉及射频、系统权限、后台策略的验证必须真机。② **但绝大部分代码不该依赖真机**：把协议编解码、数据解析、重连退避这类纯逻辑下沉成纯函数，再把 BLE 能力抽象成接口做 Mock 实现，CI 上就能跑全流程（本项目 40 条单测全部零硬件，见第 6/8 课）。真机只留给「链路行为」这一层，用手动验收脚本覆盖（第 10 课）。

**Q：Android 蓝牙权限怎么配？12 是个什么分水岭？**
Android ≤ 11：清单里 `BLUETOOTH` + `BLUETOOTH_ADMIN`（安装期权限），但**扫描要额外申请运行时定位权限** `ACCESS_FINE_LOCATION`，且系统的定位总开关必须打开，否则扫描静默返回空列表（不报错，最坑的一种失败）。Android 12（API 31）起拆成三个运行时权限：`BLUETOOTH_SCAN`（扫描）、`BLUETOOTH_CONNECT`（连接/读设备名）、`BLUETOOTH_ADVERTISE`（做外设），旧权限要加 `android:maxSdkVersion="30"` 免得在新系统上冗余。工程上两套都要写，因为线上一定还有老机器。

**Q：`neverForLocation` 是干什么的？**
声明在 `BLUETOOTH_SCAN` 上的一个标记，含义是「我承诺不用扫描结果推断用户位置」，代价是系统会把 iBeacon 等定位类广播从结果里过滤掉，收益是**不用再申请定位权限**（少一个吓人的授权弹窗，转化率差别很大）。做设备连接类产品该加；做室内定位、导购、资产追踪的产品不能加。

**Q：iOS 侧要配什么？漏了会怎样？**
`Info.plist` 里的 `NSBluetoothAlwaysUsageDescription`（用途文案）。**漏了不是权限被拒，是 App 一碰蓝牙 API 直接被系统 kill**（TCC 崩溃），这是 iOS 蓝牙开发第一次踩的坑。兼容 iOS 12 及更早还要带上 `NSBluetoothPeripheralUsageDescription`。iOS 不区分扫描/连接权限，用户只面对一次弹窗；被拒后 `adapterState` 变 `unauthorized`，App 只能引导去「设置」页，无法二次弹窗。

**Q：为什么 iOS 只有一个蓝牙权限，Android 要牵扯定位？**
因为两家把「蓝牙能不能定位」这件事划在了不同的地方。BLE 广播（尤其商场铺满的 iBeacon）足以做室内定位，Google 索性把「能扫蓝牙」等同于「能定位」；Apple 则在 API 层就不给 App 拿外设 MAC 和原始 iBeacon 数据（iBeacon 被单独关进 CoreLocation），CoreBluetooth 本身构不成定位能力，自然不需要定位权限。

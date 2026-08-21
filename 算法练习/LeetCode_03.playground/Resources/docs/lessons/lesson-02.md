# 第 2 课：扫描实战（1 课时）

> 本课起开始写代码。目标：App 能扫到并列出另一台手机模拟的外设，理解权限、节流、结果流三大工程要点。

## 一、权限：代码里「没写」的那部分去哪了

第 0 课我们在 AndroidManifest 里配了两套权限，本课不引入 permission_handler——因为读 flutter_blue_plus 安卓端源码（`FlutterBluePlusPlugin.java` 的 `onMethodCall("startScan")`）会发现它在扫描前自动做了三件事：

1. **检查定位服务开关**（`androidCheckLocationServices`，默认 true）：Android ≤ 11 上系统定位总开关没开时，BLE 扫描静默返回空结果——这是企业开发著名深坑，插件直接帮你拦下来报错。
2. **按系统版本申请运行时权限**：API 31+ 申请 `BLUETOOTH_SCAN` + `BLUETOOTH_CONNECT`；API ≤ 30 申请 `ACCESS_FINE_LOCATION`。第一次扫描时你会看到系统弹「允许 xx 查找附近的设备」（Android 12+ 的文案）。
3. **检查蓝牙适配器状态**，没开直接报错。

**工程启示**：插件帮你申请 ≠ 你不用管。权限被永久拒绝后 `startScan` 会抛错，UI 必须接住并引导用户去设置页——所以 Controller 里 `try/catch` 不是防御性套路，是必须的业务分支。iOS 则简单：首次触发蓝牙 API 时系统自动弹一次授权框（文案就是 Info.plist 里那句），拒绝后 `adapterState` 变 `unauthorized`。

## 二、扫描三条流

flutter_blue_plus 把扫描建模成三条广播流 + 一个动作，我们的 `ScanController` 就是订阅它们再转成 UI 状态：

| API | 是什么 | 用法要点 |
|---|---|---|
| `FlutterBluePlus.adapterState` | 蓝牙开关状态流 | 关蓝牙时扫描自动停，UI 要显示「请打开蓝牙」空态 |
| `FlutterBluePlus.scanResults` | **累积快照流**：每次发射的是"本轮扫描至今发现的全部设备"列表 | 与 `onScanResults`（逐个发射）二选一，列表 UI 用前者省事 |
| `FlutterBluePlus.isScanning` | 是否正在扫描 | 驱动按钮的 开始/停止 状态，别自己维护 bool |
| `FlutterBluePlus.startScan(...)` | 动作 | `withServices` 按服务 UUID 过滤；`timeout` 自动停止；`continuousUpdates: true` 才会持续刷新 RSSI |

三个必知行为：

- **去重**：默认同一设备只上报一次（广播内容变了才再报）。想要 RSSI 实时跳动必须 `continuousUpdates: true`（我们开了，代价是回调频繁，生产项目常配 `continuousDivisor` 降频）。
- **列表不会自动"减员"**：设备关机走远，它仍留在累积列表里。想自动移除要配 `removeIfGone`。企业 App 的扫描页几乎都有这个需求，否则用户看着一堆"幽灵设备"。
- **安卓扫描节流**：30 秒内启动扫描超过 5 次，系统直接给你静默降级/拒绝（logcat 有 `App 'xxx' is scanning too frequently`）。所以扫描要带 `timeout`、按钮要防连点，别写"进页面就无限扫"。

## 三、扫描结果里有什么

`ScanResult`：`device`（`remoteId` + `platformName`）、`rssi`、`advertisementData`、`timeStamp`。

`AdvertisementData` 就是第 1 课广播包的解析产物：`advName` / `connectable` / `serviceUuids` / `manufacturerData`（`Map<厂商ID, 字节>`）/ `serviceData` / `txPowerLevel`。

两个双端差异（第 1 课理论的代码印证）：

- `device.remoteId`：安卓 = 真 MAC（`AA:BB:CC:DD:EE:FF`），iOS = 系统生成的 UUID，换台 iPhone 就不同 → 跨平台"设备唯一标识"必须自己从广播（如厂商数据）或 GATT 里取。
- 名字有三个来源：广播里的 `advName`、系统缓存的 `platformName`、连接后 GATT 里的 Device Name。显示优先级建议 `advName` → `platformName` → 占位符。

## 四、本课代码结构

```
lib/
├── main.dart                        # App 入口，home 指向扫描页
└── features/scan/
    ├── scan_controller.dart         # ChangeNotifier：订阅三条流 → UI 状态
    └── scan_page.dart               # 扫描列表 UI（空态/错误态/结果列表/过滤开关）
```

依赖方向 View → Controller → flutter_blue_plus，Controller 不 import Flutter Widget，后面第 8 课抽接口做 Mock 时它几乎不用改。

UI 细节里的工程判断：

- **列表不按 RSSI 实时排序**：RSSI 每秒都在抖，实时排序 = 条目上下乱跳没法点。企业做法：按发现顺序稳定排列，RSSI 只作为条目内的信号图标。
- 过滤做成两个开关：「隐藏无名设备」（环境里 90% 的广播是无名的耳机/信标，噪音）和「只看心率服务」（`withServices: [Guid("180D")]`，在系统层过滤，比拿到结果再筛更省电）。

## 五、动手任务

1. iPhone：LightBlue 开启 Heart Rate 虚拟外设（前台、亮屏）。
2. 安卓：`flutter run` 装上 App → 点扫描 → **观察第一次的系统权限弹窗长什么样**（这是 Android 12+ 的「附近的设备」权限，不是定位）。
3. 找到心率外设，打开「只看心率服务」开关验证过滤，观察 RSSI 随距离变化。
4. 换边：安卓开 nRF Connect → ADVERTISER 页新建一条广播（随便加个 Complete Local Name）；iPhone 上 `flutter run` 本 App 扫它，对比 iOS 的授权弹窗与 remoteId 形态。

> 可选（真固件）：跑起 [`ESP-32-BLE/`](../../../ESP-32-BLE/docs/PROGRESS.md) 第 1 课的固件，扫描列表里会出现 `WB-ESP32-xxxx`，展开能看到它自定义的 Flags / 服务 UUID / 设备名 + Scan Response 里的厂商数据——比手机模拟外设更接近真实产品的广播形态。

## 验收

1. App（安卓端）扫到 LightBlue 心率外设，服务过滤开关工作正常。
2. App（iOS 端）扫到 nRF Connect 的自定义广播。
3. 回答：① 扫描列表里同一台设备，安卓和 iOS 显示的 remoteId 有什么本质不同？对「记住已绑定设备」功能意味着什么？② 为什么扫描必须带 timeout、按钮要防连点？③ `scanResults` 列表里的设备关机了，条目会消失吗？怎么让它消失？

## 高频面试题

**Q：用户反馈「扫不到设备」，你怎么排查？**（几乎必问的开放题，按层次答才显专业）
从下往上分五层，逐层排除：① **对端**——外设真的在广播吗？是不是已被别的手机连上了（多数外设一旦被连接就停播）？② **本机开关**——蓝牙适配器状态（`adapterState`）、Android ≤ 11 还要看**系统定位总开关**（关着时扫描静默返回空，不报错）；③ **权限**——Android 12+ 的 `BLUETOOTH_SCAN` 是否被拒/被永久拒绝，iOS 是否 `unauthorized`；④ **过滤条件**——`withServices` 填的 UUID 和固件广播的对不上，或者 iOS 后台扫描没带过滤（后台不带过滤扫不到任何东西）；⑤ **系统限流**——安卓 30 秒内启动扫描超过 5 次会被静默降级，Android 7+ 息屏时不带 filter 的扫描直接不上报。定位手段：安卓看 logcat 有没有 `scanning too frequently`，或直接用 nRF Connect 交叉验证（nRF 扫得到 = 问题在你的 App，扫不到 = 问题在外设/环境）。

**Q：安卓的扫描节流规则知道吗？**
两条最常见：① **30 秒内同一 App 启动扫描不能超过 5 次**，超了系统静默丢弃（返回成功但没有回调，最难查的一类 bug）；② **Android 7.0 起，息屏状态下不带 ScanFilter 的扫描不会上报结果**。工程对策：扫描一定带 `timeout` 自动停、按钮做防连点、进页面不要「无限扫」，需要长期发现就用「带 filter + 低功耗模式 + 间歇扫描」而不是常开。此外 `ScanSettings` 的模式（LOW_POWER / BALANCED / LOW_LATENCY）决定占空比，前台找设备用低延迟、后台监听用低功耗。

**Q：`scanResults` 里的设备关机了，条目会自己消失吗？**
不会。BLE 没有「设备离开」事件，扫描结果是**只增不减的累积快照**，所以扫描页会堆一堆「幽灵设备」。要靠超时淘汰：本项目用 `removeIfGone: 4s`（超过 4 秒没再收到广播就移除），底层原理就是拿每条结果的 `timeStamp` 做老化。

**Q：默认为什么 RSSI 不刷新？`continuousUpdates` 是什么？**
默认对同一设备只上报一次（广播内容变化才再报），所以 RSSI 停在第一次的值。开 `continuousUpdates: true` 才会持续上报，代价是回调频繁、耗电和 UI 压力上升，生产项目常配 `continuousDivisor` 降频。

**Q：能用 RSSI 测距吗？**
只能粗分「很近 / 一般 / 很远」，不能当距离用。RSSI 受发射功率、天线方向、遮挡（人体尤其）、多径反射影响极大，同一距离抖动十几 dB 很正常。要用也必须：拿到设备的 TxPower 做路径损耗估算 + 多次采样滑动平均/卡尔曼滤波 + 只做阈值判断（比如「靠近自动连接」）。**面试千万别说「用 RSSI 算出精确距离」**，这是明显的外行答案；真要定位得靠 UWB 或多锚点的 iBeacon 方案。

**Q：按服务 UUID 过滤，为什么要交给系统而不是自己筛？**
`withServices` 会下沉到系统/芯片层过滤，不匹配的广播根本不唤醒 App 进程——省电、省回调、还能绕过安卓息屏不上报的限制；拿到全部结果再在 Dart 层筛，功耗和唤醒次数都白花。iOS 后台扫描更是**必须**带服务 UUID 过滤，否则一个结果都收不到。

**Q：跨平台的「设备唯一标识」怎么定？**
`device.remoteId` 安卓是真 MAC、iOS 是系统生成的 UUID（换台 iPhone 就变），所以它只能当**本次会话内的句柄**，不能做业务主键。正解：让固件把序列号写进广播的厂商数据（不连接就能识别）或某条 GATT 特征（连上后读一次），App 用它做绑定记录的 key。这也是第 8 课把接口 deviceId 定义成 `String` 的原因——业务层根本不需要知道底下是 MAC 还是 UUID。

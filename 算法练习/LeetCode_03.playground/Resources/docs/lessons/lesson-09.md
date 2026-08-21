# 第 9 课：双端平台差异与后台（1 课时）

> 前 8 课 FBP 帮我们抹平了大部分双端差异。这课我们掀开地毯，看清 iOS 和 Android 在底层到底哪里不一样——尤其是「后台还能不能跑蓝牙」这个决定产品形态的问题。面试问「iOS 和 Android 蓝牙有什么区别」，这课就是答案库。

## 一、前 8 课已经踩过的双端差异（复习即得分）

| 维度 | iOS | Android |
|---|---|---|
| 设备标识 | 系统生成 UUID，换机即变，拿不到 MAC（第 2 课） | 真 MAC，跨机稳定（RPA 设备除外） |
| CCCD 订阅 | `setNotifyValue` 一步，看不到 0x2902（第 5 课） | 需 `setCharacteristicNotification` + 手写 CCCD |
| MTU | 系统自动协商，App 不能指定 | 可 `requestMtu`，最高 517 |
| 广播名 | 后台广播 LocalName 丢失（第 1 课） | 后台广播能力更完整 |
| 权限模型 | 一个蓝牙权限，运行时弹一次 | 12 前后两套，还牵扯定位（第 2 课） |

App 里新增了「双端差异与后台」页（扫描页右上角 ⓘ 图标），高亮当前平台并列出这张对照——[platform_info_page.dart](../../lib/features/platform/platform_info_page.dart)。

## 二、后台模型：两套完全不同的哲学

这是本课的核心，也是最能体现「懂不懂平台」的地方。

### iOS：系统代管，事件唤醒

iOS 不给 App「一直在后台跑」的权力，但给了一套**系统代管**机制：

1. **`bluetooth-central` 后台模式**：App 退到后台后，系统替它维持已有连接。设备来通知时，系统把 App **唤醒约 10 秒**处理，然后再度挂起。开启方式（本课已配 [Info.plist](../../ios/Runner/Info.plist)）：
   ```xml
   <key>UIBackgroundModes</key>
   <array><string>bluetooth-central</string></array>
   ```
   代价：**后台扫描必须带服务 UUID 过滤**、间隔被拉长、`allowDuplicates` 失效。我们第 2/8 课的扫描接口都留了 `services` 过滤参数，正是为此。

2. **State Restoration（被杀后复活）**：App 被系统回收后，系统**代持**蓝牙会话；目标设备一有事件，系统在后台重启 App 并归还会话。需要给 `CBCentralManager` 一个 restore identifier 并实现 `willRestoreState` 回调（原生 Swift 代码，Flutter 侧 FBP 对此支持有限，长连接产品往往要写平台通道）。

### Android：没人代管，自己起前台服务

Android 的哲学相反：**默认息屏/后台就限制甚至挂起你的蓝牙活动**，要保活得自己扛一个**前台服务（Foreground Service）**——一个带常驻通知栏的服务，等于告诉系统「用户知道我在跑，别杀我」。本课已在 [AndroidManifest](../../android/app/src/main/AndroidManifest.xml) 声明了所需权限：

- `FOREGROUND_SERVICE`（Android 9+）
- `FOREGROUND_SERVICE_CONNECTED_DEVICE`（Android 14+ 要求声明服务类型）
- `POST_NOTIFICATIONS`（Android 13+ 常驻通知的运行时权限）

> 真正的 Service 类要通过平台通道或插件（如 `flutter_foreground_task`）落地。本教学工程只做**配置声明 + 讲清原理**，不落地 Service 代码——面试能讲清「为什么要前台服务、要哪些权限」就达标。

## 三、两条必须知道的「铁律」（面试高频陷阱）

1. **iOS：用户上滑手动杀 App，State Restoration 也救不回来**。这是系统政策不是 bug。产品设计上只能引导用户别杀。且**模拟器不支持状态恢复，必须真机验证**。
2. **Android：前台服务只挡得住原生系统，挡不住国产 ROM**。小米/华为/OPPO 的后台管控和电量优化会额外杀进程，必须引导用户把 App 加入**电池优化白名单**，否则前台服务配得再对也白搭。这是国内蓝牙产品的头号线上问题。

## 四、长连接产品的现实策略

手环、血糖仪这类要 7×24 保连的产品，双端的标准组合：

- **iOS**：`bluetooth-central` + State Restoration + **固件周期性发通知**（心跳既是业务数据也是拉活信号）+ 接受「用户杀 App 后无解」。
- **Android**：前台服务 + 电池优化白名单引导 + 断线自动重连（第 7 课）兜底。

共同点：**都依赖第 7 课的重连状态机**——无论哪端，被系统打断后能自愈才是根本。

## 五、动手任务

1. App 扫描页右上角点 ⓘ → 进「双端差异与后台」页，确认它正确显示了你当前手机的平台（iPhone 显示 iOS，安卓显示 Android），读一遍对照表和两条铁律。
2. **iOS 后台连接实验**（需真机）：iPhone 连上 LightBlue 心率外设、订阅心率，把 App 划到后台但**不上滑杀掉** → 过十几秒切回来，看连接是否还在、曲线是否续上（bluetooth-central 生效的表现）。
3. **对照实验**：把 iPhone 上的 App 上滑杀掉 → 连接断开，印证「杀 App 无解」。
4. 检查配置：`app/ios/Runner/Info.plist` 里的 `UIBackgroundModes`、`app/android/.../AndroidManifest.xml` 里的前台服务权限，对照讲义确认都在。

## 验收

1. 双端配置就位：iOS 的 `UIBackgroundModes(bluetooth-central)`、Android 的前台服务三权限，都能在文件里指出。
2. 平台信息页在你的手机上正确识别平台。
3. 回答：① iOS 和 Android 的后台蓝牙哲学有何本质不同？各自靠什么机制保活？② iOS 的 State Restoration 在什么情况下也救不回来？③ 为什么 Android 上「前台服务配好了还是被杀」？怎么办？

## 高频面试题

**Q：iOS 和 Android 的 BLE 最大区别是什么？**（列 4–5 条，每条带一句「所以…」）
① **设备标识**——iOS 给系统生成的 UUID、拿不到 MAC 且换机即变，Android 给真 MAC，**所以**跨端绑定要用广播里的序列号而不是地址；② **CCCD**——iOS 一步订阅且不暴露 0x2902，Android 要 `setCharacteristicNotification` + 手写 CCCD 两步，**所以**安卓原生有「本地在听、远端没开闸」的经典 bug；③ **MTU**——iOS 系统自动协商 App 不能指定，Android 可 `requestMtu` 最高 517，**所以**分包上限要运行时取、不能写死；④ **权限**——iOS 一个权限弹一次，Android 12 前后两套还牵扯定位服务总开关，**所以**「扫不到设备」在两端的排查路径完全不同；⑤ **后台**——iOS 系统代管，Android 要自己扛前台服务（下题）。

**Q：iOS 和 Android 的后台蓝牙哲学有什么本质不同？**
**iOS 是「系统代管、事件唤醒」**：App 不被允许一直跑，但声明 `UIBackgroundModes: bluetooth-central` 后，系统会替你维持已有连接，设备来通知时把 App 唤醒约 10 秒处理再挂起。代价是**后台扫描必须带服务 UUID 过滤**、扫描间隔被拉长、`allowDuplicates` 失效、广播里的 LocalName 也拿不到。**Android 是「没人代管、自己扛」**：默认息屏/后台就限制甚至挂起蓝牙活动，要保活得起一个**前台服务**（带常驻通知栏），等于向系统和用户声明「我在跑」。需要声明 `FOREGROUND_SERVICE`、Android 14+ 还要 `FOREGROUND_SERVICE_CONNECTED_DEVICE` 服务类型、Android 13+ 常驻通知要 `POST_NOTIFICATIONS` 运行时权限。

**Q：iOS 的 State Restoration 是什么？什么情况下也救不回来？**
给 `CBCentralManager` 一个 restore identifier 后，App 被系统回收时蓝牙会话由系统**代持**，目标设备一有事件（连上、断开、通知），系统会在后台**重启 App** 并通过 `willRestoreState` 把会话还给你——这是长连接产品能做到「App 被杀了手环按一下还能上报」的关键。两个必答的限制：① **用户上滑手动杀掉 App，恢复机制彻底失效**，这是系统政策不是 bug，产品上只能引导用户别杀；② **模拟器不支持状态恢复，必须真机验证**。另外 Flutter 侧插件对它支持有限，长连接产品往往要写平台通道用原生实现。

**Q：Android 上前台服务配好了还是被杀，怎么办？**
因为**前台服务只挡得住原生 AOSP 的策略，挡不住国产 ROM**。小米/华为/OPPO/vivo 都有额外的后台管控和「智能省电」，会无视前台服务直接清理进程。这是国内蓝牙产品的头号线上问题。对策是组合拳：① 引导用户把 App 加入**电池优化白名单**和「自启动/后台运行」允许列表（各家设置路径不同，成熟产品会做**分厂商引导页**）；② 前台服务通知要有真实价值（显示连接状态），别做成用户想划掉的骚扰；③ 兜底永远是**自动重连状态机**（第 7 课）——被杀之后进程重启还能自己连回来，比死磕保活更现实。补一句 Doze/待机分桶也会拉长后台扫描间隔，长期后台发现设备本来就不该指望高频扫描。

**Q：长连接产品（手环、血糖仪）双端的标准方案是什么？**
**iOS**：`bluetooth-central` 后台模式 + State Restoration + **固件周期性发通知**（心跳既是业务数据也是把 App 拉活的信号）+ 接受「用户上滑杀 App 后无解」这个前提。**Android**：前台服务 + 电池优化白名单引导 + 断线自动重连兜底。**共同点是两端都依赖重连状态机**——无论哪端，被系统打断后能自愈才是根本，保活是尽力而为、自愈是必须做到。

**Q：权限被用户永久拒绝了怎么处理？**
不能再弹系统框（安卓两次拒绝后 `shouldShowRequestPermissionRationale` 返回 false，iOS 更是只有第一次），只能：① UI 上给明确的空态文案说明「为什么需要这个权限、不给会缺什么功能」；② 提供一键跳转到**应用设置页**的入口；③ 从设置页回来时重新检查状态并自动恢复流程。工程上要把「权限被拒」当成**一个正常的业务分支**来设计，而不是 catch 住打个日志——这也是第 2 课强调 Controller 里 try/catch 不是防御性套路的原因。

**Q：蓝牙 App 上架有什么合规要求？**
① **用途说明要具体**——iOS 的 `NSBluetoothAlwaysUsageDescription` 写「用于连接您的 XX 设备读取运动数据」，写「需要蓝牙权限」这类空话会被审核打回；② **iOS 隐私清单（Privacy Manifest）**——iOS 17 起上架要求 App 和三方 SDK 提供 `PrivacyInfo.xcprivacy` 声明数据收集与 API 使用，升级插件版本时要确认它已提供；③ **Android 12+ 的 `neverForLocation`**——不做定位就声明它，能少要一个定位权限，对审核和用户转化都有利；做定位类产品则要如实声明用途；④ 采集的设备数据（心率等健康数据）在隐私政策里要如实披露，涉及健康数据的还要看目标市场的额外要求。

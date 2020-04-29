#  LRVCExtend
**这个模块针对 ViewController 进行了一些有帮助的扩展**

**可以帮助你更快的实现需求**

*使用*
```objc
  //通过 Cocoapods 安装
  pod 'LRFactory/LRVCExtend'

  //引入头文件
  #import <LRVCExtend.h>

```

*具体扩展内容如下*

---
###  LRFAppear

**针对 Appear， Disappear 进行的扩展，可以帮助你判断该次 Appear 是否是第一次 Appear，该次 Disappear 是否是最后一次 Disappear**

你只需要在子类按需重写以下这三个方法并添上你的相关业务。
```objc
// 需子类重写， 默认空实现
- (void)lrf_viewWillAppearFirstTime:(BOOL)animated;

- (void)lrf_viewWillDisappearForever:(BOOL)animated;

- (void)lrf_viewDidDisappearForever:(BOOL)animated;
```

当然，这里也提供了 block 的方式，让你可以随时可以添加业务。你只需要在需要的时候添加 action 就可以完成。
```objc
- (void)lrf_addActionWhileViewWillAppear:(void(^)(BOOL animated, BOOL isFirstTime))action;

- (void)lrf_addActionWhileViewDidAppear:(void(^)(BOOL animated))action;

- (void)lrf_addActionWhileViewWillDisappear:(void(^)(BOOL animated, BOOL isForever))action;

- (void)lrf_addActionWhileViewDidDisappear:(void(^)(BOOL animated, BOOL isForever))action;
```

*例：*
```objc
UIViewController *vc = [[UIViewController alloc] init];
// 当 vc willAppear 的时候将会调用打印方法
[vc lrf_addActionWhileViewWillAppear:^(BOOL animated, BOOL isFirstTime) {
    NSLog(@"ViewWillAppear isFirstTime:%d", isFirstTime);
}];
```
---

###  LRFGesture

**提供了一个属性，可以在有导航的页面里，让你很方便的决定一个页面是否支持向右滑动返回上一个页面**

```objc
@property (nonatomic, assign) BOOL lrf_canGesturePop;//手势右滑返回, 默认YES
```
当设置为 YES 时，支持右滑返回，默认 YES<br>
当设置为 NO 时，禁用右滑返回

*例：*
```objc
UIViewController *vc = [[UIViewController alloc] init];
// 禁用 vc 的右滑返回
vc.lrf_canGesturePop = NO;
```

---

###  LRFPresent

**对 present dismiss 方法进行扩展，可以方便的添加额外信息供你使用，并提供 willDismiss 及 didDismiss 的block供你使用**

```objc
/**
 *  弹出界面，带弹出界面消失的回调信息
 */
- (void)lrf_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ __nullable)(void))completion willDismissCallback:(void(^ __nullable)(id _Nullable info))willDismissCallback didDismissCallback:(void(^ __nullable)(id _Nullable info))didDismissCallback;

/**
 *  消失界面，带回调信息
 */
- (void)lrf_dismissViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion info:(id _Nullable)info;
```

*例：*
```objc

// present 视图
[vcA lrf_presentViewController:vcB animated:YES completion:^{
    NSLog(@"completion");
} willDismissCallback:^(NSDictionary * _Nullable info) {
    NSLog(@"willDismissCallback %@", info);
} didDismissCallback:^(NSDictionary * _Nullable info) {
    NSLog(@"didDismissCallback %@", info);
}];

// dismiss 视图
[vcB lrf_dismissViewControllerAnimated:YES completion:^{
    NSLog(@"completion");    
} info:@{@"info":@"something interesting"}];


```

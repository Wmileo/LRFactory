#  LRVCExtend
**针对 ViewController 进行了一些有帮助的扩展**

**可以帮助你更快的实现需求**

*通过 cocoapods 安装*
```
 pod 'LRFactory/LRVCExtend'
```

*具体扩展内容如下*

---
###LRFAppear

**针对 Appear， Disappear 进行的扩展，可以帮助你判断该次 Appear 是否是第一次 Appear，该次 Disappear 是否是最后一次 Disappear**

```objc
// 需子类重写， 默认空实现
- (void)lrf_viewWillAppearFirstTime:(BOOL)animated;

- (void)lrf_viewWillDisappearForever:(BOOL)animated;

- (void)lrf_viewDidDisappearForever:(BOOL)animated;
```
你只需要在子类重写这三个方法并添上你的相关业务。

```objc
- (void)lrf_addActionWhileViewWillAppear:(void(^)(BOOL animated, BOOL isFirstTime))action;

- (void)lrf_addActionWhileViewDidAppear:(void(^)(BOOL animated))action;

- (void)lrf_addActionWhileViewWillDisappear:(void(^)(BOOL animated, BOOL isForever))action;

- (void)lrf_addActionWhileViewDidDisappear:(void(^)(BOOL animated, BOOL isForever))action;
```
当然，这里也提供了 block 的方式，让你可以随时可以添加业务。你只需要在需要的时候添加 action 就可以完成，像下面的例子一样。

*例：*
```objc
UIViewController *vc = [[UIViewController alloc] init];
// 当 vc willAppear 的时候将会调用打印方法
[vc lrf_addActionWhileViewWillAppear:^(BOOL animated, BOOL isFirstTime) {
    NSLog(@"ViewWillAppear isFirstTime:%d", isFirstTime);
}];
```
---

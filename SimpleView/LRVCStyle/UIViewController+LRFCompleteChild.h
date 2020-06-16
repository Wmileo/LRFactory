//
//  UIViewController+LRFCompleteChild.h
//  SimpleView
//
//  Created by leo on 2020/6/16.
//  Copyright © 2020 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LRFCompleteChild)

// 当自定义父视图时，需进行注册，然后在加载子视图的时候对子视图进行 hook 操作： lrf_hookAction
+ (void)lrf_registerParentViewController:(Class)viewControllerClass;

// 添加 hook 操作
+ (void)lrf_registerHookAction:(void(^)(UIViewController *vc))action;

// 一个实例永远只会执行一次 hook 操作
- (void)lrf_hookAction;

// 是否是完整子视图
@property (nonatomic, assign) BOOL lrf_isCompleteChildViewController;

@end

NS_ASSUME_NONNULL_END

//
//  UIViewController+BackButtonStyle.m
//  SimpleView
//
//  Created by ileo on 16/5/10.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+BackButtonStyle.h"
#import "UIView+Sizes.h"
#import "Aspects.h"

@interface UIViewController() <UIGestureRecognizerDelegate>

@end

@implementation UIViewController (BackButtonStyle)

+(void)configViewControllerGesturePopBack{
    [UINavigationController aspect_hookSelector:@selector(initWithRootViewController:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UINavigationController *navC = invocation.target;
        navC.interactivePopGestureRecognizer.delegate = navC;
    } error:NULL];
    [UINavigationController aspect_hookSelector:@selector(pushViewController:animated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UINavigationController *navC = invocation.target;
        navC.interactivePopGestureRecognizer.enabled = NO;
    } error:NULL];
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UIViewController *vc = invocation.target;
        if (vc.navigationController) {
            vc.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    } error:NULL];
}

#pragma mark - 右滑返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = ((UINavigationController *)self).visibleViewController;
        if ([vc respondsToSelector:@selector(viewControllerShouldGesturePopBack)]) {
            return [vc performSelector:@selector(viewControllerShouldGesturePopBack)];
        }
        return ((UINavigationController *)self).viewControllers.count != 1;
    }
    return NO;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

@end

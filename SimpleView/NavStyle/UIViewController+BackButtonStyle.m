//
//  UIViewController+BackButtonStyle.m
//  SimpleView
//
//  Created by ileo on 16/5/10.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+BackButtonStyle.h"
#import "NSObject+Block.h"
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

static NSDictionary *backItemIdentifications;

+(void)configBackItemIdentifications:(NSDictionary *(^)())identifications{
    backItemIdentifications = identifications();
}

-(instancetype)navSetupBackItemWithIdentification:(NSString *)identification{
    NSArray *backItems = backItemIdentifications[identification];
    __weak __typeof(self) wself = self;
    [backItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj.customView;
        if ([view isKindOfClass:[UIButton class]]) {
            if ([wself respondsToSelector:@selector(clickOnBackItem)]) {
                [view onlyHangdleUIControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
                    [wself performSelector:@selector(clickOnBackItem)];
                }];
            }else{
                [view onlyHangdleUIControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
                    [wself.navigationController popViewControllerAnimated:YES];
                }];
            }
        }
    }];
    if (backItems) {
        [self.navigationItem setLeftBarButtonItems:backItems];
    }
    return self;
}

-(NSString *)navLastTitle{
    if (self.navigationController) {
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index > 0) {
            return (self.navigationController.viewControllers[index - 1]).title;
        }
    }
    return nil;
}

#pragma mark - 右滑返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = ((UINavigationController *)self).visibleViewController;
        if ([vc respondsToSelector:@selector(viewControllerShouldGesturePopBack)]) {
            return (BOOL)[vc performSelector:@selector(viewControllerShouldGesturePopBack)];
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

//
//  UIViewController+NavBackgroundStyle.m
//  SimpleView
//
//  Created by ileo on 16/5/12.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+NavBackgroundStyle.h"
#import "UIViewController+SimpleNavigation.h"
#import "UIView+SimpleFactory.h"
#import "UIView+Sizes.h"
#import <objc/runtime.h>
#import "Aspects.h"

@implementation UIViewController (NavBackgroundStyle)

+(void)configNavBackgroundStyle{

    //去掉导航栏默认背景
    [UINavigationController aspect_hookSelector:@selector(initWithRootViewController:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UINavigationController *navC = invocation.target;
        [navC.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                [obj setHidden:YES];
                *stop = YES;
            }
        }];
    } error:NULL];
    
    //添加自定义导航栏背景
    [UIViewController aspect_hookSelector:@selector(viewWillLayoutSubviews) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UIViewController *vc = invocation.target;
        if (vc.navigationController) {
            [vc.view bringSubviewToFront:vc.navView];
        }
    } error:NULL];
    
}

static char keyNavView;

-(UIView *)navView{
    UIView *vc = objc_getAssociatedObject(self, &keyNavView);
    if (!vc) {
        UIColor *color;
        if ([self respondsToSelector:@selector(navBackgroundColor)]) {
            color = [self performSelector:@selector(navBackgroundColor)];
        }else{
            color = [UIViewController navBackgroundColor];
        }
        vc = [[[UIView viewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)] resetBackgroundColor:color] setupOnView:self.view];
        objc_setAssociatedObject(self, &keyNavView, vc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return vc;
}

@end

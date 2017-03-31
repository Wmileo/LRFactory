//
//  UIViewController+SimpleFactory.m
//  SimpleView
//
//  Created by leo on 2017/3/31.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import "UIViewController+SimpleFactory.h"

@implementation UIViewController (SimpleFactory)

+(UIViewController *)currentViewController{
    UIViewController *vc = [[UIApplication sharedApplication].delegate.window rootViewController];
    if (vc.presentedViewController) {
        vc = vc.presentedViewController;
    }
    if ([vc isKindOfClass:[UITabBarController class]]) {
        vc = ((UITabBarController *) vc).selectedViewController;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController *) vc).visibleViewController;
        }
    }else if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = ((UINavigationController *) vc).visibleViewController;
    }
    return vc;
}

@end

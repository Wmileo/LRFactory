//
//  UIApplication+LRFactory.m
//  SimpleView
//
//  Created by leo on 2018/11/6.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIApplication+LRFactory.h"

@implementation UIApplication (LRFactory)

+(UIViewController *)lrf_currentViewController{
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

+(UIWindow *)lrf_mainWindow{
    return [UIApplication sharedApplication].delegate.window;
}

@end

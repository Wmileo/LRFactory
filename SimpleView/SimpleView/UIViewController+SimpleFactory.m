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

+(UIWindow *)mainWindow{
    return [UIApplication sharedApplication].delegate.window;
}


-(UIViewController *)navLastViewController{
    if ([self.navigationController.viewControllers containsObject:self]) {
        NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index > 0) {
            return self.navigationController.viewControllers[index - 1];
        }
    }else if (self.navigationController.viewControllers.count > 0) {
        return [self.navigationController.viewControllers lastObject];
    }
    return nil;
}

-(UIViewController *)navNextViewController{
    if ([self.navigationController.viewControllers containsObject:self]) {
        NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
        index++;
        if (index < self.navigationController.viewControllers.count) {
            return self.navigationController.viewControllers[index];
        }
    }
    return nil;
}

@end

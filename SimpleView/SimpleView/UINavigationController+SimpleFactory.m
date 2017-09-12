//
//  UINavigationController+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UINavigationController+SimpleFactory.h"
#import "NSObject+Method.h"

@implementation UINavigationController (SimpleFactory)

+(UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)viewController{
    return [[UINavigationController alloc] initWithRootViewController:viewController];
}

+(void)configChildViewControllerForStatusBarStyle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(childViewControllerForStatusBarStyle) withSEL:@selector(SimpleNavigation_childViewControllerForStatusBarStyle)];
    });
}

-(UIViewController *)SimpleNavigation_childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}

+(void)autoHidesBottomBarWhenPush{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(SimpleNavigation_autoHidesBottomBarWhenPush_pushViewController:animated:)];
    });
}

-(void)SimpleNavigation_autoHidesBottomBarWhenPush_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self SimpleNavigation_autoHidesBottomBarWhenPush_pushViewController:viewController animated:animated];
}

@end

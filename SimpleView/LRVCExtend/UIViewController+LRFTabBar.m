//
//  UIViewController+LRFTabBar.m
//  SimpleView
//
//  Created by leo on 2018/11/12.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFTabBar.h"
#import "NSObject+LRFactory.h"

@interface UINavigationController (LRFTabBar)

+ (void)lrf_injectTabBar;

@end

@implementation UIViewController (LRFTabBar)

+ (void)lrf_autoHidesTabBar{
    [UINavigationController lrf_injectTabBar];
}

@end

@implementation UINavigationController (LRFTabBar)

+ (void)lrf_injectTabBar{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(LRFTabBar_pushViewController:animated:)];
    });
}


- (void)LRFTabBar_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0 && self.tabBarController) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self LRFTabBar_pushViewController:viewController animated:animated];
}

@end


//
//  UINavigationController+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UINavigationController+LRFactory.h"
#import "NSObject+LRFactory.h"
#import "UIViewController+LRFactory.h"

@implementation UINavigationController (LRFactory)

+(UINavigationController *)lrf_navigationControllerWithRootViewController:(UIViewController *)viewController{
    return [[UINavigationController alloc] initWithRootViewController:viewController];
}

+(void)autoHidesBottomBarWhenPush{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(SimpleNavigation_autoHidesBottomBarWhenPush_pushViewController:animated:)];
    });
}

-(void)SimpleNavigation_autoHidesBottomBarWhenPush_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self SimpleNavigation_autoHidesBottomBarWhenPush_pushViewController:viewController animated:animated];
}

@end

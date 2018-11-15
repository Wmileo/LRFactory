//
//  UINavigationController+BackButtonStyle.m
//  SimpleView
//
//  Created by ileo on 16/7/20.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UINavigationController+BackButtonStyle.h"
#import "UIViewController+BackButtonStyle.h"
#import "NSObject+LRFactory.h"

@interface UINavigationController () <UIGestureRecognizerDelegate>

@end

@implementation UINavigationController (BackButtonStyle)

+(void)configViewControllerResetBackButton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(UIViewControllerBackButton_pushViewController:animated:)];
    });
}

+(void)configViewControllerSetupDefaultBackButton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(UIViewControllerBackButton_setupDefault_pushViewController:animated:)];
    });
}

-(void)UIViewControllerBackButton_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self UIViewControllerBackButton_pushViewController:viewController animated:animated];
    if ([viewController respondsToSelector:@selector(viewControllerResetBackButton)]) {
        [viewController performSelector:@selector(viewControllerResetBackButton)];
    }
}

-(void)UIViewControllerBackButton_setupDefault_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self UIViewControllerBackButton_setupDefault_pushViewController:viewController animated:animated];
    if (self.viewControllers.count > 1 && [viewController respondsToSelector:@selector(viewControllerSetupDefaultBackButton)]) {
        [viewController performSelector:@selector(viewControllerSetupDefaultBackButton)];
    }
}



@end

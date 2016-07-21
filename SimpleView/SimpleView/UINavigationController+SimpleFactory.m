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

-(UINavigationController *)navResetNavBarTranslucent:(BOOL)translucent{
    self.navigationBar.translucent = translucent;
    return self;
}

+(void)configChildViewControllerForStatusBarStyle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(childViewControllerForStatusBarStyle) withSEL:@selector(SimpleNavigation_childViewControllerForStatusBarStyle)];
    });
}

static BOOL defaultTranslucent;

+(void)configNavBarTranslucent:(BOOL)translucent{
    defaultTranslucent = translucent;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(SimpleNavigation_pushViewController:animated:)];
    });
}

-(UIViewController *)SimpleNavigation_childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}

-(void)SimpleNavigation_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count == 0) {
        self.navigationBar.translucent = defaultTranslucent;
    }
    [self SimpleNavigation_pushViewController:viewController animated:animated];
}

@end

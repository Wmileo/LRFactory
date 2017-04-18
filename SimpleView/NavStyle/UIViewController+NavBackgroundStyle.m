//
//  UIViewController+NavBackgroundStyle.m
//  SimpleView
//
//  Created by ileo on 16/5/12.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+NavBackgroundStyle.h"
#import "UIViewController+SimpleNavigation.h"
#import "UINavigationController+SimpleFactory.h"
#import "UINavigationController+BackButtonStyle.h"
#import "UIView+SimpleFactory.h"
#import "UIView+Sizes.h"
#import <objc/runtime.h>
#import "NSObject+Method.h"
#import "SimpleViewHeader.h"

@implementation UIViewController (NavBackgroundStyle)

static UIColor *navBackgroundColor;

+(void)configNavBackgroundColor:(UIColor *)color{
    navBackgroundColor = color;
    [[UINavigationBar appearance] setBarTintColor:color];
}

+(UIColor *)navBackgroundColor{
    return navBackgroundColor;
}

+(void)configNavBackgroundStyle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(NavBackgroundStyle_viewWillAppear:)];
        [UIViewController exchangeSEL:@selector(viewWillDisappear:) withSEL:@selector(NavBackgroundStyle_viewWillDisappear:)];
    });
    
}

-(void)NavBackgroundStyle_viewWillDisappear:(BOOL)animated{
    [self NavBackgroundStyle_viewWillDisappear:animated];
    if (self.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    [self.navigationController.navigationBar setBarTintColor:self.oldColor];
}

-(void)NavBackgroundStyle_viewWillAppear:(BOOL)animated{
    [self NavBackgroundStyle_viewWillAppear:animated];
    if (self.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    [self tryRegisterOldColor];
    if (self.navBackgroundColor) {
        [self.navigationController.navigationBar setBarTintColor:self.navBackgroundColor];
    }
}


static char keyNavOldColor;
static char keyNavNewColor;
static char keyNavHide;

-(void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    [self setNavigationBarHidden:navigationBarHidden animated:NO];
}

-(void)setNavigationBarHidden:(BOOL)navigationBarHidden animated:(BOOL)animated{
    objc_setAssociatedObject(self, &keyNavHide, @(navigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:navigationBarHidden animated:animated];
    }
}

-(BOOL)navigationBarHidden{
    return [objc_getAssociatedObject(self, &keyNavHide) boolValue];
}


-(void)setNavBackgroundColor:(UIColor *)navBackgroundColor{
    objc_setAssociatedObject(self, &keyNavNewColor, navBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self tryRegisterOldColor];
        [self.navigationController.navigationBar setBarTintColor:navBackgroundColor];
    }
}

-(UIColor *)navBackgroundColor{
    return objc_getAssociatedObject(self, &keyNavNewColor);
}

-(void)tryRegisterOldColor{
    if (!self.oldColor) {
        objc_setAssociatedObject(self, &keyNavOldColor, self.navigationController.navigationBar.barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(UIColor *)oldColor{
    return objc_getAssociatedObject(self, &keyNavOldColor);
}

@end

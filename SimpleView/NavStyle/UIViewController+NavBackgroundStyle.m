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
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
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
    [self.navigationController.navigationBar setShadowImage:self.oldShadowImage];
}

-(void)NavBackgroundStyle_viewWillAppear:(BOOL)animated{
    [self NavBackgroundStyle_viewWillAppear:animated];
    if (self.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    [self tryRegisterOldColor];
    [self tryRegisterOldShadowImage];
    if (self.navBackgroundColor) {
        [self.navigationController.navigationBar setBarTintColor:self.navBackgroundColor];
    }
    if (self.navShadowImage) {
        [self.navigationController.navigationBar setShadowImage:self.navShadowImage];
    }
}

#pragma mark - navigationBarHidden

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

#pragma mrak - navBackgroundColor

static char keyNavOldColor;
static char keyNavNewColor;
BOOL registerOldColor = NO;

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
    if (!registerOldColor) {
        registerOldColor = YES;
        objc_setAssociatedObject(self, &keyNavOldColor, self.navigationController.navigationBar.barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(UIColor *)oldColor{
    return objc_getAssociatedObject(self, &keyNavOldColor);
}


#pragma mark - navShadowImage

static char keyNavOldShadowImage;
static char keyNavNewShadowImage;
BOOL registerOldShadowImage = NO;

-(void)setNavShadowImage:(UIImage *)navShadowImage{
    objc_setAssociatedObject(self, &keyNavNewShadowImage, navShadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self tryRegisterOldShadowImage];
        [self.navigationController.navigationBar setShadowImage:navShadowImage];
    }
}

-(UIImage *)navShadowImage{
    return objc_getAssociatedObject(self, &keyNavNewShadowImage);
}

-(void)tryRegisterOldShadowImage{
    if (!registerOldShadowImage) {
        registerOldShadowImage = YES;
        objc_setAssociatedObject(self, &keyNavOldShadowImage, self.navigationController.navigationBar.shadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(UIImage *)oldShadowImage{
    return objc_getAssociatedObject(self, &keyNavOldShadowImage);
}


@end

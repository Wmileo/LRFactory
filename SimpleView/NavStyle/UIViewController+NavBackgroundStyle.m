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
#import "UIViewController+SimpleFactory.h"

@implementation UIViewController (NavBackgroundStyle)

static UIColor *navBackgroundColor;

+(void)configNavBackgroundColor:(UIColor *)color{
    navBackgroundColor = color;
    [[UINavigationBar appearance] setBarTintColor:color];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
}

+(UIColor *)navBackgroundColor{
    return navBackgroundColor;
}

+(void)configNavBackgroundStyle{
    [UIViewController configSimple];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(viewWillAppearFirstTime:) withSEL:@selector(NavBackgroundStyle_viewWillAppearFirstTime:)];
        [UIViewController exchangeSEL:@selector(viewWillDisappearForever:) withSEL:@selector(NavBackgroundStyle_viewWillDisappearForever:)];
    });
}

-(void)NavBackgroundStyle_viewWillDisappearForever:(BOOL)animated{
    [self NavBackgroundStyle_viewWillDisappearForever:animated];
    if (self.presentedViewController) {
        return;
    }
    [self.navigationController setNavigationBarHidden:self.oldNavBarHidden animated:animated];
    [self.navigationController.navigationBar setBarTintColor:self.oldColor];
    [self.navigationController.navigationBar setShadowImage:self.oldShadowImage];
    [self.navigationController.navigationBar setTranslucent:self.oldTranslucent];
}

-(void)NavBackgroundStyle_viewWillAppearFirstTime:(BOOL)animated{
    [self NavBackgroundStyle_viewWillAppearFirstTime:animated];
    
    if (self.presentedViewController) {
        return;
    }
    [self tryRegisterOldBarHidden];
    [self tryRegisterOldColor];
    [self tryRegisterOldShadowImage];
    [self tryRegisterOldTranslucent];
    if (self.hadNavBarHidden) {
        [self.navigationController setNavigationBarHidden:self.navBarHidden animated:animated];
    }
    if (self.navBackgroundColor) {
        [self.navigationController.navigationBar setBarTintColor:self.navBackgroundColor];
    }
    if (self.navShadowImage) {
        [self.navigationController.navigationBar setShadowImage:self.navShadowImage];
    }
    if (self.hadNavBackgroundTranslucent) {
        [self.navigationController.navigationBar setTranslucent:self.navBackgroundTranslucent];
    }
}

#pragma mark - navBarHidden

static char keyNavOldBarHidden;
static char keyNavNewBarHidden;
static char keyRegisterOldBarHidden;

-(void)setNavBarHidden:(BOOL)navBarHidden{
    [self setNavBarHidden:navBarHidden animated:NO];
}

-(void)tryRegisterOldBarHidden{
    if (![objc_getAssociatedObject(self, &keyRegisterOldBarHidden) boolValue]) {
        objc_setAssociatedObject(self, &keyRegisterOldBarHidden, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &keyNavOldBarHidden, @(self.navigationController.navigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(void)setNavBarHidden:(BOOL)navBarHidden animated:(BOOL)animated{
    objc_setAssociatedObject(self, &keyNavNewBarHidden, @(navBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:navBarHidden animated:animated];
    }
}

-(BOOL)navBarHidden{
    return [objc_getAssociatedObject(self, &keyNavNewBarHidden) boolValue];
}

-(BOOL)oldNavBarHidden{
    return [objc_getAssociatedObject(self, &keyNavOldBarHidden) boolValue];
}

-(BOOL)hadNavBarHidden{
    return objc_getAssociatedObject(self, &keyNavNewBarHidden);
}

#pragma mrak - navBackgroundColor

static char keyNavOldColor;
static char keyNavNewColor;
static char keyRegisterOldColor;

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
    if (![objc_getAssociatedObject(self, &keyRegisterOldColor) boolValue]) {
        objc_setAssociatedObject(self, &keyRegisterOldColor, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &keyNavOldColor, self.navigationController.navigationBar.barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(UIColor *)oldColor{
    return objc_getAssociatedObject(self, &keyNavOldColor);
}


#pragma mark - navShadowImage

static char keyNavOldShadowImage;
static char keyNavNewShadowImage;
static char keyRegisterOldShadowImage;

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
    if (![objc_getAssociatedObject(self, &keyRegisterOldShadowImage) boolValue]) {
        objc_setAssociatedObject(self, &keyRegisterOldShadowImage, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &keyNavOldShadowImage, self.navigationController.navigationBar.shadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(UIImage *)oldShadowImage{
    return objc_getAssociatedObject(self, &keyNavOldShadowImage);
}

#pragma mark - navBackgroundTranslucent
static char keyNavOldTranslucent;
static char keyNavNewTranslucent;
static char keyRegisterOldTranslucent;

-(void)setNavBackgroundTranslucent:(BOOL)navBackgroundTranslucent{
    objc_setAssociatedObject(self, &keyNavNewTranslucent, @(navBackgroundTranslucent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self tryRegisterOldTranslucent];
        [self.navigationController.navigationBar setTranslucent:navBackgroundTranslucent];
    }
}

-(BOOL)navBackgroundTranslucent{
    return [objc_getAssociatedObject(self, &keyNavNewTranslucent) boolValue];
}

-(BOOL)hadNavBackgroundTranslucent{
    return objc_getAssociatedObject(self, &keyNavNewTranslucent);
}

-(void)tryRegisterOldTranslucent{
    if (![objc_getAssociatedObject(self, &keyRegisterOldTranslucent) boolValue]) {
        objc_setAssociatedObject(self, &keyRegisterOldTranslucent, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(self, &keyNavOldTranslucent, @(self.navigationController.navigationBar.translucent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

-(BOOL)oldTranslucent{
    return [objc_getAssociatedObject(self, &keyNavOldTranslucent) boolValue];
}

@end

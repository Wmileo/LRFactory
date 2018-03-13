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
        [UIViewController exchangeSEL:@selector(viewDidLoad) withSEL:@selector(NavBackgroundStyle_viewDidLoad)];
        [UIViewController exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(NavBackgroundStyle_viewWillAppear:)];
        [UIViewController exchangeSEL:@selector(viewWillDisappear:) withSEL:@selector(NavBackgroundStyle_viewWillDisappear:)];
    });
}

-(void)dealloc{
//    [self removeObserver];
}

-(void)addObserver{
//    if (self.navigationController) {
//        [self.navigationController.navigationBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//        [self.navigationController.navigationBar addObserver:self forKeyPath:@"barTintColor" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//        [self.navigationController.navigationBar addObserver:self forKeyPath:@"shadowImage" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//        [self.navigationController.navigationBar addObserver:self forKeyPath:@"translucent" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    }
}

-(void)removeObserver{
//    if (self.navigationController) {
//        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"hidden"];
//        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"barTintColor"];
//        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"shadowImage"];
//        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"translucent"];
//    }
}

-(void)NavBackgroundStyle_viewDidLoad{
    [self NavBackgroundStyle_viewDidLoad];
    self.navBarHidden = self.navigationController.navigationBarHidden;
    self.navBackgroundColor = self.navigationController.navigationBar.barTintColor;
    self.navShadowImage = self.navigationController.navigationBar.shadowImage;
    self.navBackgroundTranslucent = self.navigationController.navigationBar.translucent;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (change[@"new"] == change[@"old"]) {
        return;
    }
    if ([keyPath isEqualToString:@"hidden"]) {
        self.navBarHidden = self.navigationController.navigationBarHidden;
    }else if ([keyPath isEqualToString:@"barTintColor"]) {
        self.navBackgroundColor = self.navigationController.navigationBar.barTintColor;
    }else if ([keyPath isEqualToString:@"shadowImage"]) {
        self.navShadowImage = self.navigationController.navigationBar.shadowImage;
    }else if ([keyPath isEqualToString:@"translucent"]) {
        self.navBackgroundTranslucent = self.navigationController.navigationBar.translucent;
    }
}

-(void)NavBackgroundStyle_viewWillDisappear:(BOOL)animated{
    [self NavBackgroundStyle_viewWillDisappear:animated];
//    [self removeObserver];
    self.navBarHidden = self.navigationController.navigationBarHidden;
    self.navBackgroundColor = self.navigationController.navigationBar.barTintColor;
    self.navShadowImage = self.navigationController.navigationBar.shadowImage;
    self.navBackgroundTranslucent = self.navigationController.navigationBar.translucent;
}

-(void)NavBackgroundStyle_viewWillAppear:(BOOL)animated{
    [self NavBackgroundStyle_viewWillAppear:animated];
    if (self.navigationController) {
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
//    [self addObserver];
}

#pragma mark - navBarHidden

static char keyNavBarHidden;

-(void)setNavBarHidden:(BOOL)navBarHidden{
    [self setNavBarHidden:navBarHidden animated:NO];
}

-(void)setNavBarHidden:(BOOL)navBarHidden animated:(BOOL)animated{
    objc_setAssociatedObject(self, &keyNavBarHidden, @(navBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:navBarHidden animated:animated];
    }
}

-(BOOL)navBarHidden{
    return [objc_getAssociatedObject(self, &keyNavBarHidden) boolValue];
}

-(BOOL)hadNavBarHidden{
    return objc_getAssociatedObject(self, &keyNavBarHidden);
}

#pragma mrak - navBackgroundColor

static char keyNavColor;

-(void)setNavBackgroundColor:(UIColor *)navBackgroundColor{
    objc_setAssociatedObject(self, &keyNavColor, navBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self.navigationController.navigationBar setBarTintColor:navBackgroundColor];
    }
}

-(UIColor *)navBackgroundColor{
    return objc_getAssociatedObject(self, &keyNavColor);
}

#pragma mark - navShadowImage

static char keyNavShadowImage;

-(void)setNavShadowImage:(UIImage *)navShadowImage{
    objc_setAssociatedObject(self, &keyNavShadowImage, navShadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self.navigationController.navigationBar setShadowImage:navShadowImage];
    }
}

-(UIImage *)navShadowImage{
    return objc_getAssociatedObject(self, &keyNavShadowImage);
}

#pragma mark - navBackgroundTranslucent

static char keyNavTranslucent;

-(void)setNavBackgroundTranslucent:(BOOL)navBackgroundTranslucent{
    objc_setAssociatedObject(self, &keyNavTranslucent, @(navBackgroundTranslucent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController) {
        [self.navigationController.navigationBar setTranslucent:navBackgroundTranslucent];
    }
}

-(BOOL)navBackgroundTranslucent{
    return [objc_getAssociatedObject(self, &keyNavTranslucent) boolValue];
}

-(BOOL)hadNavBackgroundTranslucent{
    return objc_getAssociatedObject(self, &keyNavTranslucent);
}

@end

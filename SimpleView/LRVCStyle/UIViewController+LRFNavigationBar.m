//
//  UIViewController+LRFNavigationBar.m
//  SimpleView
//
//  Created by leo on 2018/11/14.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFNavigationBar.h"
#import "UIViewController+LRFactory.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>

@implementation UIViewController (LRFNavigationBar)


#pragma mark - inject

+(void)lrf_injectNavigationBar{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFNavigationBar_viewWillAppear:)];
    });
}

-(void)LRFNavigationBar_viewWillAppear:(BOOL)animated{
    [self LRFNavigationBar_viewWillAppear:animated];
    if (!self.lrf_isKitController && self.navigationController && self.lrf_isFinalController) {
        [self.navigationController setNavigationBarHidden:self.lrf_navigationBarHidden animated:animated];
        [self.navigationController.navigationBar setBarTintColor:self.lrf_navigationBarTintColor];
        [self.navigationController.navigationBar setShadowImage:self.lrf_navigationBarShadowImage];
        [self.navigationController.navigationBar setTranslucent:self.lrf_navigationBarTranslucent];
    }
}

#pragma mark - navigationBarHidden

static char keyNavigationBarHidden;

- (void)setLrf_navigationBarHidden:(BOOL)lrf_navigationBarHidden{
    [self setLrf_navigationBarHidden:lrf_navigationBarHidden animated:NO];
}

- (void)setLrf_navigationBarHidden:(BOOL)lrf_navigationBarHidden animated:(BOOL)animated{
    [UIViewController lrf_injectNavigationBar];
    objc_setAssociatedObject(self, &keyNavigationBarHidden, @(lrf_navigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController setNavigationBarHidden:lrf_navigationBarHidden animated:animated];
    }
}

- (BOOL)lrf_navigationBarHidden{
    if (objc_getAssociatedObject(self, &keyNavigationBarHidden)) {
        return [objc_getAssociatedObject(self, &keyNavigationBarHidden) boolValue];
    }else{
        return self.navigationController.isNavigationBarHidden;
    }
}

#pragma mrak - navigationBarTintColor

static char keyNavigationBarTintColor;

-(void)setLrf_navigationBarTintColor:(UIColor *)lrf_navigationBarTintColor{
    [UIViewController lrf_injectNavigationBar];
    objc_setAssociatedObject(self, &keyNavigationBarTintColor, lrf_navigationBarTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setBarTintColor:lrf_navigationBarTintColor];
    }
}

-(UIColor *)lrf_navigationBarTintColor{
    if (objc_getAssociatedObject(self, &keyNavigationBarTintColor)) {
        return objc_getAssociatedObject(self, &keyNavigationBarTintColor);
    }else{
        return self.navigationController.navigationBar.barTintColor;
    }
}

#pragma mark - navigationBarShadowImage

static char keyNavigationBarShadowImage;

-(void)setLrf_navigationBarShadowImage:(UIImage *)lrf_navigationBarShadowImage{
    [UIViewController lrf_injectNavigationBar];
    objc_setAssociatedObject(self, &keyNavigationBarShadowImage, lrf_navigationBarShadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setShadowImage:lrf_navigationBarShadowImage];
    }
}

-(UIImage *)lrf_navigationBarShadowImage{
    if (objc_getAssociatedObject(self, &keyNavigationBarShadowImage)) {
        return objc_getAssociatedObject(self, &keyNavigationBarShadowImage);
    }else{
        return self.navigationController.navigationBar.shadowImage;
    }
}

#pragma mark - navigationBarTranslucent

static char keyNavigationBarTranslucent;

-(void)setLrf_navigationBarTranslucent:(BOOL)lrf_navigationBarTranslucent{
    [UIViewController lrf_injectNavigationBar];
    objc_setAssociatedObject(self, &keyNavigationBarTranslucent, @(lrf_navigationBarTranslucent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setTranslucent:lrf_navigationBarTranslucent];
    }
}

-(BOOL)lrf_navigationBarTranslucent{
    if (objc_getAssociatedObject(self, &keyNavigationBarTranslucent)) {
        return [objc_getAssociatedObject(self, &keyNavigationBarTranslucent) boolValue];
    }else{
        return self.navigationController.navigationBar.isTranslucent;
    }
}

@end

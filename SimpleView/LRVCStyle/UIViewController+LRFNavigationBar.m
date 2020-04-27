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

@implementation UIViewController (LRFNavigationBar)


#pragma mark - inject

+(void)lrf_injectNavigationBar{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFNavigationBar_viewWillAppear:)];
        [UIViewController lrf_exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(LRFNavigationBar_viewDidAppear:)];
        [UIViewController lrf_exchangeSEL:@selector(viewWillDisappear:) withSEL:@selector(LRFNavigationBar_viewWillDisappear:)];
    });
}

-(void)LRFNavigationBar_viewWillAppear:(BOOL)animated{
    if (!self.lrf_isKitController && self.navigationController && self.lrf_isFinalController) {
        if (self.lrf_navigationBarClear) {
            [self.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            [self lrf_resetNavigationBar:animated];
        }
    }
    [self LRFNavigationBar_viewWillAppear:animated];
}

- (void)LRFNavigationBar_viewDidAppear:(BOOL)animated {
    if (!self.lrf_isKitController && self.navigationController && self.lrf_isFinalController) {
        if (self.lrf_navigationBarClear) {
            [self lrf_resetNavigationBar:NO];
        }
    }
    [self LRFNavigationBar_viewDidAppear:animated];
}

- (void)LRFNavigationBar_viewWillDisappear:(BOOL)animated{
    if (!self.lrf_isKitController && self.lrf_navigationBarClear && self.navigationController && self.lrf_isFinalController) {
        [self.navigationController setNavigationBarHidden:YES];
    }
    [self LRFNavigationBar_viewWillDisappear:animated];
}

- (void)lrf_resetNavigationBar:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:self.lrf_navigationBarHidden animated:animated];
    if (!self.lrf_navigationBarHidden) {
        if (self.lrf_navigationBarClear) {
            [self.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
            [self.navigationController.navigationBar setTranslucent:YES];
            [self.navigationController.navigationBar setShadowImage:[UIImage new]];
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        } else {
            [self.navigationController.navigationBar setBarTintColor:self.lrf_navigationBarTintColor];
            [self.navigationController.navigationBar setShadowImage:self.lrf_navigationBarShadowImage];
            [self.navigationController.navigationBar setTranslucent:self.lrf_navigationBarTranslucent];
            [self.navigationController.navigationBar setBackgroundImage:self.lrf_navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
        }
        [self.navigationController.navigationBar setTintColor:self.lrf_navigationBarItemTintColor];
        [self.navigationController.navigationBar setTitleTextAttributes:self.lrf_navigationBarTitleTextAttributes];
    }
}

#pragma mark - navigationBarHidden

static char keyNavigationBarHidden;

- (void)setLrf_navigationBarHidden:(BOOL)lrf_navigationBarHidden{
    [self setLrf_navigationBarHidden:lrf_navigationBarHidden animated:NO];
}

- (void)setLrf_navigationBarHidden:(BOOL)lrf_navigationBarHidden animated:(BOOL)animated{
    [UIViewController lrf_injectNavigationBar];
    [self lrf_setNonatomicStrongAssociatedObject:@(lrf_navigationBarHidden) withKey:&keyNavigationBarHidden];
    if (self.navigationController && self.lrf_isVisible) {
        [self lrf_resetNavigationBar:animated];
    }
}

- (BOOL)lrf_navigationBarHidden{
    return [[self lrf_getAssociatedObjectWithKey:&keyNavigationBarHidden] boolValue];
}

#pragma mrak - navigationBarTintColor

static char keyNavigationBarTintColor;

-(void)setLrf_navigationBarTintColor:(UIColor *)lrf_navigationBarTintColor{
    [UIViewController lrf_injectNavigationBar];
    [self lrf_setNonatomicStrongAssociatedObject:lrf_navigationBarTintColor withKey:&keyNavigationBarTintColor];
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setBarTintColor:lrf_navigationBarTintColor];
    }
}

-(UIColor *)lrf_navigationBarTintColor{
    return [self lrf_getAssociatedObjectWithKey:&keyNavigationBarTintColor];
}

#pragma mrak - navigationBarItemTintColor

static char keyNavigationBarItemTintColor;

-(void)setLrf_navigationBarItemTintColor:(UIColor *)lrf_navigationBarItemTintColor{
    [UIViewController lrf_injectNavigationBar];
    [self lrf_setNonatomicStrongAssociatedObject:lrf_navigationBarItemTintColor withKey:&keyNavigationBarItemTintColor];
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setTintColor:lrf_navigationBarItemTintColor];
    }
}

-(UIColor *)lrf_navigationBarItemTintColor{
    return [self lrf_getAssociatedObjectWithKey:&keyNavigationBarItemTintColor];
}

#pragma mrak - navigationBarTitleTextAttributes

static char keyNavigationBarTitleTextAttributes;

-(void)setLrf_navigationBarTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)lrf_navigationBarTitleTextAttributes{
    [UIViewController lrf_injectNavigationBar];
    [self lrf_setNonatomicCopyAssociatedObject:lrf_navigationBarTitleTextAttributes withKey:&keyNavigationBarTitleTextAttributes];
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setTitleTextAttributes:lrf_navigationBarTitleTextAttributes];
    }
}

-(NSDictionary<NSAttributedStringKey,id> *)lrf_navigationBarTitleTextAttributes{
    return [self lrf_getAssociatedObjectWithKey:&keyNavigationBarTitleTextAttributes];
}

#pragma mark - navigationBarShadowImage

static char keyNavigationBarShadowImage;

-(void)setLrf_navigationBarShadowImage:(UIImage *)lrf_navigationBarShadowImage{
    [UIViewController lrf_injectNavigationBar];
    [self lrf_setNonatomicStrongAssociatedObject:lrf_navigationBarShadowImage withKey:&keyNavigationBarShadowImage];
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setShadowImage:lrf_navigationBarShadowImage];
    }
}

-(UIImage *)lrf_navigationBarShadowImage{
    return [self lrf_getAssociatedObjectWithKey:&keyNavigationBarShadowImage];
}

#pragma mark - navigationBarShadowImage

static char keyNavigationBarBackgroundImage;

-(void)setLrf_navigationBarBackgroundImage:(UIImage *)lrf_navigationBarBackgroundImage{
    [UIViewController lrf_injectNavigationBar];
    [self lrf_setNonatomicStrongAssociatedObject:lrf_navigationBarBackgroundImage withKey:&keyNavigationBarBackgroundImage];
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setBackgroundImage:lrf_navigationBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    }
}

-(UIImage *)lrf_navigationBarBackgroundImage{
    return [self lrf_getAssociatedObjectWithKey:&keyNavigationBarBackgroundImage];
}

#pragma mark - navigationBarTranslucent

static char keyNavigationBarTranslucent;

-(void)setLrf_navigationBarTranslucent:(BOOL)lrf_navigationBarTranslucent{
    [UIViewController lrf_injectNavigationBar];
    [self lrf_setNonatomicStrongAssociatedObject:@(lrf_navigationBarTranslucent) withKey:&keyNavigationBarTranslucent];
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setTranslucent:lrf_navigationBarTranslucent];
    }
}

-(BOOL)lrf_navigationBarTranslucent{
    return [[self lrf_getAssociatedObjectWithKey:&keyNavigationBarTranslucent] boolValue];
}

#pragma mark - navigationBarClear

static char keyNavigationBarClear;

-(void)setLrf_navigationBarClear:(BOOL)lrf_navigationBarClear{
    [UIViewController lrf_injectNavigationBar];
    [self lrf_setNonatomicStrongAssociatedObject:@(lrf_navigationBarClear) withKey:&keyNavigationBarClear];
    if (self.navigationController && self.lrf_isVisible) {
        self.lrf_navigationBarTintColor = [UIColor clearColor];
        self.lrf_navigationBarTranslucent = YES;
        self.lrf_navigationBarBackgroundImage = [UIImage new];
        self.lrf_navigationBarShadowImage = [UIImage new];
    }
}

-(BOOL)lrf_navigationBarClear{
    return [[self lrf_getAssociatedObjectWithKey:&keyNavigationBarClear] boolValue];
}

@end

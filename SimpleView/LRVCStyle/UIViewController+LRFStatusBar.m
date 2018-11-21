//
//  UIViewController+LRFStatusBar.m
//  SimpleView
//
//  Created by leo on 2018/11/8.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFStatusBar.h"
#import "NSObject+LRFactory.h"
#import "UIViewController+LRFactory.h"
#import <objc/runtime.h>

@implementation UIViewController (LRFStatusBar)

#pragma mark - inject

+ (void)lrf_injectStatus{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFStatus_viewWillAppear:)];
    });
}

-(void)LRFStatus_viewWillAppear:(BOOL)animated{
    [self LRFStatus_viewWillAppear:animated];
    if (self.lrf_isVisible) {
        [[UIApplication sharedApplication] setStatusBarStyle:self.lrf_statusBarStyle animated:animated];
        [[UIApplication sharedApplication] setStatusBarHidden:self.lrf_statusBarHidden withAnimation:self.lrf_statusBarAnimation];
    }
}

#pragma mark - set get

static char keyStatusBarStyle;
static char keyStatusBarHidden;
static char keyStatusBarAnimation;

- (void)setLrf_statusBarHidden:(BOOL)lrf_statusBarHidden{
    [self setLrf_statusBarHidden:lrf_statusBarHidden withAnimation:self.lrf_statusBarAnimation];
}

-(void)setLrf_statusBarHidden:(BOOL)lrf_statusBarHidden withAnimation:(UIStatusBarAnimation)lrf_statusBarAnimation{
    [UIViewController lrf_injectStatus];
    objc_setAssociatedObject(self, &keyStatusBarHidden, @(lrf_statusBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &keyStatusBarAnimation, @(lrf_statusBarAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.lrf_isVisible) {
        [[UIApplication sharedApplication] setStatusBarHidden:self.lrf_statusBarHidden withAnimation:self.lrf_statusBarAnimation];
    }
}

- (BOOL)lrf_statusBarHidden{
    if (objc_getAssociatedObject(self, &keyStatusBarHidden)) {
        return [objc_getAssociatedObject(self, &keyStatusBarHidden) boolValue];
    }else{
        return [UIApplication sharedApplication].statusBarHidden;
    }
}

- (void)setLrf_statusBarStyle:(UIStatusBarStyle)lrf_statusBarStyle{
    [self setLrf_statusBarStyle:lrf_statusBarStyle animated:NO];
}

-(void)setLrf_statusBarStyle:(UIStatusBarStyle)lrf_statusBarStyle animated:(BOOL)animated{
    [UIViewController lrf_injectStatus];
    objc_setAssociatedObject(self, &keyStatusBarStyle, @(lrf_statusBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.lrf_isVisible) {
        [[UIApplication sharedApplication] setStatusBarStyle:self.lrf_statusBarStyle animated:animated];
    }
}

- (UIStatusBarStyle)lrf_statusBarStyle{
    if (objc_getAssociatedObject(self, &keyStatusBarStyle)) {
        return [objc_getAssociatedObject(self, &keyStatusBarStyle) integerValue];
    }else{
        return [UIApplication sharedApplication].statusBarStyle;
    }
}

- (void)setLrf_statusBarAnimation:(UIStatusBarAnimation)lrf_statusBarAnimation{
    [UIViewController lrf_injectStatus];
    objc_setAssociatedObject(self, &keyStatusBarAnimation, @(lrf_statusBarAnimation), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIStatusBarAnimation)lrf_statusBarAnimation{
    if (objc_getAssociatedObject(self, &keyStatusBarAnimation)) {
        return [objc_getAssociatedObject(self, &keyStatusBarStyle) integerValue];
    }else{
        return UIStatusBarAnimationFade;
    }
}

@end

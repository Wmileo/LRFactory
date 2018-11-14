//
//  UIViewController+LRFStatus.m
//  SimpleView
//
//  Created by leo on 2018/11/8.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFStatus.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>

@implementation UIViewController (LRFStatus)

UIStatusBarStyle lrf_defaultStatusBarStyle = UIStatusBarStyleDefault;
BOOL lrf_defaultStatusBarHidden = NO;
UIStatusBarAnimation lrf_defaultStatusBarAnimation = UIStatusBarAnimationFade;

+ (void)lrf_configDefaultStatusBarStyle:(UIStatusBarStyle)statusBarStyle statusHidden:(BOOL)statusBarHidden{
    [UIViewController lrf_injectStatus];
    lrf_defaultStatusBarStyle = statusBarStyle;
    lrf_defaultStatusBarHidden = statusBarHidden;
}

#pragma mark - inject

+ (void)lrf_injectStatus{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFStatus_viewWillAppear:)];
    });
}

-(void)LRFStatus_viewWillAppear:(BOOL)animated{
    [self LRFStatus_viewWillAppear:animated];
    UIViewController *rvc = self.navigationController ?
    (self.navigationController.tabBarController ?
     self.navigationController.tabBarController :
     self.navigationController) :
    self.tabBarController;
    if (rvc && rvc == [UIApplication sharedApplication].keyWindow.rootViewController) {
        [[UIApplication sharedApplication] setStatusBarStyle:self.lrf_statusBarStyle animated:animated];
        [[UIApplication sharedApplication] setStatusBarHidden:self.lrf_statusBarHidden withAnimation:self.lrf_statusBarAnimation];
    }
}

#pragma mark - set get

static char keyStatusBarStyle;
static char keyStatusBarHidden;
static char keyStatusBarAnimation;

- (void)setLrf_statusBarHidden:(BOOL)lrf_statusBarHidden{
    [UIViewController lrf_injectStatus];
    objc_setAssociatedObject(self, &keyStatusBarHidden, @(lrf_statusBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)lrf_statusBarHidden{
    if (objc_getAssociatedObject(self, &keyStatusBarHidden)) {
        return [objc_getAssociatedObject(self, &keyStatusBarHidden) boolValue];
    }else{
        return lrf_defaultStatusBarHidden;
    }
}

- (void)setLrf_statusBarStyle:(UIStatusBarStyle)lrf_statusBarStyle{
    [UIViewController lrf_injectStatus];
    objc_setAssociatedObject(self, &keyStatusBarStyle, @(lrf_statusBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIStatusBarStyle)lrf_statusBarStyle{
    if (objc_getAssociatedObject(self, &keyStatusBarStyle)) {
        return [objc_getAssociatedObject(self, &keyStatusBarStyle) integerValue];
    }else{
        return lrf_defaultStatusBarStyle;
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
        return lrf_defaultStatusBarAnimation;
    }
}

@end

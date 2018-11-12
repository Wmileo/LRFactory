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

@interface UINavigationController (LRFStatus)

+ (void)lrf_injectNavStatus;

@end

@implementation UIViewController (LRFStatus)

UIStatusBarStyle lrf_defaultStatusBarStyle = UIStatusBarStyleDefault;
BOOL lrf_defaultStatusBarHidden = NO;

+ (void)lrf_configDefaultStatusBarStyle:(UIStatusBarStyle)statusBarStyle statusHidden:(BOOL)statusBarHidden{
    [UIViewController lrf_injectStatus];
    lrf_defaultStatusBarStyle = statusBarStyle;
    lrf_defaultStatusBarHidden = statusBarHidden;
}

#pragma mark - inject

+ (void)lrf_injectStatus{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_injectNavStatus];
        [UIViewController lrf_exchangeClassSEL:@selector(preferredStatusBarStyle) withClassSEL:@selector(LRFStatus_preferredStatusBarStyle)];
        [UIViewController lrf_exchangeClassSEL:@selector(prefersStatusBarHidden) withClassSEL:@selector(LRFStatus_prefersStatusBarHidden)];
        [UIViewController lrf_exchangeClassSEL:@selector(viewDidAppear:) withClassSEL:@selector(LRFStatus_viewDidAppear:)];
    });
}

- (UIStatusBarStyle)LRFStatus_preferredStatusBarStyle{
    if (objc_getAssociatedObject(self, &keyStatusBarStyle)) {
        return [objc_getAssociatedObject(self, &keyStatusBarStyle) integerValue];
    }
    return lrf_defaultStatusBarStyle;
}

- (BOOL)LRFStatus_prefersStatusBarHidden{
    if (objc_getAssociatedObject(self, &keyStatusBarHidden)) {
        return [objc_getAssociatedObject(self, &keyStatusBarHidden) boolValue];
    }
    return lrf_defaultStatusBarHidden;
}

- (void)LRFStatus_viewDidAppear:(BOOL)animated{
    [self LRFStatus_viewDidAppear:animated];
    if (objc_getAssociatedObject(self, &keyStatusBarStyle)) {
        self.lrf_statusBarStyle = [objc_getAssociatedObject(self, &keyStatusBarStyle) integerValue];
    }else{
        self.lrf_statusBarStyle = lrf_defaultStatusBarStyle;
    }
    if (objc_getAssociatedObject(self, &keyStatusBarHidden)) {
        self.lrf_statusBarHidden = [objc_getAssociatedObject(self, &keyStatusBarHidden) boolValue];
    }else{
        self.lrf_statusBarHidden = lrf_defaultStatusBarHidden;
    }
}

#pragma mark - set get

static char keyStatusBarStyle;
static char keyStatusBarHidden;

- (void)setLrf_statusBarHidden:(BOOL)lrf_statusBarHidden{
    [UIViewController lrf_injectStatus];
    objc_setAssociatedObject(self, &keyStatusBarHidden, @(lrf_statusBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self prefersStatusBarHidden];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (BOOL)lrf_statusBarHidden{
    return [self prefersStatusBarHidden];
}

- (void)setLrf_statusBarStyle:(UIStatusBarStyle)lrf_statusBarStyle{
    [UIViewController lrf_injectStatus];
    objc_setAssociatedObject(self, &keyStatusBarStyle, @(lrf_statusBarStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (UIStatusBarStyle)lrf_statusBarStyle{
    return [self preferredStatusBarStyle];
}


@end

@implementation UINavigationController (LRFStatus)

+ (void)lrf_injectNavStatus{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_exchangeClassSEL:@selector(childViewControllerForStatusBarStyle) withClassSEL:@selector(LRFStatus_childViewControllerForStatusBarStyle)];
        [UINavigationController lrf_exchangeClassSEL:@selector(childViewControllerForStatusBarHidden) withClassSEL:@selector(LRFStatus_childViewControllerForStatusBarHidden)];
    });
}

- (UIViewController *)LRFStatus_childViewControllerForStatusBarStyle{
    return self.visibleViewController;
}

- (UIViewController *)LRFStatus_childViewControllerForStatusBarHidden{
    return self.visibleViewController;
}

@end

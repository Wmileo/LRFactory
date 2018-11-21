//
//  UIViewController+LRFAppear.m
//  SimpleView
//
//  Created by leo on 2018/11/12.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFAppear.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>

@implementation UIViewController (LRFAppear)

+ (void)load{
    [UIViewController lrf_injectAppear];
}

+ (void)lrf_injectAppear{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewDidDisappear:) withSEL:@selector(LRFAppear_viewDidDisappear:)];
        [UIViewController lrf_exchangeSEL:@selector(viewWillDisappear:) withSEL:@selector(LRFAppear_viewWillDisappear:)];
        [UIViewController lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFAppear_viewWillAppear:)];
    });
}

- (void)viewDidDisappear_lrfForever{}
- (void)viewWillDisappear_lrfForever:(BOOL)animated{}
- (void)viewWillAppear_lrfFirstTime:(BOOL)animated{}

static char keyViewHadAppeared;

- (void)LRFAppear_viewWillAppear:(BOOL)animated{
    [self LRFAppear_viewWillAppear:animated];
    if (![objc_getAssociatedObject(self, &keyViewHadAppeared) boolValue]) {
        objc_setAssociatedObject(self, &keyViewHadAppeared, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self viewWillAppear_lrfFirstTime:animated];
    }
}

- (void)LRFAppear_viewDidDisappear:(BOOL)animated{
    [self LRFAppear_viewDidDisappear:animated];
    if (![self lrf_isSelfValid]) {
        [self viewDidDisappear_lrfForever];
    }
}

- (void)LRFAppear_viewWillDisappear:(BOOL)animated{
    [self LRFAppear_viewWillDisappear:animated];
    if (![self lrf_isSelfValid]) {
        [self viewWillDisappear_lrfForever:animated];
    }
}

- (BOOL)lrf_isSelfValid{
    BOOL isContain = NO;
    if ([self.tabBarController.viewControllers containsObject:self]) {
        isContain = YES;
    }
    if ([self.navigationController.viewControllers containsObject:self]) {
        isContain = YES;
    }
    if (self.presentedViewController) {
        isContain = YES;
    }
    return isContain;
}

@end

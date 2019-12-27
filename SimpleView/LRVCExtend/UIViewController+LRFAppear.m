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

static char keyViewHadAppeared;

- (void)LRFAppear_viewWillAppear:(BOOL)animated{
    [self LRFAppear_viewWillAppear:animated];
    if (![objc_getAssociatedObject(self, &keyViewHadAppeared) boolValue] && self.lrf_viewWillAppearFirstTime) {
        objc_setAssociatedObject(self, &keyViewHadAppeared, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        self.lrf_viewWillAppearFirstTime(animated);
    }
}

- (void)LRFAppear_viewDidDisappear:(BOOL)animated{
    [self LRFAppear_viewDidDisappear:animated];
    if (![self lrf_isSelfValid] && self.lrf_viewDidDisappearForever) {
        self.lrf_viewDidDisappearForever(animated);
    }
}

- (void)LRFAppear_viewWillDisappear:(BOOL)animated{
    [self LRFAppear_viewWillDisappear:animated];
    if (![self lrf_isSelfValid] && self.lrf_viewWillDisappearForever) {
        self.lrf_viewWillDisappearForever(animated);
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

#pragma mark -

static char keyViewDidDisappearForever;

-(void (^)(BOOL))lrf_viewDidDisappearForever{
    return objc_getAssociatedObject(self, &keyViewDidDisappearForever);
}

-(void)setLrf_viewDidDisappearForever:(void (^)(BOOL))lrf_viewDidDisappearForever{
    objc_setAssociatedObject(self, &keyViewDidDisappearForever, lrf_viewDidDisappearForever, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static char keyViewWillAppearFirstTime;

-(void (^)(BOOL))lrf_viewWillAppearFirstTime{
    return objc_getAssociatedObject(self, &keyViewWillAppearFirstTime);
}

-(void)setLrf_viewWillAppearFirstTime:(void (^)(BOOL))lrf_viewWillAppearFirstTime{
    objc_setAssociatedObject(self, &keyViewWillAppearFirstTime, lrf_viewWillAppearFirstTime, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static char keyViewWillDisappearForever;

-(void (^)(BOOL))lrf_viewWillDisappearForever{
    return objc_getAssociatedObject(self, &keyViewWillDisappearForever);
}

-(void)setLrf_viewWillDisappearForever:(void (^)(BOOL))lrf_viewWillDisappearForever{
    objc_setAssociatedObject(self, &keyViewWillDisappearForever, lrf_viewWillDisappearForever, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

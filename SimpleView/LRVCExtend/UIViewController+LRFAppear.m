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
        [UIViewController lrf_exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(LRFAppear_viewDidAppear:)];
    });
}

- (void)lrf_viewWillAppearFirstTime:(BOOL)animated{}
- (void)lrf_viewWillDisappearForever:(BOOL)animated{}
- (void)lrf_viewDidDisappearForever:(BOOL)animated{}

static char keyViewHadAppeared;

- (void)LRFAppear_viewWillAppear:(BOOL)animated{
    BOOL isFirstTime = NO;
    if (![[self lrf_getAssociatedObjectWithKeyPoint:&keyViewHadAppeared] boolValue]) {
        [self lrf_setStrongAssociatedObject:@(YES) withKeyPoint:&keyViewHadAppeared];
        isFirstTime = YES;
        [self lrf_viewWillAppearFirstTime:animated];
    }
    NSArray<void(^)(BOOL,BOOL)> *actions = [self lrf_getActionsWithKeyPoint:&keyViewWillAppearActions];
    [actions enumerateObjectsUsingBlock:^(void (^ _Nonnull obj)(BOOL, BOOL), NSUInteger idx, BOOL * _Nonnull stop) {
        obj(animated, isFirstTime);
    }];
    [self LRFAppear_viewWillAppear:animated];
}

-(void)LRFAppear_viewDidAppear:(BOOL)animated{
    [self LRFAppear_viewDidAppear:animated];
    NSArray<void(^)(BOOL)> *actions = [self lrf_getActionsWithKeyPoint:&keyViewDidAppearActions];
    [actions enumerateObjectsUsingBlock:^(void (^ _Nonnull obj)(BOOL), NSUInteger idx, BOOL * _Nonnull stop) {
        obj(animated);
    }];
}

- (void)LRFAppear_viewDidDisappear:(BOOL)animated{
    [self LRFAppear_viewDidDisappear:animated];
    BOOL isForever = NO;
    if (![self lrf_isSelfValid]) {
        isForever = YES;
        [self lrf_viewDidDisappearForever:animated];
    }
    NSArray<void(^)(BOOL,BOOL)> *actions = [self lrf_getActionsWithKeyPoint:&keyViewDidDisappearActions];
    [actions enumerateObjectsUsingBlock:^(void (^ _Nonnull obj)(BOOL, BOOL), NSUInteger idx, BOOL * _Nonnull stop) {
        obj(animated, isForever);
    }];
}

- (void)LRFAppear_viewWillDisappear:(BOOL)animated{
    BOOL isForever = NO;
    if (![self lrf_isSelfValid]) {
        isForever = YES;
        [self lrf_viewWillDisappearForever:animated];
    }
    NSArray<void(^)(BOOL,BOOL)> *actions = [self lrf_getActionsWithKeyPoint:&keyViewWillDisappearActions];
    [actions enumerateObjectsUsingBlock:^(void (^ _Nonnull obj)(BOOL, BOOL), NSUInteger idx, BOOL * _Nonnull stop) {
        obj(animated, isForever);
    }];
    [self LRFAppear_viewWillDisappear:animated];
}

- (BOOL)lrf_isSelfValid{
    return [self.navigationController.viewControllers containsObject:self] || self.presentedViewController || [self.tabBarController.viewControllers containsObject:self];
}

#pragma mark -

static char keyViewWillAppearActions;
static char keyViewDidAppearActions;
static char keyViewWillDisappearActions;
static char keyViewDidDisappearActions;

- (void)lrf_addActionWhileViewWillAppear:(void (^)(BOOL, BOOL))action{
    [self lrf_addAction:action withKeyPoint:&keyViewWillAppearActions];
}

- (void)lrf_addActionWhileViewDidAppear:(void (^)(BOOL))action{
    [self lrf_addAction:action withKeyPoint:&keyViewDidAppearActions];
}

- (void)lrf_addActionWhileViewWillDisappear:(void (^)(BOOL, BOOL))action{
    [self lrf_addAction:action withKeyPoint:&keyViewWillDisappearActions];
}

- (void)lrf_addActionWhileViewDidDisappear:(void (^)(BOOL, BOOL))action{
    [self lrf_addAction:action withKeyPoint:&keyViewDidDisappearActions];
}

@end


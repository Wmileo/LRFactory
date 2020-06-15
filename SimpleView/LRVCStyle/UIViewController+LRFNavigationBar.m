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

#pragma mark - hook

static NSMutableSet *hookSet;

- (void)lrf_hookNavigationBarStyle{
    @synchronized (hookSet) {
        if (!hookSet) {
            hookSet = [[NSMutableSet alloc] initWithCapacity:5];
        }
        Class target = [self lrf_hookSubClass];
        if (![hookSet containsObject:target]) {
            [hookSet addObject:target];
            [target lrf_exchangeSEL:@selector(viewDidLoad) withSEL:@selector(LRFNavigationBar_viewDidLoad)];
            [target lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFNavigationBar_viewWillAppear:)];
            [target lrf_exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(LRFNavigationBar_viewDidAppear:)];
            [target lrf_exchangeSEL:@selector(viewWillDisappear:) withSEL:@selector(LRFNavigationBar_viewWillDisappear:)];
        }
    }
}

#pragma mark - inject

- (void)LRFNavigationBar_viewDidLoad{
    [self LRFNavigationBar_viewDidLoad];
    [self.navigationController.lrf_defaultBarStyle endObserve];
}

- (void)LRFNavigationBar_viewWillAppear:(BOOL)animated{
    if (self.navigationController) {
        if (self.lrf_currentBarStyle.isClear) {
            [self.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            [self.lrf_currentBarStyle layoutNavigationBar:animated];
        }
    }
    [self LRFNavigationBar_viewWillAppear:animated];
}

- (void)LRFNavigationBar_viewDidAppear:(BOOL)animated {
    if (self.navigationController) {
        self.lrf_currentBarStyle.isRealTime = YES;
        if (self.lrf_currentBarStyle.isClear) {
            [self.lrf_currentBarStyle layoutNavigationBar:NO];
        }
    }
    [self LRFNavigationBar_viewDidAppear:animated];
}

- (void)LRFNavigationBar_viewWillDisappear:(BOOL)animated{
    if (self.navigationController) {
        self.lrf_currentBarStyle.isRealTime = NO;
        if (self.lrf_currentBarStyle.isClear) {
            [self.navigationController setNavigationBarHidden:YES];
        }
    }
    [self LRFNavigationBar_viewWillDisappear:animated];
}

#pragma mark -

static char keyNavigationBarStyle;

- (LRFNavigationBarStyle *)lrf_currentBarStyle{
    LRFNavigationBarStyle *style = self.navigationController.lrf_defaultBarStyle;
    if (self.lrf_isNavigationBarStyleHandle) {
        style = self.lrf_navigationBarStyle;
    }
    return style;
}

- (LRFNavigationBarStyle *)lrf_navigationBarStyle{
    LRFNavigationBarStyle *style = [self lrf_getAssociatedObjectWithKeyPoint:&keyNavigationBarStyle];
    if (!style) {
        style = [[LRFNavigationBarStyle alloc] init];
        [style bindingViewController:self];
        [self lrf_setNonatomicStrongAssociatedObject:style withKeyPoint:&keyNavigationBarStyle];
        [style updateWithNavigationController:self.navigationController];
        [self lrf_hookNavigationBarStyle];
    }
    return style;
}

- (BOOL)lrf_isNavigationBarStyleHandle{
    return !![self lrf_getAssociatedObjectWithKeyPoint:&keyNavigationBarStyle];
}

@end





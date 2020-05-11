//
//  UIViewController+LRFPush.m
//  Pods
//
//  Created by leo on 2017/7/6.
//
//

#import "UIViewController+LRFPush.h"
#import "UIViewController+LRFactory.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>

@implementation UIViewController (LRFPush)

+ (void)lrf_injectPush{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(LRFPush_viewDidAppear:)];
    });
}

#pragma mark - ignore

static char keyPopIgnore;

- (void)setLrf_popIgnore:(BOOL)lrf_popIgnore{
    [UIViewController lrf_injectPush];
    [self lrf_setStrongAssociatedObject:@(lrf_popIgnore) withKeyAdr:&keyPopIgnore];
    [self lrf_ignoreViewController];
}

- (BOOL)lrf_popIgnore{
    return [[self lrf_getAssociatedObjectWithKeyAdr:&keyPopIgnore] boolValue];
}

- (void)LRFPush_viewDidAppear:(BOOL)animated{
    [self LRFPush_viewDidAppear:animated];
    [self lrf_ignoreViewController];
}

- (void)lrf_ignoreViewController{
    if (self.navigationController) {
        NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:self.navigationController.viewControllers.count];
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!obj.lrf_popIgnore) {
                [vcs addObject:obj];
            }
        }];
        if (![vcs containsObject:self] && self.navigationController.viewControllers.lastObject == self) {
            [vcs addObject:self];
        }
        self.navigationController.viewControllers = vcs;
    }
}

@end

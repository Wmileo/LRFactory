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
    [self lrf_setStrongAssociatedObject:@(lrf_popIgnore) withKeyPoint:&keyPopIgnore];
    [self lrf_ignoreViewController];
}

- (BOOL)lrf_popIgnore{
    return [[self lrf_getAssociatedObjectWithKeyPoint:&keyPopIgnore] boolValue];
}

- (void)LRFPush_viewDidAppear:(BOOL)animated{
    [self LRFPush_viewDidAppear:animated];
    [self lrf_ignoreViewController];
}

- (void)lrf_ignoreViewController{
    if (self.navigationController) {
        NSMutableArray *vcs = [NSMutableArray arrayWithCapacity:self.navigationController.viewControllers.count];
        __block BOOL isChange = NO;
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.lrf_popIgnore && obj != self.navigationController.viewControllers.lastObject) {
                isChange = YES;
            } else{
                [vcs addObject:obj];
            }
        }];
        if (isChange) {
            self.navigationController.viewControllers = vcs;
        }
    }
}

@end

//
//  UIViewController+LRFCompleteChild.m
//  SimpleView
//
//  Created by leo on 2020/6/16.
//  Copyright © 2020 ileo. All rights reserved.
//

#import "UIViewController+LRFCompleteChild.h"
#import "NSObject+LRFactory.h"

@implementation UIViewController (LRFCompleteChild)

static NSMutableSet<Class> *parentViewControllerSet;
static NSMutableSet<Class> *lrf_parentViewControllerSet() {
    if (!parentViewControllerSet) {
        parentViewControllerSet = [[NSMutableSet alloc] initWithCapacity:5];
        [parentViewControllerSet addObject:[UINavigationController class]];
        [parentViewControllerSet addObject:[UITabBarController class]];
        [parentViewControllerSet addObject:NSClassFromString(@"UIInputWindowController")];
    }
    return parentViewControllerSet;
}

+ (void)lrf_registerParentViewController:(Class)viewControllerClass{
    @synchronized (parentViewControllerSet) {
        NSMutableSet<Class> *set = lrf_parentViewControllerSet();
        if (![set containsObject:viewControllerClass]) {
            [set addObject:viewControllerClass];
        }
    }
}

static NSMutableSet<void(^)(UIViewController *vc)> *hookActionSet;

+ (void)lrf_registerHookAction:(void (^)(UIViewController * _Nonnull))action{
    @synchronized (hookActionSet) {
        if (!hookActionSet) {
            hookActionSet = [[NSMutableSet alloc] initWithCapacity:5];
        }
        [hookActionSet addObject:action];
    }
}

- (void)lrf_hookAction{
    NSMutableSet<Class> *set = lrf_parentViewControllerSet();
    for (Class cls in set) {
        if ([self isKindOfClass:cls]) {
            return;
        }
    }
    if (!self.lrf_isCompleteChildViewController) {
        self.lrf_isCompleteChildViewController = YES;
        [hookActionSet enumerateObjectsUsingBlock:^(void (^ _Nonnull obj)(UIViewController *), BOOL * _Nonnull stop) {
            obj(self);
        }];
    }
}

#pragma mark -

static char keyIsCompleteChildViewController;

- (void)setLrf_isCompleteChildViewController:(BOOL)lrf_isCompleteChildViewController{
    [self lrf_setAssignAssociatedObject:@(lrf_isCompleteChildViewController) withKeyPoint:&keyIsCompleteChildViewController];
}

- (BOOL)lrf_isCompleteChildViewController{
    return [[self lrf_getAssociatedObjectWithKeyPoint:&keyIsCompleteChildViewController] boolValue];
}

@end

#pragma mark - hook

@implementation UINavigationController (LRFCompleteChild)

+ (void)load{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UINavigationController lrf_exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(LRFCompleteChild_pushViewController:animated:)];
        [UINavigationController lrf_exchangeSEL:@selector(setViewControllers:animated:) withSEL:@selector(LRFCompleteChild_setViewControllers:animated:)];
    });
}

- (void)LRFCompleteChild_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [viewController lrf_hookAction];
    [self LRFCompleteChild_pushViewController:viewController animated:animated];
}

- (void)LRFCompleteChild_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated{
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj lrf_hookAction];
    }];
    [self LRFCompleteChild_setViewControllers:viewControllers animated:animated];
}

@end

@implementation UITabBarController (LRFCompleteChild)

+ (void)load{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UITabBarController lrf_exchangeSEL:@selector(setViewControllers:animated:) withSEL:@selector(LRFCompleteChild_setViewControllers:animated:)];
    });
}

- (void)LRFCompleteChild_setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers animated:(BOOL)animated{
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj lrf_hookAction];
    }];
    [self LRFCompleteChild_setViewControllers:viewControllers animated:animated];
}

@end

@implementation UIWindow (LRFCompleteChild)

+ (void)load{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIWindow lrf_exchangeSEL:@selector(setRootViewController:) withSEL:@selector(LRFCompleteChild_setRootViewController:)];
    });
}

- (void)LRFCompleteChild_setRootViewController:(UIViewController *)rootViewController{
    [rootViewController lrf_hookAction];
    [self LRFCompleteChild_setRootViewController:rootViewController];
}

@end

//
//  UINavigationController+LRFStyle.m
//  Aspects
//
//  Created by leo on 2020/6/14.
//

#import "UINavigationController+LRFStyle.h"
#import "UIViewController+LRFNavigationBar.h"
#import "NSObject+LRFactory.h"


@implementation UINavigationController (LRFStyle)

+ (void)load{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UINavigationController lrf_exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(LRFStyle_pushViewController:animated:)];
        [UINavigationController lrf_exchangeSEL:@selector(popViewControllerAnimated:) withSEL:@selector(LRFStyle_popViewControllerAnimated:)];
        [UINavigationController lrf_exchangeSEL:@selector(popToViewController:animated:) withSEL:@selector(LRFStyle_popToViewController:animated:)];
        [UINavigationController lrf_exchangeSEL:@selector(popToRootViewControllerAnimated:) withSEL:@selector(LRFStyle_popToRootViewControllerAnimated:)];
        [UINavigationController lrf_exchangeSEL:@selector(setViewControllers:) withSEL:@selector(LRFStyle_setViewControllers:)];
    });
}

static char keyDefaultBarStyle;

- (LRFNavigationBarStyle *)lrf_defaultBarStyle{
    LRFNavigationBarStyle *style = [self lrf_getAssociatedObjectWithKeyPoint:&keyDefaultBarStyle];
    if (!style) {
        style = [[LRFNavigationBarStyle alloc] init];
        [self lrf_setNonatomicStrongAssociatedObject:style withKeyPoint:&keyDefaultBarStyle];
        [style updateWithNavigationController:self];
    }
    return style;
}

static void lrf_updateCurrentViewControllerBarStyle(UINavigationController *self) {
    if (self.visibleViewController.lrf_isNavigationBarStyleHandle) {
        self.visibleViewController.lrf_navigationBarStyle.isRealTime = NO;
        [self.visibleViewController.lrf_navigationBarStyle updateWithNavigationController:self];
    } else {
        self.visibleViewController.lrf_navigationBarStyle.isRealTime = NO;
        [self.lrf_defaultBarStyle updateWithNavigationController:self];
    }
}

static void lrf_hookViewControllerBarStyle(UIViewController *vc, UINavigationController *self) {
    if (!vc.lrf_isNavigationBarStyleHandle) {
        [vc lrf_hookNavigationBarStyle];
        [self.lrf_defaultBarStyle startObserve];
    }
}

- (void)LRFStyle_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    lrf_updateCurrentViewControllerBarStyle(self);
    lrf_hookViewControllerBarStyle(viewController, self);
    [self LRFStyle_pushViewController:viewController animated:animated];
}

- (UIViewController *)LRFStyle_popViewControllerAnimated:(BOOL)animated{
    lrf_updateCurrentViewControllerBarStyle(self);
    return [self LRFStyle_popViewControllerAnimated:animated];
}

- (NSArray<__kindof UIViewController *> *)LRFStyle_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    lrf_updateCurrentViewControllerBarStyle(self);
    return [self LRFStyle_popToViewController:viewController animated:animated];
}

- (NSArray<__kindof UIViewController *> *)LRFStyle_popToRootViewControllerAnimated:(BOOL)animated{
    lrf_updateCurrentViewControllerBarStyle(self);
    return [self LRFStyle_popToRootViewControllerAnimated:animated];
}

- (void)LRFStyle_setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    for (UIViewController *vc in viewControllers) {
        lrf_hookViewControllerBarStyle(vc, self);
    }
    [self LRFStyle_setViewControllers:viewControllers];
}


@end




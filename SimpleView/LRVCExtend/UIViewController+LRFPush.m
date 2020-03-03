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

@interface UINavigationController (LRFPush)

+ (void)lrf_injectLife;

@end

@implementation UIViewController (LRFPush)

+ (void)load{
    [UINavigationController lrf_injectLife];
}

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
    objc_setAssociatedObject(self, &keyPopIgnore, @(lrf_popIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self lrf_ignoreViewController];
}

- (BOOL)lrf_popIgnore{
    return [objc_getAssociatedObject(self, &keyPopIgnore) boolValue];
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

#pragma mark -

static char keyViewWillAppearByNavigationPush;

-(void (^)(BOOL))lrf_viewWillAppearByNavigationPush{
    return objc_getAssociatedObject(self, &keyViewWillAppearByNavigationPush);
}

-(void)setLrf_viewWillAppearByNavigationPush:(void (^)(BOOL))lrf_viewWillAppearByNavigationPush{
    objc_setAssociatedObject(self, &keyViewWillAppearByNavigationPush, lrf_viewWillAppearByNavigationPush, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static char keyViewWillAppearByNavigationPop;

-(void (^)(BOOL))lrf_viewWillAppearByNavigationPop{
    return objc_getAssociatedObject(self, &keyViewWillAppearByNavigationPop);
}

-(void)setLrf_viewWillAppearByNavigationPop:(void (^)(BOOL))lrf_viewWillAppearByNavigationPop{
    objc_setAssociatedObject(self, &keyViewWillAppearByNavigationPop, lrf_viewWillAppearByNavigationPop, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static char keyViewWillDisappearByNavigationPush;

-(void (^)(BOOL))lrf_viewWillDisappearByNavigationPush{
    return objc_getAssociatedObject(self, &keyViewWillDisappearByNavigationPush);
}

-(void)setLrf_viewWillDisappearByNavigationPush:(void (^)(BOOL))lrf_viewWillDisappearByNavigationPush{
    objc_setAssociatedObject(self, &keyViewWillDisappearByNavigationPush, lrf_viewWillDisappearByNavigationPush, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

static char keyViewWillDisappearByNavigationPop;

-(void (^)(BOOL))lrf_viewWillDisappearByNavigationPop{
    return objc_getAssociatedObject(self, &keyViewWillDisappearByNavigationPop);
}

-(void)setLrf_viewWillDisappearByNavigationPop:(void (^)(BOOL))lrf_viewWillDisappearByNavigationPop{
    objc_setAssociatedObject(self, &keyViewWillDisappearByNavigationPop, lrf_viewWillDisappearByNavigationPop, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation UINavigationController (LRFPush)

+ (void)lrf_injectLife{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(LRFPush_pushViewController:animated:)];
        [UINavigationController lrf_exchangeSEL:@selector(popToRootViewControllerAnimated:) withSEL:@selector(LRFPush_popToRootViewControllerAnimated:)];
        [UINavigationController lrf_exchangeSEL:@selector(popToViewController:animated:) withSEL:@selector(LRFPush_popToViewController:animated:)];
        [UINavigationController lrf_exchangeSEL:@selector(popViewControllerAnimated:) withSEL:@selector(LRFPush_popViewControllerAnimated:)];
    });
}

- (void)LRFPush_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.lastObject.lrf_viewWillDisappearByNavigationPush) {
        self.viewControllers.lastObject.lrf_viewWillDisappearByNavigationPush(animated);
    }
    if (viewController.lrf_viewWillAppearByNavigationPush) {
        viewController.lrf_viewWillAppearByNavigationPush(animated);
    }
    [self LRFPush_pushViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)LRFPush_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.lastObject.lrf_viewWillDisappearByNavigationPop) {
        self.viewControllers.lastObject.lrf_viewWillDisappearByNavigationPop(animated);
    }
    if (viewController.lrf_viewWillAppearByNavigationPop) {
        viewController.lrf_viewWillAppearByNavigationPop(animated);
    }
    NSArray<UIViewController *> *vcs = [self LRFPush_popToViewController:viewController animated:animated];
    return vcs;
}

- (UIViewController *)LRFPush_popViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.lastObject.lrf_viewWillDisappearByNavigationPop) {
        self.viewControllers.lastObject.lrf_viewWillDisappearByNavigationPop(animated);
    }
    if (self.viewControllers.lastObject.lrf_prevNavigationViewController.lrf_viewWillAppearByNavigationPop) {
        self.viewControllers.lastObject.lrf_prevNavigationViewController.lrf_viewWillAppearByNavigationPop(animated);
    }
    UIViewController *vc = [self LRFPush_popViewControllerAnimated:animated];
    return vc;
}

- (NSArray<UIViewController *> *)LRFPush_popToRootViewControllerAnimated:(BOOL)animated{
    if (self.viewControllers.lastObject.lrf_viewWillDisappearByNavigationPop) {
        self.viewControllers.lastObject.lrf_viewWillDisappearByNavigationPop(animated);
    }
    if (self.viewControllers.firstObject.lrf_viewWillAppearByNavigationPop) {
        self.viewControllers.firstObject.lrf_viewWillAppearByNavigationPop(animated);
    }
    NSArray<UIViewController *> *vcs = [self LRFPush_popToRootViewControllerAnimated:animated];
    return vcs;
}

@end


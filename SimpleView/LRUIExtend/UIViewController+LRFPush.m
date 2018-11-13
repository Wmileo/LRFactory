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

+(void)lrf_injectPush{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(LRFPush_viewDidAppear:)];
    });
}

#pragma mark - ignore

static char keyPopIgnore;

-(void)setLrf_popIgnore:(BOOL)lrf_popIgnore{
    [UIViewController lrf_injectPush];
    objc_setAssociatedObject(self, &keyPopIgnore, @(lrf_popIgnore), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self lrf_ignoreViewController];
}

-(BOOL)lrf_popIgnore{
    return [objc_getAssociatedObject(self, &keyPopIgnore) boolValue];
}

-(void)LRFPush_viewDidAppear:(BOOL)animated{
    [self LRFPush_viewDidAppear:animated];
    [self lrf_ignoreViewController];
}

-(void)lrf_ignoreViewController{
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

- (void)viewWillAppear_lrfByNavigationPush:(BOOL)animated{}
- (void)viewWillAppear_lrfByNavigationPop:(BOOL)animate{}
- (void)viewWillDisappear_lrfByNavigationPush:(BOOL)animated{}
- (void)viewWillDisappear_lrfByNavigationPop:(BOOL)animated{}

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
    [self.viewControllers.lastObject viewWillDisappear_lrfByNavigationPush:animated];
    [viewController viewWillAppear_lrfByNavigationPush:animated];
    [self LRFPush_pushViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)LRFPush_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.viewControllers.lastObject viewWillDisappear_lrfByNavigationPop:animated];
    [viewController.navLastViewController viewWillAppear_lrfByNavigationPop:animated];
    NSArray<UIViewController *> *vcs = [self LRFPush_popToViewController:viewController animated:animated];
    return vcs;
}

- (UIViewController *)LRFPush_popViewControllerAnimated:(BOOL)animated{
    [self.viewControllers.lastObject viewWillDisappear_lrfByNavigationPop:animated];
    [self.viewControllers.lastObject.navLastViewController viewWillAppear_lrfByNavigationPop:animated];
    UIViewController *vc = [self LRFPush_popViewControllerAnimated:animated];
    return vc;
}

- (NSArray<UIViewController *> *)LRFPush_popToRootViewControllerAnimated:(BOOL)animated{
    [self.viewControllers.lastObject viewWillDisappear_lrfByNavigationPop:animated];
    [self.viewControllers.firstObject viewWillAppear_lrfByNavigationPop:animated];
    NSArray<UIViewController *> *vcs = [self LRFPush_popToRootViewControllerAnimated:animated];
    return vcs;
}


@end


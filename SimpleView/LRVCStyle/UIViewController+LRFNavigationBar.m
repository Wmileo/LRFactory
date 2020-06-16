//
//  UIViewController+LRFNavigationBar.m
//  SimpleView
//
//  Created by leo on 2018/11/14.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFNavigationBar.h"
#import "UIViewController+LRFCompleteChild.h"
#import "UIViewController+LRFactory.h"
#import "NSObject+LRFactory.h"

@interface LRFNavigationBarStyle ()

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UINavigationController *navigationController;
@property (readonly) UINavigationBar *navigationBar;
@property (readonly) BOOL isNavigationBarValid;

@property (nonatomic, assign) BOOL isObserving;

- (void)bindingViewController:(UIViewController *)viewController;

- (void)updateWithNavigationController:(UINavigationController *)navigationController;
- (void)updateWithNavigationBarStyle:(LRFNavigationBarStyle *)style;

- (void)layoutNavigationBar:(BOOL)animated;

- (void)startObserve;
- (void)endObserve;

@property (nonatomic, assign) BOOL isRealTime;

@end


@interface UINavigationController (LRFStyle)

@property (nonatomic, readonly) LRFNavigationBarStyle *lrf_defaultBarStyle;

@end

@implementation UIViewController (LRFNavigationBar)

#pragma mark - hook

static NSMutableSet *hookSet;

static void lrf_hookNavigationBarStyle(UIViewController *vc) {
    @synchronized (hookSet) {
        if (!hookSet) {
            hookSet = [[NSMutableSet alloc] initWithCapacity:5];
        }
        Class target = [vc lrf_hookSubClass];
        if (![hookSet containsObject:target]) {
            [hookSet addObject:target];
            [target lrf_exchangeSEL:@selector(viewDidLoad) withSEL:@selector(LRFNavigationBar_viewDidLoad)];
            [target lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFNavigationBar_viewWillAppear:)];
            [target lrf_exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(LRFNavigationBar_viewDidAppear:)];
            [target lrf_exchangeSEL:@selector(viewWillDisappear:) withSEL:@selector(LRFNavigationBar_viewWillDisappear:)];
        }
    }
}

+ (void)load{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIViewController lrf_registerHookAction:^(UIViewController * _Nonnull vc) {
            lrf_hookNavigationBarStyle(vc);
        }];
    });
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
    }
    return style;
}

- (BOOL)lrf_isNavigationBarStyleHandle{
    return !![self lrf_getAssociatedObjectWithKeyPoint:&keyNavigationBarStyle];
}

@end

#pragma mark - 


@implementation UINavigationController (LRFStyle)

+ (void)load{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UINavigationController lrf_exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(LRFStyle_pushViewController:animated:)];
        [UINavigationController lrf_exchangeSEL:@selector(popViewControllerAnimated:) withSEL:@selector(LRFStyle_popViewControllerAnimated:)];
        [UINavigationController lrf_exchangeSEL:@selector(popToViewController:animated:) withSEL:@selector(LRFStyle_popToViewController:animated:)];
        [UINavigationController lrf_exchangeSEL:@selector(popToRootViewControllerAnimated:) withSEL:@selector(LRFStyle_popToRootViewControllerAnimated:)];
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

static void lrf_handleWillAppearController(UIViewController *vc, UINavigationController *self) {
    if (!vc.lrf_isNavigationBarStyleHandle) {
        [self.lrf_defaultBarStyle startObserve];
    }
}

- (void)LRFStyle_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    lrf_updateCurrentViewControllerBarStyle(self);
    lrf_handleWillAppearController(viewController, self);
    [self LRFStyle_pushViewController:viewController animated:animated];
}

- (UIViewController *)LRFStyle_popViewControllerAnimated:(BOOL)animated{
    lrf_updateCurrentViewControllerBarStyle(self);
    NSUInteger count = self.viewControllers.count;
    if (count >= 2) {
        lrf_handleWillAppearController(self.viewControllers[count - 2], self);
    }
    return [self LRFStyle_popViewControllerAnimated:animated];
}

- (NSArray<__kindof UIViewController *> *)LRFStyle_popToViewController:(UIViewController *)viewController animated:(BOOL)animated{
    lrf_updateCurrentViewControllerBarStyle(self);
    lrf_handleWillAppearController(viewController, self);
    return [self LRFStyle_popToViewController:viewController animated:animated];
}

- (NSArray<__kindof UIViewController *> *)LRFStyle_popToRootViewControllerAnimated:(BOOL)animated{
    lrf_updateCurrentViewControllerBarStyle(self);
    lrf_handleWillAppearController(self.viewControllers.firstObject, self);
    return [self LRFStyle_popToRootViewControllerAnimated:animated];
}

@end


@implementation LRFNavigationBarStyle

- (void)bindingViewController:(UIViewController *)viewController{
    self.viewController = viewController;
    self.navigationController = viewController.navigationController;
}

- (void)layoutNavigationBar:(BOOL)animated {
    UINavigationController *navigationController = self.navigationController ? self.navigationController : self.viewController.navigationController;
    if (navigationController) {
        [navigationController setNavigationBarHidden:self.isHidden animated:animated];
        if (!self.isHidden) {
            UINavigationBar *bar = navigationController.navigationBar;
            if (self.isClear) {
                [bar setBarTintColor:[UIColor clearColor]];
                [bar setTranslucent:YES];
                [bar setShadowImage:[UIImage new]];
                [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            } else {
                [bar setBarTintColor:self.tintColor];
                [bar setShadowImage:self.shadowImage];
                [bar setTranslucent:self.isTranslucent];
                [bar setBackgroundImage:self.backgroundImage forBarMetrics:UIBarMetricsDefault];
            }
            [bar setTintColor:self.itemTintColor];
            [bar setTitleTextAttributes:self.titleTextAttributes];
        }
    }
}

- (void)updateWithNavigationBarStyle:(LRFNavigationBarStyle *)style{
    if (style) {
        self.isHidden = style.isHidden;
        self.tintColor = style.tintColor;
        self.itemTintColor = style.itemTintColor;
        self.titleTextAttributes = style.titleTextAttributes;
        self.titleFont = style.titleFont;
        self.titleColor = style.titleColor;
        self.shadowImage = style.shadowImage;
        self.backgroundImage = style.backgroundImage;
        self.isTranslucent = style.isTranslucent;
        self.isClear = style.isClear;
    }
}

- (void)updateWithNavigationController:(UINavigationController *)navigationController{
    if (navigationController) {
        self.navigationController = navigationController;
        self.isHidden = navigationController.navigationBarHidden;
        UINavigationBar *bar = navigationController.navigationBar;
        self.tintColor = bar.barTintColor;
        self.itemTintColor = bar.tintColor;
        self.titleTextAttributes = bar.titleTextAttributes;
        self.titleFont = bar.titleTextAttributes[NSFontAttributeName];
        self.titleColor = bar.titleTextAttributes[NSForegroundColorAttributeName];
        self.shadowImage = bar.shadowImage;
        self.backgroundImage = [bar backgroundImageForBarMetrics:UIBarMetricsDefault];
        self.isTranslucent = bar.translucent;
    }
}

#pragma mark - observie

- (void)startObserve{
    self.isObserving = YES;
    [self.navigationController addObserver:self forKeyPath:@"navigationBarHidden" options:NSKeyValueObservingOptionNew context:nil];
    [self.navigationController.navigationBar addObserver:self forKeyPath:@"barTintColor" options:NSKeyValueObservingOptionNew context:nil];
    [self.navigationController.navigationBar addObserver:self forKeyPath:@"tintColor" options:NSKeyValueObservingOptionNew context:nil];
    [self.navigationController.navigationBar addObserver:self forKeyPath:@"titleTextAttributes" options:NSKeyValueObservingOptionNew context:nil];
    [self.navigationController.navigationBar addObserver:self forKeyPath:@"shadowImage" options:NSKeyValueObservingOptionNew context:nil];
    [self.navigationController.navigationBar addObserver:self forKeyPath:@"translucent" options:NSKeyValueObservingOptionNew context:nil];
    [self.navigationController.navigationBar addObserver:self forKeyPath:@"backgroundImage" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)endObserve{
    if (self.isObserving) {
        self.isObserving = NO;
        [self.navigationController removeObserver:self forKeyPath:@"navigationBarHidden"];
        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"barTintColor"];
        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"tintColor"];
        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"titleTextAttributes"];
        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"shadowImage"];
        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"translucent"];
        [self.navigationController.navigationBar removeObserver:self forKeyPath:@"backgroundImage"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    UINavigationController *navigationController = self.navigationController;
    UINavigationBar *bar = navigationController.navigationBar;
    if ([keyPath isEqualToString:@"navigationBarHidden"]) {
        self.isHidden = navigationController.navigationBarHidden;
    } else if ([keyPath isEqualToString:@"barTintColor"]) {
        self.tintColor = bar.barTintColor;
    } else if ([keyPath isEqualToString:@"tintColor"]) {
        self.itemTintColor = bar.tintColor;
    } else if ([keyPath isEqualToString:@"titleTextAttributes"]) {
        self.titleTextAttributes = bar.titleTextAttributes;
        self.titleFont = bar.titleTextAttributes[NSFontAttributeName];
        self.titleColor = bar.titleTextAttributes[NSForegroundColorAttributeName];
    } else if ([keyPath isEqualToString:@"shadowImage"]) {
        self.shadowImage = bar.shadowImage;
    } else if ([keyPath isEqualToString:@"translucent"]) {
        self.isTranslucent = bar.translucent;
    } else if ([keyPath isEqualToString:@"backgroundImage"]) {
        self.backgroundImage = [bar backgroundImageForBarMetrics:UIBarMetricsDefault];
    }
}

- (void)dealloc{
    [self endObserve];
}

#pragma mark - set get

- (BOOL)isNavigationBarValid{
    return self.isRealTime && self.viewController.navigationController && self.viewController.lrf_isVisible;
}

- (UINavigationBar *)navigationBar{
    return self.viewController.navigationController.navigationBar;
}

- (void)setIsHidden:(BOOL)isHidden{
    [self setIsHidden:isHidden animated:NO];
}

- (void)setIsHidden:(BOOL)isHidden animated:(BOOL)animated{
    _isHidden = isHidden;
    if (self.isNavigationBarValid) {
        [self layoutNavigationBar:animated];
    }
}

- (void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
    if (self.isNavigationBarValid) {
        [self.navigationBar setBarTintColor:tintColor];
    }
}

- (void)setItemTintColor:(UIColor *)itemTintColor{
    _itemTintColor = itemTintColor;
    if (self.isNavigationBarValid) {
        [self.navigationBar setTintColor:itemTintColor];
    }
}

- (void)setTitleTextAttributes:(NSDictionary<NSAttributedStringKey,id> *)titleTextAttributes{
    _titleTextAttributes = titleTextAttributes;
    if (self.isNavigationBarValid) {
        [self.navigationBar setTitleTextAttributes:titleTextAttributes];
    }
}

- (void)setTitleFont:(UIFont *)titleFont{
    _titleFont = titleFont;
    if (titleFont) {
        NSMutableDictionary<NSAttributedStringKey,id> *attr = [NSMutableDictionary dictionaryWithDictionary:self.titleTextAttributes];
        attr[NSFontAttributeName] = titleFont;
        self.titleTextAttributes = [attr copy];
    }
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    if (titleColor) {
        NSMutableDictionary<NSAttributedStringKey,id> *attr = [NSMutableDictionary dictionaryWithDictionary:self.titleTextAttributes];
        attr[NSForegroundColorAttributeName] = titleColor;
        self.titleTextAttributes = [attr copy];
    }
}

- (void)setShadowImage:(UIImage *)shadowImage{
    _shadowImage = shadowImage;
    if (self.isNavigationBarValid) {
        [self.navigationBar setShadowImage:shadowImage];
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage{
    _backgroundImage = backgroundImage;
    if (self.isNavigationBarValid) {
        [self.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)setIsTranslucent:(BOOL)isTranslucent{
    _isTranslucent = isTranslucent;
    if (self.isNavigationBarValid) {
        [self.navigationBar setTranslucent:isTranslucent];
    }
}

- (void)setIsClear:(BOOL)isClear{
    _isClear = isClear;
    if (self.isNavigationBarValid) {
        [self layoutNavigationBar:NO];
    }
}

@end

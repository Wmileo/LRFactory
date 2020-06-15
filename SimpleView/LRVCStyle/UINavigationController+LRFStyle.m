//
//  UINavigationController+LRFStyle.m
//  Aspects
//
//  Created by leo on 2020/6/14.
//

#import "UINavigationController+LRFStyle.h"
#import "UIViewController+LRFNavigationBar.h"
#import "UIViewController+LRFactory.h"
#import "NSObject+LRFactory.h"

@interface LRFNavigationBarStyle ()

@property (nonatomic, weak) UIViewController *viewController;
@property (nonatomic, weak) UINavigationController *navigationController;
@property (readonly) UINavigationBar *navigationBar;
@property (readonly) BOOL isNavigationBarValid;

@property (nonatomic, assign) BOOL isObserving;

@end


@implementation LRFNavigationBarStyle

+ (LRFNavigationBarStyle *)styleWithNavigationController:(UINavigationController *)navigationController{
    LRFNavigationBarStyle *style = [[LRFNavigationBarStyle alloc] init];
    [style updateWithNavigationController:navigationController];
    return style;
}

- (void)bindingViewController:(UIViewController *)viewController{
    self.viewController = viewController;
    self.navigationController = viewController.navigationController;
}

- (void)layoutNavigationBar:(BOOL)animated {
    UINavigationController *navigationController = self.navigationController;
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




//
//  UIViewController+LRFNavigationTitle.m
//  SimpleView
//
//  Created by leo on 2018/11/13.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFNavigationTitle.h"
#import "UIViewController+LRFactory.h"
#import "NSObject+LRFactory.h"


@implementation UIViewController (LRFNavigationTitle)

#pragma mark - inject

+(void)lrf_injectNavigationTitle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFTitle_viewWillAppear:)];
    });
}

-(void)LRFTitle_viewWillAppear:(BOOL)animated{
    [self LRFTitle_viewWillAppear:animated];
    if (!self.lrf_isKitController && self.navigationController && self.lrf_isFinalController) {
        [self.navigationController.navigationBar setTitleTextAttributes:self.lrf_titleTextAttributes];
    }
}

#pragma mark - setget

-(NSDictionary *)lrf_titleTextAttributes{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
    if (self.lrf_navigationTitleFont) {
        dic[NSFontAttributeName] = self.lrf_navigationTitleFont;
    }
    if (self.lrf_navigationTitleColor) {
        dic[NSForegroundColorAttributeName] = self.lrf_navigationTitleColor;
    }
    return [dic copy];
}

static char keyNavigationTitleColor;

- (void)setLrf_navigationTitleColor:(UIColor *)lrf_navigationTitleColor{
    [UIViewController lrf_injectNavigationTitle];
    objc_setAssociatedObject(self, &keyNavigationTitleColor, lrf_navigationTitleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController && self.lrf_isVisible) {
        self.navigationController.navigationBar.titleTextAttributes = self.lrf_titleTextAttributes;
    }
}

- (UIColor *)lrf_navigationTitleColor{
    if (objc_getAssociatedObject(self, &keyNavigationTitleColor)) {
        return objc_getAssociatedObject(self, &keyNavigationTitleColor);
    }else{
        return self.navigationController.navigationBar.titleTextAttributes[NSForegroundColorAttributeName];
    }
}

static char keyNavigationTitleFont;

- (void)setLrf_navigationTitleFont:(UIFont *)lrf_navigationTitleFont{
    [UIViewController lrf_injectNavigationTitle];
    objc_setAssociatedObject(self, &keyNavigationTitleFont, lrf_navigationTitleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.navigationController && self.lrf_isVisible) {
        self.navigationController.navigationBar.titleTextAttributes = self.lrf_titleTextAttributes;
    }
}

- (UIFont *)lrf_navigationTitleFont{
    if (objc_getAssociatedObject(self, &keyNavigationTitleFont)) {
        return objc_getAssociatedObject(self, &keyNavigationTitleFont);
    }else{
        return self.navigationController.navigationBar.titleTextAttributes[NSFontAttributeName];
    }
}

@end

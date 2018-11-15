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
#import <objc/runtime.h>


@implementation UIViewController (LRFNavigationTitle)

static char keyTitleTextAttributes;

- (void)lrf_setupNavigationTitleColor:(UIColor *)color font:(UIFont *)font{
    [UIViewController lrf_injectNavigationTitle];
    NSDictionary *textAttributes = @{NSFontAttributeName : font, NSForegroundColorAttributeName : color};
    objc_setAssociatedObject(self, &keyTitleTextAttributes, textAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (self.navigationController && self.lrf_isVisible) {
        self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    }
}

#pragma mark - inject

+(void)lrf_injectNavigationTitle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFTitle_viewWillAppear:)];
    });
}

-(void)LRFTitle_viewWillAppear:(BOOL)animated{
    [self LRFTitle_viewWillAppear:animated];
    if (self.navigationController && self.lrf_isVisible) {
        [self.navigationController.navigationBar setTitleTextAttributes:self.lrf_titleTextAttributes];
    }
}

#pragma mark - setget

-(NSDictionary *)lrf_titleTextAttributes{
    if (objc_getAssociatedObject(self, &keyTitleTextAttributes)) {
        return objc_getAssociatedObject(self, &keyTitleTextAttributes);
    }else{
        return self.navigationController.navigationBar.titleTextAttributes;
    }
}

@end

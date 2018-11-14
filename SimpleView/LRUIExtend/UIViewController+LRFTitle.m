//
//  UIViewController+LRFTitle.m
//  SimpleView
//
//  Created by leo on 2018/11/13.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFTitle.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>


@implementation UIViewController (LRFTitle)

static char keyNewTitleTextAttributes;
static char keyOldTitleTextAttributes;

- (void)lrf_setupNavTitleColor:(UIColor *)color font:(UIFont *)font{
    [UIViewController lrf_injectNavTitle];
    NSDictionary *textAttributes = @{NSFontAttributeName : font, NSForegroundColorAttributeName : color};
    objc_setAssociatedObject(self, &keyNewTitleTextAttributes, textAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (self.navigationController) {
        [self lrf_tryRegisterOldTextAttributes];
        self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    }
}

#pragma mark - inject

+(void)lrf_injectNavTitle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFTitle_viewWillAppear:)];
    });
}

-(void)LRFTitle_viewWillAppear:(BOOL)animated{
    [self LRFTitle_viewWillAppear:animated];
    if (self.presentedViewController) {
        return;
    }
    [self lrf_tryRegisterOldTextAttributes];
    if (self.lrf_newTitleTextAttributes) {
        [self.navigationController.navigationBar setTitleTextAttributes:self.lrf_newTitleTextAttributes];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:self.lrf_oldTitleTextAttributes];
    }
}

-(void)lrf_tryRegisterOldTextAttributes{
    if (!self.lrf_oldTitleTextAttributes) {
        objc_setAssociatedObject(self, &keyOldTitleTextAttributes, self.navigationController.navigationBar.titleTextAttributes, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

#pragma mark - setget

-(NSDictionary *)lrf_newTitleTextAttributes{
    return objc_getAssociatedObject(self, &keyNewTitleTextAttributes);
}

-(NSDictionary *)lrf_oldTitleTextAttributes{
    return objc_getAssociatedObject(self, &keyOldTitleTextAttributes);
}

@end

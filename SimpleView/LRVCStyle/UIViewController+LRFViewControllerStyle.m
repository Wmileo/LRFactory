//
//  UIViewController+LRFViewControllerStyle.m
//  SimpleView
//
//  Created by leo on 2018/11/21.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFViewControllerStyle.h"
#import "NSObject+LRFactory.h"
#import "UIViewController+LRFactory.h"
#import "UIViewController+LRFPresent.h"
#import <objc/runtime.h>

@implementation UIViewController (LRFViewControllerStyle)

NSDictionary *lrf_styles;
NSString *lrf_defaultStyleIdentifier;

+ (void)lrf_styleAddWithIdentifier:(NSString *)identifier style:(void (^)(UIViewController *))style{
    [UIViewController lrf_injectViewControllerStyle];
    if (!lrf_styles) {
        lrf_styles = @{};
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:lrf_styles];
    dic[identifier] = style;
    lrf_styles = [dic copy];
}

+ (void)lrf_styleSetupDefaultIdentifier:(NSString *)identifier{
    lrf_defaultStyleIdentifier = identifier;
}

#pragma mark - inject

+ (void)lrf_injectViewControllerStyle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewDidLoad) withSEL:@selector(LRFViewControllerStyle_viewDidLoad)];
    });
}

- (void)LRFViewControllerStyle_viewDidLoad{
    [self LRFViewControllerStyle_viewDidLoad];
    if (self.lrf_isVisible || self.lrf_viewControllerByPresent.lrf_isVisible) {
        void (^Block)(UIViewController *vc) = lrf_styles[self.lrf_styleIdentifier];
        Block(self);
    }
}

#pragma mark - set get

static char keyStyleIdentifier;

- (void)setLrf_styleIdentifier:(NSString *)lrf_styleIdentifier{
    objc_setAssociatedObject(self, &keyStyleIdentifier, lrf_styleIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (lrf_styleIdentifier) {
        void (^Block)(UIViewController *vc) = lrf_styles[lrf_styleIdentifier];
        Block(self);
    }
}

- (NSString *)lrf_styleIdentifier{
    if (objc_getAssociatedObject(self, &keyStyleIdentifier)) {
        return objc_getAssociatedObject(self, &keyStyleIdentifier);
    }else if (lrf_defaultStyleIdentifier){
        return lrf_defaultStyleIdentifier;
    }else{
        return lrf_styles.allKeys.firstObject;
    }
}

@end

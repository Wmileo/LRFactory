//
//  UIViewController+LRFNavigationButton.m
//  SimpleView
//
//  Created by leo on 2018/11/19.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFNavigationButton.h"
#import <objc/runtime.h>


@interface UIViewController ()

@end

@interface UINavigationController (LRFNavigationButton)

@end


@implementation UIViewController (LRFNavigationButton)

- (void)lrf_setupNavigationItemWithText:(NSString *)text side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action{
    [self lrf_setupNavigationItemWithText:text color:self.lrf_navigationItemColor font:self.lrf_navigationItemFont side:side action:action];
}

- (void)lrf_addNavigationItemWithText:(NSString *)text side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action{
    [self lrf_addNavigationItemWithText:text color:self.lrf_navigationItemColor font:self.lrf_navigationItemFont side:side action:action];
}

#pragma mark -

static char keyNavigationButtonColor;

- (void)setLrf_navigationItemColor:(UIColor *)lrf_navigationItemColor{
    objc_setAssociatedObject(self, &keyNavigationButtonColor, lrf_navigationItemColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)lrf_navigationItemColor{
    if (objc_getAssociatedObject(self, &keyNavigationButtonColor)) {
        return objc_getAssociatedObject(self, &keyNavigationButtonColor);
    }else{
        return [UIColor blackColor];
    }
}

static char keyNavigationButtonFont;

- (void)setLrf_navigationItemFont:(UIFont *)lrf_navigationItemFont{
    objc_setAssociatedObject(self, &keyNavigationButtonFont, lrf_navigationItemFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIFont *)lrf_navigationItemFont{
    if (objc_getAssociatedObject(self, &keyNavigationButtonFont)) {
        return objc_getAssociatedObject(self, &keyNavigationButtonFont);
    }else{
        return [UIFont systemFontOfSize:16];
    }
}


@end


@implementation UINavigationController (LRFNavigationButton)



@end

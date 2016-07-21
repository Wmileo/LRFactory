//
//  UIViewController+NavBackgroundStyle.m
//  SimpleView
//
//  Created by ileo on 16/5/12.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+NavBackgroundStyle.h"
#import "UIViewController+SimpleNavigation.h"
#import "UINavigationController+SimpleFactory.h"
#import "UINavigationController+BackButtonStyle.h"
#import "UIView+SimpleFactory.h"
#import "UIView+Sizes.h"
#import <objc/runtime.h>
#import "NSObject+Method.h"

@implementation UIViewController (NavBackgroundStyle)

+(void)configNavBackgroundStyle{

    [UINavigationController removeNavigationBarBackground];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(viewWillLayoutSubviews) withSEL:@selector(NavBackgroundStyle_viewWillLayoutSubviews)];
    });
    
}

-(void)NavBackgroundStyle_viewWillLayoutSubviews{
    [self NavBackgroundStyle_viewWillLayoutSubviews];
    if (self.navigationController) {
        [self.view bringSubviewToFront:self.navView];
    }
}



static char keyNavView;

-(UIView *)navView{
    UIView *vc = objc_getAssociatedObject(self, &keyNavView);
    if (!vc) {
        UIColor *color;
        if ([self respondsToSelector:@selector(navBackgroundColor)]) {
            color = [self performSelector:@selector(navBackgroundColor)];
        }else{
            color = [UIViewController navBackgroundColor];
        }
        vc = [[[UIView viewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)] resetBackgroundColor:color] setupOnView:self.view];
        objc_setAssociatedObject(self, &keyNavView, vc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    vc.top = -self.view.screenViewY;
    return vc;
}

@end

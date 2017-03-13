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
#import "SimpleViewHeader.h"

@implementation UIViewController (NavBackgroundStyle)

+(void)configNavBackgroundStyle{

    [UINavigationController removeNavigationBarBackground];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(viewWillLayoutSubviews) withSEL:@selector(NavBackgroundStyle_viewWillLayoutSubviews)];
        [UIViewController exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(NavBackgroundStyle_viewWillAppear:)];
        [UIViewController exchangeSEL:@selector(viewWillDisappear:) withSEL:@selector(NavBackgroundStyle_viewWillDisappear:)];
        [UIViewController exchangeSEL:@selector(setStatusBarHidden:) withSEL:@selector(NavBackgroundStyle_setStatusBarHidden:)];
    });
    
}

-(void)NavBackgroundStyle_viewWillLayoutSubviews{
    [self NavBackgroundStyle_viewWillLayoutSubviews];
    if (self.navigationController) {
        [self.view bringSubviewToFront:self.navigationBarBackGroundView];
    }
}

-(void)NavBackgroundStyle_viewWillDisappear:(BOOL)animated{
    [self NavBackgroundStyle_viewWillDisappear:animated];
    if (self.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
}

-(void)NavBackgroundStyle_viewWillAppear:(BOOL)animated{
    [self NavBackgroundStyle_viewWillAppear:animated];
    if (self.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

static char keyNavView;
static char keyNavHide;


-(void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    self.navigationBarBackGroundView.hidden = navigationBarHidden;
    objc_setAssociatedObject(self, &keyNavHide, @(navigationBarHidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNavigationBarHidden:navigationBarHidden animated:NO];
}

-(BOOL)navigationBarHidden{
    return [objc_getAssociatedObject(self, &keyNavHide) boolValue];
}

-(void)NavBackgroundStyle_setStatusBarHidden:(BOOL)statusBarHidden{
    [self NavBackgroundStyle_setStatusBarHidden:statusBarHidden];
    self.navigationBarBackGroundView.height = statusBarHidden ? 44 : 64;
}

-(UIView *)navigationBarBackGroundView{
    UIView *vc = objc_getAssociatedObject(self, &keyNavView);
    if (!vc) {
        UIColor *color;
        if ([self respondsToSelector:@selector(navBackgroundColor)]) {
            color = [self performSelector:@selector(navBackgroundColor)];
        }else{
            color = [UIViewController navBackgroundColor];
        }
        vc = [[UIView viewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.statusBarHidden ? 44 : 64)] resetBackgroundColor:color];
        objc_setAssociatedObject(self, &keyNavView, vc, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    if (self.view) {
        [self.view setClipsToBounds:NO];
        if (!vc.superview) {
            [self.view addSubview:vc];
        }
    }
    vc.top = -self.view.screenViewY;
    return vc;
}

@end

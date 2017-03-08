//
//  UIViewController+SimpleStatus.m
//  SimpleView
//
//  Created by leo on 2017/3/8.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+SimpleStatus.h"
#import "UINavigationController+SimpleFactory.h"
#import "UIViewController+SimpleNavigation.h"
#import "NSObject+Method.h"

@implementation UIViewController (SimpleStatus)

static UIStatusBarStyle defaultStatusBarStyle;

+(void)configDefaultPreferredStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    [UINavigationController configChildViewControllerForStatusBarStyle];
    defaultStatusBarStyle = statusBarStyle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(preferredStatusBarStyle) withSEL:@selector(SimpleStatus_preferredStatusBarStyle)];
        [UIViewController exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(SimpleStatus_viewWillAppear:)];
        [UIViewController exchangeSEL:@selector(viewWillDisappear:) withSEL:@selector(SimpleStatus_viewWillDisappear:)];
    });
}

-(UIStatusBarStyle)SimpleStatus_preferredStatusBarStyle{
    return defaultStatusBarStyle;
}

-(void)SimpleStatus_viewWillAppear:(BOOL)animated{
    [self SimpleStatus_viewWillAppear:animated];
    if (self.statusHide) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:animated];
    }
}

-(void)SimpleStatus_viewWillDisappear:(BOOL)animated{
    [self SimpleStatus_viewWillDisappear:animated];
    if (self.statusHide &&
        !(self.navNextViewController && self.navNextViewController.statusHide) &&
        !(self.navLastViewController && self.navLastViewController.statusHide)
        ) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:animated];
    }
}


static char keyStatusHide;

-(void)setStatusHide:(BOOL)statusHide{
    objc_setAssociatedObject(self, &keyStatusHide, @(statusHide), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[UIApplication sharedApplication] setStatusBarHidden:statusHide withAnimation:NO];
}

-(BOOL)statusHide{
    return [objc_getAssociatedObject(self, &keyStatusHide) boolValue];
}


@end

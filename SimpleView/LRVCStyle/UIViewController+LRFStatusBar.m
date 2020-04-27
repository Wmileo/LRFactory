//
//  UIViewController+LRFStatusBar.m
//  SimpleView
//
//  Created by leo on 2018/11/8.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFStatusBar.h"
#import "NSObject+LRFactory.h"
#import "UIViewController+LRFactory.h"

@implementation UIViewController (LRFStatusBar)

#pragma mark - inject

+ (void)lrf_injectStatus{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController lrf_exchangeSEL:@selector(viewWillAppear:) withSEL:@selector(LRFStatus_viewWillAppear:)];
    });
}

-(void)LRFStatus_viewWillAppear:(BOOL)animated{
    [self LRFStatus_viewWillAppear:animated];
    if (!self.lrf_isKitController && self.lrf_isFinalController) {
        [[UIApplication sharedApplication] setStatusBarStyle:self.lrf_statusBarStyle animated:animated];
        [[UIApplication sharedApplication] setStatusBarHidden:self.lrf_statusBarHidden withAnimation:self.lrf_statusBarAnimation];
    }
}

#pragma mark - set get

static char keyStatusBarStyle;
static char keyStatusBarHidden;
static char keyStatusBarAnimation;

- (void)setLrf_statusBarHidden:(BOOL)lrf_statusBarHidden{
    [self setLrf_statusBarHidden:lrf_statusBarHidden withAnimation:self.lrf_statusBarAnimation];
}

-(void)setLrf_statusBarHidden:(BOOL)lrf_statusBarHidden withAnimation:(UIStatusBarAnimation)lrf_statusBarAnimation{
    [UIViewController lrf_injectStatus];
    [self lrf_setNonatomicStrongAssociatedObject:@(lrf_statusBarHidden) withKey:&keyStatusBarHidden];
    [self lrf_setNonatomicStrongAssociatedObject:@(lrf_statusBarAnimation) withKey:&keyStatusBarAnimation];
    if (self.lrf_isVisible) {
        [[UIApplication sharedApplication] setStatusBarHidden:self.lrf_statusBarHidden withAnimation:self.lrf_statusBarAnimation];
    }
}

- (BOOL)lrf_statusBarHidden{
    id hidden = [self lrf_getAssociatedObjectWithKey:&keyStatusBarHidden];
    if (hidden) {
        return [hidden boolValue];
    }else{
        return [UIApplication sharedApplication].statusBarHidden;
    }
}

- (void)setLrf_statusBarStyle:(UIStatusBarStyle)lrf_statusBarStyle{
    [self setLrf_statusBarStyle:lrf_statusBarStyle animated:NO];
}

-(void)setLrf_statusBarStyle:(UIStatusBarStyle)lrf_statusBarStyle animated:(BOOL)animated{
    [UIViewController lrf_injectStatus];
    [self lrf_setNonatomicStrongAssociatedObject:@(lrf_statusBarStyle) withKey:&keyStatusBarStyle];
    if (self.lrf_isVisible) {
        [[UIApplication sharedApplication] setStatusBarStyle:self.lrf_statusBarStyle animated:animated];
    }
}

- (UIStatusBarStyle)lrf_statusBarStyle{
    id style = [self lrf_getAssociatedObjectWithKey:&keyStatusBarStyle];
    if (style) {
        return [style integerValue];
    }else{
        return [UIApplication sharedApplication].statusBarStyle;
    }
}

- (void)setLrf_statusBarAnimation:(UIStatusBarAnimation)lrf_statusBarAnimation{
    [UIViewController lrf_injectStatus];
    [self lrf_setNonatomicStrongAssociatedObject:@(lrf_statusBarAnimation) withKey:&keyStatusBarAnimation];
}

- (UIStatusBarAnimation)lrf_statusBarAnimation{
    id animation = [self lrf_getAssociatedObjectWithKey:&keyStatusBarAnimation];
    if (animation) {
        return [animation integerValue];
    }else{
        return UIStatusBarAnimationFade;
    }
}

@end

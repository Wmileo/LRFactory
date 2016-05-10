//
//  UINavigationController+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UINavigationController+SimpleFactory.h"

@implementation UINavigationController (SimpleFactory)

+(UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)viewController{
    return [[UINavigationController alloc] initWithRootViewController:viewController];
}

-(UINavigationController *)navigationControllerRemoveBackgroundView{
    [self.navigationBar.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            [obj setHidden:YES];
            *stop = YES;
        }
    }];
    return self;
}

@end

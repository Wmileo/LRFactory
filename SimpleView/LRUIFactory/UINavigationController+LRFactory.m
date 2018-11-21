//
//  UINavigationController+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UINavigationController+LRFactory.h"

@implementation UINavigationController (LRFactory)

+ (UINavigationController *)lrf_navigationControllerWithRootViewController:(UIViewController *)viewController{
    return [[UINavigationController alloc] initWithRootViewController:viewController];
}

@end

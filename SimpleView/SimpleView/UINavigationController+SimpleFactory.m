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

@end

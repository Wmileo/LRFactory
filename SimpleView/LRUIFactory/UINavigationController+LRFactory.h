//
//  UINavigationController+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (LRFactory)

/**
 *  生成有NavigationController
 */
+ (UINavigationController *)lrf_navigationControllerWithRootViewController:(UIViewController *)viewController;

@end

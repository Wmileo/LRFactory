//
//  UINavigationController+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SimpleFactory)

/**
 *  生成有NavigationController
 */
+(UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)viewController;

/**
 *  设置默认导航栏是否透明 NO时view从导航栏底部开始  YES时view从屏幕顶部开始
 */
-(UINavigationController *)navResetNavBarTranslucent:(BOOL)translucent;

/**
 *  配置ChildViewControllerForStatusBarStyle
 */
+(void)configChildViewControllerForStatusBarStyle;

/**
 *  配置默认导航栏是否透明 NO时view从导航栏底部开始  YES时view从屏幕顶部开始
 */
+(void)configNavBarTranslucent:(BOOL)translucent;

/**
 *  自动隐藏底部按钮当push的时候
 */
+(void)autoHidesBottomBarWhenPush;


@end

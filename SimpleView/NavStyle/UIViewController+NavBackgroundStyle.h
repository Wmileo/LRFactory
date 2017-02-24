//
//  UIViewController+NavBackgroundStyle.h
//  SimpleView
//
//  Created by ileo on 16/5/12.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerNavBackgroundDataSource <NSObject>

@optional
-(UIColor *)navBackgroundColor;

@end

@interface UIViewController (NavBackgroundStyle) <UIViewControllerNavBackgroundDataSource>

/**
 *  设置为可配置的导航栏背景  ps.应用开启时配置
 */
+(void)configNavBackgroundStyle;

@end

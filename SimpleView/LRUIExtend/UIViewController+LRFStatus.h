//
//  UIViewController+LRFStatus.h
//  SimpleView
//
//  Created by leo on 2018/11/8.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LRFStatus)

/**
 *  配置默认状态栏样式  ps.应用开启时配置
 */
+(void)lrf_configDefaultStatusBarStyle:(UIStatusBarStyle)statusBarStyle statusHidden:(BOOL)statusBarHidden;

/**
 *  状态栏隐藏
 */
@property (nonatomic, assign) BOOL lrf_statusBarHidden;

/**
 *  状态栏样式
 */
@property (nonatomic, assign) UIStatusBarStyle lrf_statusBarStyle;

@end



NS_ASSUME_NONNULL_END

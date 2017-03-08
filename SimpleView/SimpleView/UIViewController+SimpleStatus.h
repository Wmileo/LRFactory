//
//  UIViewController+SimpleStatus.h
//  SimpleView
//
//  Created by leo on 2017/3/8.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SimpleStatus)

//需配置info.list "View controller-based status bar appearance"为NO

/**
 *  配置默认状态栏样式  ps.应用开启时配置
 */
+(void)configDefaultPreferredStatusBarStyle:(UIStatusBarStyle)statusBarStyle;

/**
 *  隐藏状态栏
 */
@property (nonatomic, assign) BOOL statusHide;

@end

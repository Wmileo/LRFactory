//
//  UIViewController+LRFStatusBar.h
//  SimpleView
//
//  Created by leo on 2018/11/8.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//注意：
//需要在info.plist设置 “View controller-based status bar appearance” 键，值为NO

@interface UIViewController (LRFStatusBar)

/**
 *  状态栏隐藏，需设置info.plist，如上
 */
@property (nonatomic, assign) BOOL lrf_statusBarHidden;
- (void)setLrf_statusBarHidden:(BOOL)lrf_statusBarHidden withAnimation:(UIStatusBarAnimation)lrf_statusBarAnimation;

/**           
 *  状态栏样式，需设置info.plist，如上
 */
@property (nonatomic, assign) UIStatusBarStyle lrf_statusBarStyle;
- (void)setLrf_statusBarStyle:(UIStatusBarStyle)lrf_statusBarStyle animated:(BOOL)animated;

/**
 *  状态栏隐藏动画，需设置info.plist，如上
 */
@property (nonatomic, assign) UIStatusBarAnimation lrf_statusBarAnimation;

@end



NS_ASSUME_NONNULL_END

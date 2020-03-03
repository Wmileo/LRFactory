//
//  UIViewController+LRFNavigationBar.h
//  SimpleView
//
//  Created by leo on 2018/11/14.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LRFNavigationBar)

//edgesForExtendedLayout  UIRectEdgeNone为从导航底部开始页面

/**
 *  隐藏导航栏
 */
@property (nonatomic, assign) BOOL lrf_navigationBarHidden;
-(void)setLrf_navigationBarHidden:(BOOL)lrf_navigationBarHidden animated:(BOOL)animated;

/**
 *  背景颜色
 */
@property (nonatomic, strong) UIColor *lrf_navigationBarTintColor;

/**
 *  item字体颜色
 */
@property (nonatomic, strong) UIColor *lrf_navigationBarItemTintColor;

/**
 * title字体样式颜色
 */
@property (nonatomic, copy) NSDictionary<NSAttributedStringKey,id> *lrf_navigationBarTitleTextAttributes;

/**
 *  底部阴影 nil为默认阴影
 */
@property (nonatomic, strong) UIImage *lrf_navigationBarShadowImage;

/**
 *  背景图片 nil为默认图片
 */
@property (nonatomic, strong) UIImage *lrf_navigationBarBackgroundImage;

/**
 *  导航栏背景半透明
 */
@property (nonatomic, assign) BOOL lrf_navigationBarTranslucent;

/**
 *  导航栏背景透明
 */
@property (nonatomic, assign) BOOL lrf_navigationBarClear;


@end

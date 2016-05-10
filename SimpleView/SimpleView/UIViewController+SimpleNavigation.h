//
//  UIViewController+SimpleNavigation.h
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerNavigationDataSource <NSObject>


@optional

/**
 *  设置barbuttonitem文字颜色
 */
+(UIColor *)navBarButtonItemLeftTextColor;
+(UIColor *)navBarButtonItemRightTextColor;

/**
 *  设置barbuttonitem文字字体
 */
+(UIFont *)navBarButtonItemLeftTextFont;
+(UIFont *)navBarButtonItemRightTextFont;

@end

@interface UIViewController (SimpleNavigation)

#pragma mark - 配置
/**
 *  配置默认barbuttonitem颜色，字体
 */
+(void)configNavButtonTextColor:(UIColor *)color font:(UIFont *)font;

/**
 *  配置默认导航栏Title颜色，字体
 */
+(void)configNavTitleTextColor:(UIColor *)color font:(UIFont *)font;

/**
 *  配置默认导航栏背景颜色
 */
+(void)configNavBackgroundColor:(UIColor *)color;

#pragma mark - Title

/**
 *  设置导航栏Title颜色，字体
 */
-(void)navResetTitleColor:(UIColor *)color font:(UIFont *)font;

#pragma mark - 设置按钮

/**
 *  设置按钮nav barbuttonitem
 */
-(id)navSetupLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
-(id)navSetupRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

/**
 *  设置按钮nav barbuttonitem
 */
-(id)navSetupLeftButton:(UIButton *)button;
-(id)navSetupRightButton:(UIButton *)button;

/**
 *  设置图片nav barbuttonitem
 */
-(id)navSetupLeftImageName:(NSString *)name action:(void (^)())action;
-(id)navSetupRightImageName:(NSString *)name action:(void(^)())action;

/**
 *  设置文字nav barbuttonitem
 */
-(id)navSetupLeftTitle:(NSString *)title action:(void(^)())action;
-(id)navSetupRightTitle:(NSString *)title action:(void(^)())action;

/**
 *  设置间隔nav barbuttonitem
 */
-(id)navSetupLeftSpaceWithWidth:(CGFloat)width;
-(id)navSetupRightSpaceWithWidth:(CGFloat)width;

/**
 *  添加按钮nav barbuttonitem
 */
-(id)navAddLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
-(id)navAddRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

/**
 *  添加按钮nav barbuttonitem
 */
-(id)navAddLeftButton:(UIButton *)button;
-(id)navAddRightButton:(UIButton *)button;

/**
 *  添加图片nav barbuttonitem
 */
-(id)navAddLeftImageName:(NSString *)name action:(void (^)())action;
-(id)navAddRightImageName:(NSString *)name action:(void(^)())action;

/**
 *  添加文字nav barbuttonitem
 */
-(id)navAddLeftTitle:(NSString *)title action:(void(^)())action;
-(id)navAddRightTitle:(NSString *)title action:(void(^)())action;

/**
 *  添加间隔nav barbuttonitem
 */
-(id)navAddLeftSpaceWithWidth:(CGFloat)width;
-(id)navAddRightSpaceWithWidth:(CGFloat)width;


@end

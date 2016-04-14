//
//  UIButton+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SimpleFactory)

#pragma mark - 图片按钮

/**
 *  工厂生产UIButton 图片背景
 */
+(UIButton *)buttonWithFrame:(CGRect)frame normalImage:(UIImage *)normalImg click:(void(^)())click onView:(UIView *)view;

/**
 *  工厂生产UIButton 图片背景 设置中点 大小根据图片大小显示
 */
+(UIButton *)buttonWithCenter:(CGPoint)center normalImage:(UIImage *)normalImg click:(void(^)())click onView:(UIView *)view;

/**
 *  添加点击高亮图片
 */
-(UIButton *)addHighlightedImage:(UIImage *)highlightedImg;

#pragma mark - 文字按钮

/**
 *  工厂生产UIButton 颜色背景 文字标题
 */
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font click:(void(^)())click onView:(UIView *)view;

/**
 *  添加点击高亮图片
 */
-(UIButton *)addHighlightedTitle:(NSString *)title textColor:(UIColor *)textColor;

/**
 *  工厂生产UIButton 颜色背景 文字标题  设置中点 大小根据图片大小显示
 */
+(UIButton *)buttonWithCenter:(CGPoint)center title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font click:(void(^)())click onView:(UIView *)view;

#pragma mark - 空按钮

/**
 *  工厂生产UIButton 空按钮
 */
+(UIButton *)buttonEmptyWithFrame:(CGRect)frame click:(void(^)())click onView:(UIView *)view;


#pragma mark - 

/**
 *  设置背景颜色
 */
-(UIButton *)resetBackgroundColor:(UIColor *)color;

@end

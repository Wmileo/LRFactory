//
//  UIButton+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LRFactory)

#pragma mark - 图片按钮

/**
 *  工厂生产UIButton 图片背景
 */
+(UIButton *)buttonWithFrame:(CGRect)frame normalImage:(UIImage *)normalImg click:(void(^)(void))click;

/**
 *  工厂生产UIButton 图片背景 设置中点 大小根据图片大小显示
 */
+(UIButton *)buttonWithCenter:(CGPoint)center normalImage:(UIImage *)normalImg click:(void(^)(void))click;

/**
 *  添加点击高亮图片
 */
-(UIButton *(^)(UIImage *highlightedImg))lrf_highlightedImage;

#pragma mark - 文字按钮

/**
 *  工厂生产UIButton 颜色背景 文字标题
 */
+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font click:(void(^)(void))click;

/**
 *  工厂生产UIButton 颜色背景 文字标题  设置中点 大小根据文字尺寸显示 ps.宽度不超过300
 */
+(UIButton *)buttonWithCenter:(CGPoint)center title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font click:(void(^)(void))click;

/**
 *  添加点击高亮文字
 */
-(UIButton *(^)(NSString *title, UIColor *textColor))lrf_highlightedTitle;

#pragma mark - 空按钮

/**
 *  工厂生产UIButton 空按钮
 */
+(UIButton *)buttonEmptyWithFrame:(CGRect)frame click:(void(^)(void))click;

@end

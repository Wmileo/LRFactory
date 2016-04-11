//
//  UIButton+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SimpleFactory)

/**
 *  工厂生产UIButton 图片背景
 */
+(UIButton *)buttonWithFrame:(CGRect)frame image:(UIImage *)normal click:(void(^)())click onView:(UIView *)view;

/**
 *  工厂生产UIButton 图片背景 设置中点
 */
+(UIButton *)buttonWithCenter:(CGPoint)center image:(UIImage *)image click:(void(^)())click onView:(UIView *)view;

/**
 *  工厂生产UIButton 颜色背景 文字标题
 */
+(UIButton *)buttonWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor title:(NSString *)title textColor:(UIColor *)textColor click:(void(^)())click onView:(UIView *)view;

/**
 *  工厂生产UIButton 空按钮
 */
+(UIButton *)buttonEmptyWithFrame:(CGRect)frame click:(void(^)())click onView:(UIView *)view;


@end

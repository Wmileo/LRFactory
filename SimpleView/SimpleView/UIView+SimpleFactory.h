//
//  UIView+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SimpleFactory)

/**
 *  工厂生产UIView
 */
+(instancetype)viewWithFrame:(CGRect)frame;

/**
 *  设置背景颜色
 */
-(instancetype)resetBackgroundColor:(UIColor *)color;

/**
 *  添加到View上 addSubView
 */
-(instancetype)setupOnView:(UIView *)view;

@end

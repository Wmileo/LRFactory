//
//  UIBarButtonItem+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/4/27.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (LRFactory)

/**
 *  生成空格BarButtonItem
 */
+ (UIBarButtonItem *)lrf_barButtonItemSpaceWithWidth:(CGFloat)width;

/**
 *  生成有Button的BarButtonItem
 */
+ (UIBarButtonItem *)lrf_barButtonItemWithButton:(UIButton *)button;

/**
 *  默认方式生成带图片BarButtonItem
 */
+ (UIBarButtonItem *)lrf_barButtonItemWithImage:(UIImage *)image action:(void (^)(void))action;

/**
 *  默认方式生成带文字BarButtonItem
 */
+ (UIBarButtonItem *)lrf_barButtonItemWithTitle:(NSString *)title action:(void (^)(void))action;


- (void)lrf_handleAction:(void(^)(id sender))block;


@end

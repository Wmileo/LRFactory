//
//  UIView+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FixedPointType) {
    Fixed_Left_Top,
    Fixed_Left_CenterY,
    Fixed_Left_Bottom,
    Fixed_CenterX_Top,
    Fixed_CenterX_CenterY,
    Fixed_CenterX_Bottom,
    Fixed_Right_Top,
    Fixed_Right_CenterY,
    Fixed_Right_Bottom
};

@interface UIView (LRFactory)

/**
 *  工厂生产UIView
 */
+(instancetype)lrf_view;

/**
 *  工厂生产UIView
 */
+(instancetype)lrf_viewWithFrame:(CGRect)frame;

/**
 *  工厂生产UIView
 */
+(instancetype)lrf_viewWithSize:(CGSize)size;

@property (nonatomic) CGSize lrf_size;
@property (nonatomic) CGFloat lrf_width;
@property (nonatomic) CGFloat lrf_height;
@property (nonatomic, readonly) CGPoint lrf_boundsCenter;

/**
 *  设置固定点，用于适配变化的size
 */
-(void)lrf_setupFixedType:(FixedPointType)type point:(CGPoint)point;

/**
 *  设置边框
 */
-(void)lrf_setupBorderWidth:(CGFloat)width color:(UIColor *)color;

/**
 *  设置圆角
 */
-(void)lrf_setupCornerRadius:(CGFloat)radius;


@end


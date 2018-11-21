//
//  UIView+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LRF_FixedPointType) {
    LRF_Fixed_Left_Top,
    LRF_Fixed_Left_CenterY,
    LRF_Fixed_Left_Bottom,
    LRF_Fixed_CenterX_Top,
    LRF_Fixed_CenterX_CenterY,
    LRF_Fixed_CenterX_Bottom,
    LRF_Fixed_Right_Top,
    LRF_Fixed_Right_CenterY,
    LRF_Fixed_Right_Bottom
};

@interface UIView (LRFactory)

/**
 *  工厂生产UIView
 */
+ (instancetype)lrf_view;

/**
 *  工厂生产UIView
 */
+ (instancetype)lrf_viewWithFrame:(CGRect)frame;

/**
 *  工厂生产UIView
 */
+ (instancetype)lrf_viewWithSize:(CGSize)size;

@property (nonatomic) CGFloat lrf_left;
@property (nonatomic) CGFloat lrf_right;
@property (nonatomic) CGFloat lrf_top;
@property (nonatomic) CGFloat lrf_bottom;

@property (nonatomic) CGSize lrf_size;
@property (nonatomic) CGFloat lrf_width;
@property (nonatomic) CGFloat lrf_height;

@property (nonatomic, readonly) CGPoint lrf_boundsCenter;
@property (nonatomic) CGFloat lrf_centerX;
@property (nonatomic) CGFloat lrf_centerY;

/**
 *  设置固定点，用于适配变化的size
 */
- (void)lrf_setupFixedType:(LRF_FixedPointType)type point:(CGPoint)point;

/**
 *  设置边框
 */
- (void)lrf_setupBorderWidth:(CGFloat)width color:(UIColor *)color;

/**
 *  设置圆角
 */
- (void)lrf_setupCornerRadius:(CGFloat)radius;

- (void)lrf_removeAllSubviews;


#pragma mark - debug
- (void)lrf_showDebugFrame;

@end


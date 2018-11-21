//
//  UIButton+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LRF_Image_Aligning) {
    LRF_Image_Aligning_Left,
    LRF_Image_Aligning_Center,
    LRF_Image_Aligning_Right,
};//如果图片小于size 图片的位置

@interface UIButton (LRFactory)

- (void)lrf_handleEventTouchUpInsideBlock:(void (^)(void))block;

#pragma mark - 图片按钮

- (void)lrf_setupNormalImage:(UIImage *)image;//no fit
- (void)lrf_setupHighlightedImage:(UIImage *)image;//no fit
- (void)lrf_setupNormalImage:(UIImage *)image fitSize:(BOOL)fit;//
- (void)lrf_setupHighlightedImage:(UIImage *)image fitSize:(BOOL)fit;//
- (void)lrf_setupNormalImage:(UIImage *)image aligning:(LRF_Image_Aligning)aligning;
- (void)lrf_setupHighlightedImage:(UIImage *)image aligning:(LRF_Image_Aligning)aligning;

#pragma mark - 文字按钮

- (void)lrf_setupNormalText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;//no fit
- (void)lrf_setupHighlightedText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;//no fit
- (void)lrf_setupNormalText:(NSString *)text color:(UIColor *)color font:(UIFont *)font fitSize:(BOOL)fit;
- (void)lrf_setupHighlightedText:(NSString *)text color:(UIColor *)color font:(UIFont *)font fitSize:(BOOL)fit;


@end

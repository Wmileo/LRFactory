//
//  UIButton+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (LRFactory)

- (void)lrf_handleEventTouchUpInsideBlock:(void (^)(void))block;

#pragma mark - 图片按钮

- (void)lrf_setupNormalImage:(UIImage *)image fitSize:(BOOL)fit;
- (void)lrf_setupHighlightedImage:(UIImage *)image fitSize:(BOOL)fit;

#pragma mark - 文字按钮

- (void)lrf_setupNormalTitle:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font fitSize:(BOOL)fit;
- (void)lrf_setupHighlightedTitle:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font fitSize:(BOOL)fit;


@end

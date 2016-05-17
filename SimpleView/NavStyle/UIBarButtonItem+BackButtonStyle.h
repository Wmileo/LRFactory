//
//  UIBarButtonItem+BackButtonStyle.h
//  SimpleView
//
//  Created by ileo on 16/5/17.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_TITLE_LABEL 17

@interface UIBarButtonItem (BackButtonStyle)


+(NSArray *)backButtonItemsWithOffsetX:(CGFloat)offsetX image:(UIImage *)image;

+(NSArray *)backButtonItemsWithOffsetX:(CGFloat)offsetX image:(UIImage *)image titleOffsetX:(CGFloat)titleOffsetX titleColor:(UIColor *)color titleFont:(UIFont *)font;

@end

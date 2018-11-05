//
//  UILabel+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/4.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LRFactory)

/**
 *  工厂生产UILabel
 */
+(UILabel *)labelWithFrame:(CGRect)frame font:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor;

/**
 *  工厂生产UILabel 适配初始文字大小尺寸的UILabel ps.最好不要改变文字，宽度不超过300
 */
+(UILabel *)labelWithCenter:(CGPoint)center font:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor;

/**
 *  设置TextAlignment
 */
-(UILabel *(^)(NSTextAlignment textAlignment))lrf_textAlignment;

/**
 *  设置行数 0为不限制
 */
-(UILabel *(^)(NSInteger lines))lrf_numberOfLines;

/**
 *  设置attributedText
 */
-(UILabel *(^)(NSAttributedString *attributedText))lrf_attributedText;


@end

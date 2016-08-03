//
//  NSAttributedString+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/7/29.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (SimpleFactory)

/**
 *  初始化一个带text color font的AttributedString
 */
+(NSAttributedString *)attributedStringWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;

/**
 *  初始化一个带text的AttributedString
 */
+(NSAttributedString *)attributedStringWithText:(NSString *)text;

/**
 *  拷贝新的AttributedString 换成color
 */
-(NSAttributedString *)copyAttributedStringWithColor:(UIColor *)color;

/**
 *  拷贝新的AttributedString 换成font
 */
-(NSAttributedString *)copyAttributedStringWithFont:(UIFont *)font;

/**
 *  生成空格 num空格数量
 */
+(NSAttributedString *)attributedStringWithSpaceNum:(NSInteger)num;

/**
 *  生成换行 size换行的尺寸
 */
+(NSAttributedString *)attributedStringWithLineFeedSize:(CGFloat)size;

/**
 *  按顺序拼接attributedString成新的attributedString
 */
+(NSAttributedString *)attributedStringWithAttributedStrings:(NSArray *)attributedString;

@end

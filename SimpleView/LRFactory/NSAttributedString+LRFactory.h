//
//  NSAttributedString+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/7/29.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSAttributedString (LRFactory)


- (CGSize)lrf_sizeWithMaxWidth:(CGFloat)maxWidth;

/**
 *  初始化一个带text color font的AttributedString
 */
+ (NSAttributedString *)lrf_attributedStringWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;

/**
 *  初始化一个带text的AttributedString
 */
+ (NSAttributedString *)lrf_attributedStringWithText:(NSString *)text;

/**
 *  拷贝新的AttributedString 换成color
 */
- (NSAttributedString *)lrf_copyAttributedStringWithColor:(UIColor *)color;

/**
 *  拷贝新的AttributedString 换成font
 */
- (NSAttributedString *)lrf_copyAttributedStringWithFont:(UIFont *)font;

/**
 *  拷贝新的AttributedString 换成ParagraphStyle
 */
- (NSAttributedString *)lrf_copyAttributedStringWithParagraphStyle:(NSParagraphStyle *)paragraphStyle;

/**
 *  拷贝新的AttributedString 替换行间距
 */
- (NSAttributedString *)lrf_copyAttributedStringWithLineSpacing:(CGFloat)lineSpacing;

/**
 *  拷贝新的AttributedString 替换首行缩进
 */
- (NSAttributedString *)lrf_copyAttributedStringWithFirstLineHeadIndent:(CGFloat)firstLineHeadIndent;

/**
 *  拷贝新的AttributedString 生成NSUnderlineStyleSingle 并设置颜色
 */
- (NSAttributedString *)lrf_copyAttributedStringWithUnderLineWithColor:(UIColor *)color;

/**
 *  拷贝新的AttributedString 生成点击链接  优先支持NSURL 然后支持NSString //仅支持UITextView
 */
- (NSAttributedString *)lrf_copyAttributedStringWithLink:(id)link;

/**
 *  生成空格 num空格数量
 */
+ (NSAttributedString *)lrf_attributedStringWithSpaceNum:(NSInteger)num;

/**
 *  生成换行 size换行的尺寸
 */
+ (NSAttributedString *)lrf_attributedStringWithLineFeedSize:(CGFloat)size;

/**
 *  按顺序拼接attributedString成新的attributedString
 */
+ (NSAttributedString *)lrf_attributedStringWithAttributedStrings:(NSArray *)attributedString;

@end

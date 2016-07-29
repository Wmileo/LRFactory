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

+(NSAttributedString *)attributedStringWithText:(NSString *)text;
-(NSAttributedString *)copyAttributedStringWithColor:(UIColor *)color;
-(NSAttributedString *)copyAttributedStringWithFont:(UIFont *)font;

+(NSAttributedString *)attributedStringWithSpaceNum:(NSInteger)num;

+(NSAttributedString *)attributedStringWithAttributedStrings:(NSArray *)attributedString;

@end

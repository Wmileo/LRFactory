//
//  NSAttributedString+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/7/29.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "NSAttributedString+SimpleFactory.h"

@implementation NSAttributedString (SimpleFactory)


+(NSAttributedString *)attributedStringWithText:(NSString *)text{
    return [[NSAttributedString alloc] initWithString:text];
}
-(NSAttributedString *)copyAttributedStringWithColor:(UIColor *)color{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [att addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.string.length)];
    return [att copy];
}
-(NSAttributedString *)copyAttributedStringWithFont:(UIFont *)font{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [att addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.string.length)];
    return [att copy];
}

+(NSAttributedString *)attributedStringWithSpaceNum:(NSInteger)num{
    NSMutableString *string = [NSMutableString stringWithCapacity:3];
    for (int i = 0; i < num; i++) {
        [string appendString:@" "];
    }
    return [NSAttributedString attributedStringWithText:[string copy]];
}

+(NSAttributedString *)attributedStringWithAttributedStrings:(NSArray *)attributedString{
    NSInteger num = attributedString.count;
    if (num > 0) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString[0]];
        if (num > 1) {
            for (int i = 1; i < attributedString.count; i++) {
                [att appendAttributedString:attributedString[i]];
            }
        }
        return [att copy];
    }
    return nil;
}



@end

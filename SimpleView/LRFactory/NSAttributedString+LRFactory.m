//
//  NSAttributedString+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/7/29.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "NSAttributedString+LRFactory.h"

@implementation NSAttributedString (LRFactory)

-(CGSize)lrf_sizeWithMaxWidth:(CGFloat)maxWidth{
    return [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
}

+(NSAttributedString *)lrf_attributedStringWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font{
    if (!text) text = @"";
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
    if (color) [dic setObject:color forKey:NSForegroundColorAttributeName];
    if (font) [dic setObject:font forKey:NSFontAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:dic];
}
+(NSAttributedString *)lrf_attributedStringWithText:(NSString *)text{
    if (!text) text = @"";
    return [[NSAttributedString alloc] initWithString:text];
}
-(NSAttributedString *)lrf_copyAttributedStringWithColor:(UIColor *)color{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [att addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, self.string.length)];
    return [att copy];
}
-(NSAttributedString *)lrf_copyAttributedStringWithFont:(UIFont *)font{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [att addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, self.string.length)];
    return [att copy];
}
-(NSAttributedString *)lrf_copyAttributedStringWithParagraphStyle:(NSParagraphStyle *)paragraphStyle{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [att addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.string.length)];
    return [att copy];
}

-(NSParagraphStyle *)paragraphStyle{
    NSRange range;
    return [self attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:&range];
}


-(NSAttributedString *)lrf_copyAttributedStringWithLineSpacing:(CGFloat)lineSpacing{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    NSMutableParagraphStyle *newStyle = [[NSMutableParagraphStyle alloc] init];
    if (@available(iOS 9.0, *)) {
        [newStyle setParagraphStyle:[self paragraphStyle]];
    }
    newStyle.lineSpacing = lineSpacing;
    [att addAttribute:NSParagraphStyleAttributeName value:newStyle range:NSMakeRange(0, self.string.length)];
    return [att copy];
}

-(NSAttributedString *)lrf_copyAttributedStringWithFirstLineHeadIndent:(CGFloat)firstLineHeadIndent{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    NSMutableParagraphStyle *newStyle = [[NSMutableParagraphStyle alloc] init];
    if (@available(iOS 9.0, *)) {
        [newStyle setParagraphStyle:[self paragraphStyle]];
    }
    newStyle.firstLineHeadIndent = firstLineHeadIndent;
    [att addAttribute:NSParagraphStyleAttributeName value:newStyle range:NSMakeRange(0, self.string.length)];
    return [att copy];
}

-(NSAttributedString *)lrf_copyAttributedStringWithUnderLineWithColor:(UIColor *)color{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [att addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, self.string.length)];
    [att addAttribute:NSUnderlineColorAttributeName value:color range:NSMakeRange(0, self.string.length)];
    return [att copy];
}
-(NSAttributedString *)lrf_copyAttributedStringWithLink:(id)link{
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [att addAttribute:NSLinkAttributeName value:link range:NSMakeRange(0, self.string.length)];
    return [att copy];
}
+(NSAttributedString *)lrf_attributedStringWithSpaceNum:(NSInteger)num{
    NSMutableString *string = [NSMutableString stringWithCapacity:3];
    for (int i = 0; i < num; i++) {
        [string appendString:@" "];
    }
    return [NSAttributedString lrf_attributedStringWithText:[string copy]];
}
+(NSAttributedString *)lrf_attributedStringWithLineFeedSize:(CGFloat)size{
    NSAttributedString *att1 = [NSAttributedString lrf_attributedStringWithText:@"\n" color:nil font:[UIFont systemFontOfSize:1]];
    NSAttributedString *att2 = [NSAttributedString lrf_attributedStringWithText:@"\n" color:nil font:[UIFont systemFontOfSize:size]];
    return [NSAttributedString lrf_attributedStringWithAttributedStrings:@[att1,att2]];
}
+(NSAttributedString *)lrf_attributedStringWithAttributedStrings:(NSArray *)attributedString{
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

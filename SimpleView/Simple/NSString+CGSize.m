//
//  NSString+CGSize.m
//  SimpleView
//
//  Created by ileo on 16/5/4.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "NSString+CGSize.h"

@implementation NSString (CGSize)

-(CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    if (!font) {
        return CGSizeZero;
    }
    return [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end

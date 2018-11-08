//
//  NSString+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/4.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "NSString+LRFactory.h"

@implementation NSString (LRFactory)

-(CGSize)lrf_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth{
    if (!font) {
        return CGSizeZero;
    }
    return [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end

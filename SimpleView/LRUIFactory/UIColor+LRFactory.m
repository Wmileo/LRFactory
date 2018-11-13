//
//  UIColor+LRFactory.m
//  SimpleView
//
//  Created by leo on 2018/11/8.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIColor+LRFactory.h"

@implementation UIColor (LRFactory)

+ (CGFloat) lrf_colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *)lrf_colorWithHexString:(NSString *)hexString{
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha = 0, red = 0, blue = 0, green = 0;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self lrf_colorComponentFrom: colorString start: 0 length: 1];
            green = [self lrf_colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self lrf_colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self lrf_colorComponentFrom: colorString start: 0 length: 1];
            red   = [self lrf_colorComponentFrom: colorString start: 1 length: 1];
            green = [self lrf_colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self lrf_colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self lrf_colorComponentFrom: colorString start: 0 length: 2];
            green = [self lrf_colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self lrf_colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self lrf_colorComponentFrom: colorString start: 0 length: 2];
            red   = [self lrf_colorComponentFrom: colorString start: 2 length: 2];
            green = [self lrf_colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self lrf_colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            NSAssert(nil, @"参数不合法");
            break;
    }
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
}

@end

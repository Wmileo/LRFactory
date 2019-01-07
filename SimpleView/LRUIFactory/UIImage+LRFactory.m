//
//  UIImage+LRFactory.m
//  SimpleView
//
//  Created by leo on 2019/1/7.
//  Copyright © 2019 ileo. All rights reserved.
//

#import "UIImage+LRFactory.h"

@implementation UIImage (LRFactory)

- (UIImage *)lrf_copyWithSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [[UIScreen mainScreen] scale]);
    [self drawInRect:rect];
    UIImage *newI = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newI;
}

- (UIImage *)lrf_copyWithRatio:(CGFloat)ratio{
    CGSize size = [self size];
    size.width = ratio * size.width;
    size.height = ratio * size.height;
    return [self lrf_copyWithSize:size];
}

- (UIImage *)lrf_copyWithMaxSide:(CGFloat)side{
    CGSize size = [self size];
    CGFloat ratio = 1;
    if (size.width > size.height) {
        if (size.width > 1)
            ratio = side / size.width;
    } else {
        if (size.height > 1)
            ratio = side / size.height;
    }
    return [self lrf_copyWithRatio:ratio];
}

@end

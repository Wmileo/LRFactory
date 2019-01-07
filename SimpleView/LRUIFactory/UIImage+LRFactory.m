//
//  UIImage+LRFactory.m
//  SimpleView
//
//  Created by leo on 2019/1/7.
//  Copyright © 2019 ileo. All rights reserved.
//

#import "UIImage+LRFactory.h"

@implementation UIImage (LRFactory)

- (UIImage *)lrf_setupSize:(CGSize)size{
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    [self drawInRect:rect];
    UIImage *newI = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newI;
}

- (UIImage *)lrf_setupRatio:(CGFloat)ratio{
    CGSize size = [self size];
    size.width = ratio * size.width;
    size.height = ratio * size.height;
    return [self lrf_setupSize:size];
}

- (UIImage *)lrf_setupMaxSide:(CGFloat)side{
    CGSize size = [self size];
    CGFloat ratio = 1;
    if (size.width > size.height) {
        if (size.width > 1)
            ratio = side / size.width;
    } else {
        if (size.height > 1)
            ratio = side / size.height;
    }
    return [self lrf_setupRatio:ratio];
}

@end

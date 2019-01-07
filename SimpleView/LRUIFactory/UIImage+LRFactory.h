//
//  UIImage+LRFactory.h
//  SimpleView
//
//  Created by leo on 2019/1/7.
//  Copyright © 2019 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (LRFactory)

- (UIImage *)lrf_copyWithSize:(CGSize)size;
- (UIImage *)lrf_copyWithRatio:(CGFloat)ratio;//比例
- (UIImage *)lrf_copyWithMaxSide:(CGFloat)side;//最大边长

@end


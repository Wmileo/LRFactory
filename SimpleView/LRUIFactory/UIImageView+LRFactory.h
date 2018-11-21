//
//  UIImageView+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/17.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LRFactory)

- (void)lrf_setupImage:(UIImage *)image;
- (void)lrf_setupImage:(UIImage *)image fitSize:(BOOL)fit;

@end

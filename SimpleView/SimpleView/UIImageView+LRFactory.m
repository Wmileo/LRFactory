//
//  UIImageView+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/17.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIImageView+LRFactory.h"
#import "UIView+LRFactory.h"

@implementation UIImageView (LRFactory)

-(void)lrf_setupImage:(UIImage *)image fitSize:(BOOL)fit{
    self.image = image;
    self.lrf_size = image.size;
}

@end

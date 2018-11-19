//
//  UILabel+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/5/4.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UILabel+LRFactory.h"
#import "UIView+LRFactory.h"
#import "NSString+LRFactory.h"

@implementation UILabel (LRFactory)

- (void)lrf_setupText:(NSString *)text font:(UIFont *)font fitSize:(BOOL)fit{
    if (text) {
        self.text = text;
    }
    if (font) {
        self.font = font;
    }
    if (fit) {
        CGSize size = [self.text lrf_sizeWithFont:self.font maxWidth:300];
        self.lrf_size = size;
    }
}

- (void)lrf_setupText:(NSString *)text font:(UIFont *)font{
    [self lrf_setupText:text font:font fitSize:NO];
}

@end

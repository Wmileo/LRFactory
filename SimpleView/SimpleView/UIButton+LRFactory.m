//
//  UIButton+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIButton+LRFactory.h"
#import "UIView+LRFactory.h"
#import "NSObject+Block.h"
#import "NSString+CGSize.h"


#define kMinWidth 26
#define kMinHeight 40

@implementation UIButton (LRFactory)


-(void)lrf_handleEventTouchUpInsideBlock:(void (^)(void))block{
    if (block) {
        [self setExclusiveTouch:YES];
        [self onlyHangdleUIControlEvent:UIControlEventTouchUpInside withBlock:^(id sender) {
            block();
        }];
    }
}

#pragma mark - 图片按钮

-(void)lrf_setupNormalImage:(UIImage *)image fitSize:(BOOL)fit{
    if (image) {
        [self setImage:image forState:UIControlStateNormal];
        if (fit) {
            [self lrf_fitImageSize:image.size];
        }
    }
}

-(void)lrf_setupHighlightedImage:(UIImage *)image fitSize:(BOOL)fit{
    if (image) {
        [self setImage:image forState:UIControlStateHighlighted];
        if (fit) {
            [self lrf_fitImageSize:image.size];
        }
    }
}

-(void)lrf_fitImageSize:(CGSize)size{
    CGFloat width = MAX(size.width, kMinWidth);
    CGFloat height = MAX(size.height, kMinHeight);
    self.lrf_size = CGSizeMake(width, height);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 11) {
        CGFloat gapWidth = MAX((self.lrf_width - size.width), 0);
        CGFloat gapHeight = MAX((self.lrf_height - size.height), 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(gapHeight / 2, gapWidth / 2, gapHeight / 2, gapWidth / 2);
    }
}


#pragma mark - 文字按钮

-(void)lrf_setupNormalTitle:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font fitSize:(BOOL)fit{
    if (font) {
        self.titleLabel.font = font;
    }
    if (color){
        [self setTitleColor:color forState:UIControlStateNormal];
    }
    if(title){
        [self setTitle:title forState:UIControlStateNormal];
        if (fit) {
            [self fitTitle:title];
        }
    }
}

-(void)lrf_setupHighlightedTitle:(NSString *)title textColor:(UIColor *)color font:(UIFont *)font fitSize:(BOOL)fit{
    if (font) {
        self.titleLabel.font = font;
    }
    if (color){
        [self setTitleColor:color forState:UIControlStateHighlighted];
    }
    if(title){
        [self setTitle:title forState:UIControlStateHighlighted];
        if (fit) {
            [self fitTitle:title];
        }
    }
}

-(void)fitTitle:(NSString *)title{
    CGSize size = [title sizeWithFont:self.titleLabel.font maxWidth:300];
    CGFloat width = MAX(size.width + 10, kMinWidth);
    CGFloat height = MAX(size.height, kMinHeight);
    self.lrf_size = CGSizeMake(width, height);
}

@end

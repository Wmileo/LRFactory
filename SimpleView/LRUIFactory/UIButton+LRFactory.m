//
//  UIButton+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIButton+LRFactory.h"
#import "UIView+LRFactory.h"
#import "UIControl+LRFactory.h"
#import "NSString+LRFactory.h"


#define kMinWidth 26
#define kMinHeight 28

@implementation UIButton (LRFactory)


-(void)lrf_handleEventTouchUpInsideBlock:(void (^)(void))block{
    if (block) {
        [self setExclusiveTouch:YES];
        [self lrf_handleEvent:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            block();
        }];
    }
}

#pragma mark - 图片按钮

-(void)lrf_setupNormalImage:(UIImage *)image{
    [self lrf_setupNormalImage:image fitSize:NO];
}

-(void)lrf_setupHighlightedImage:(UIImage *)image{
    [self lrf_setupHighlightedImage:image fitSize:NO];
}

-(void)lrf_setupNormalImage:(UIImage *)image fitSize:(BOOL)fit{
    if (image) {
        [self setImage:image forState:UIControlStateNormal];
        if (fit) {
            [self lrf_fitImageSize:image.size aligning:LRF_Image_Aligning_Center];
        }
    }
}

-(void)lrf_setupHighlightedImage:(UIImage *)image fitSize:(BOOL)fit{
    if (image) {
        [self setImage:image forState:UIControlStateHighlighted];
        if (fit) {
            [self lrf_fitImageSize:image.size aligning:LRF_Image_Aligning_Center];
        }
    }
}

-(void)lrf_setupNormalImage:(UIImage *)image aligning:(LRF_Image_Aligning)aligning{
    [self lrf_setupNormalImage:image];
    [self lrf_fitImageSize:image.size aligning:aligning];
}

-(void)lrf_setupHighlightedImage:(UIImage *)image aligning:(LRF_Image_Aligning)aligning{
    [self lrf_setupHighlightedImage:image];
    [self lrf_fitImageSize:image.size aligning:aligning];
}

-(void)lrf_fitImageSize:(CGSize)size aligning:(LRF_Image_Aligning)aligning{
    CGFloat width = MAX(size.width, kMinWidth);
    CGFloat height = MAX(size.height, kMinHeight);
    self.lrf_size = CGSizeMake(width, height);
    CGFloat gapWidth = MAX((self.lrf_width - size.width), 0);
    CGFloat gapHeight = MAX((self.lrf_height - size.height), 0);
    switch (aligning) {
        case LRF_Image_Aligning_Left:
             self.imageEdgeInsets = UIEdgeInsetsMake(gapHeight / 2, 0, gapHeight / 2, gapWidth);
            break;
        case LRF_Image_Aligning_Center:
             self.imageEdgeInsets = UIEdgeInsetsMake(gapHeight / 2, gapWidth / 2, gapHeight / 2, gapWidth / 2);
            break;
        case LRF_Image_Aligning_Right:
             self.imageEdgeInsets = UIEdgeInsetsMake(gapHeight / 2, gapWidth, gapHeight / 2, 0);
            break;
        default:
            break;
    }
}


#pragma mark - 文字按钮

-(void)lrf_setupNormalText:(NSString *)text color:(UIColor *)color font:(UIFont *)font{
    [self lrf_setupNormalText:text color:color font:font];
}

-(void)lrf_setupHighlightedText:(NSString *)text color:(UIColor *)color font:(UIFont *)font{
    [self lrf_setupHighlightedText:text color:color font:font];
}

-(void)lrf_setupNormalText:(NSString *)text color:(UIColor *)color font:(UIFont *)font fitSize:(BOOL)fit{
    if (font) {
        self.titleLabel.font = font;
    }
    if (color){
        [self setTitleColor:color forState:UIControlStateNormal];
    }
    if(text){
        [self setTitle:text forState:UIControlStateNormal];
        if (fit) {
            [self fitText:text];
        }
    }
}

-(void)lrf_setupHighlightedText:(NSString *)text color:(UIColor *)color font:(UIFont *)font fitSize:(BOOL)fit{
    if (font) {
        self.titleLabel.font = font;
    }
    if (color){
        [self setTitleColor:color forState:UIControlStateHighlighted];
    }
    if(text){
        [self setTitle:text forState:UIControlStateHighlighted];
        if (fit) {
            [self fitText:text];
        }
    }
}

-(void)fitText:(NSString *)text{
    CGSize size = [text lrf_sizeWithFont:self.titleLabel.font maxWidth:300];
    CGFloat width = MAX(size.width + 10, kMinWidth);
    CGFloat height = MAX(size.height, kMinHeight);
    self.lrf_size = CGSizeMake(width, height);
}

@end

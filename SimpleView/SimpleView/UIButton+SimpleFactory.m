//
//  UIButton+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIButton+SimpleFactory.h"
#import "NSObject+Block.h"

@implementation UIButton (SimpleFactory)

#pragma mark - 图片按钮

+(UIButton *)buttonWithFrame:(CGRect)frame normalImage:(UIImage *)normalImg click:(void (^)())click onView:(UIView *)view{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    if (normalImg) {
        [button setImage:normalImg forState:UIControlStateNormal];
    }
    [button setExclusiveTouch:YES];
    if (click) [button onlyHangdleUIControlEvent:UIControlEventTouchUpInside withBlock:click];
    if (view) [view addSubview:button];
    return button;
}

+(UIButton *)buttonWithCenter:(CGPoint)center normalImage:(UIImage *)normalImg click:(void (^)())click onView:(UIView *)view{
    
    return [UIButton buttonWithFrame:CGRectMake(center.x - normalImg.size.width / 2, center.y - normalImg.size.height / 2, normalImg.size.width, normalImg.size.height) normalImage:normalImg click:click onView:view];

}

-(UIButton *)addHighlightedImage:(UIImage *)highlightedImg{
    [self setImage:highlightedImg forState:UIControlStateHighlighted];
    return self;
}

#pragma mark - 文字按钮

+(UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font click:(void (^)())click onView:(UIView *)view{
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    if(title){
        [button setTitle:title forState:UIControlStateNormal];
    }
    [button setExclusiveTouch:YES];
    if (font) button.titleLabel.font = font;
    if (textColor) [button setTitleColor:textColor forState:UIControlStateNormal];
    if (click) [button onlyHangdleUIControlEvent:UIControlEventTouchUpInside withBlock:click];
    if (view) [view addSubview:button];
    return button;
}

-(UIButton *)addHighlightedTitle:(NSString *)title textColor:(UIColor *)textColor{
    [self setTitle:title forState:UIControlStateHighlighted];
    if (textColor) [self setTitleColor:textColor forState:UIControlStateHighlighted];
    return self;
}

CGSize CGSizeMakeTitleSize(NSString *title, UIFont *font, CGFloat maxWidth){
    return [title boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

+(UIButton *)buttonWithCenter:(CGPoint)center title:(NSString *)title textColor:(UIColor *)textColor font:(UIFont *)font click:(void (^)())click onView:(UIView *)view{
    CGSize size = CGSizeMakeTitleSize(title, font, 300);
    return [UIButton buttonWithFrame:CGRectMake(center.x - size.width / 2, center.y - size.height / 2, size.width, size.height) title:title textColor:textColor font:font click:click onView:view];
}

#pragma mark - 空按钮

+(UIButton *)buttonEmptyWithFrame:(CGRect)frame click:(void (^)())click onView:(UIView *)view{
    return [UIButton buttonWithFrame:frame title:nil textColor:nil font:nil click:click onView:view];
}

#pragma mark - 
-(UIButton *)resetBackgroundColor:(UIColor *)color{
    self.backgroundColor = color;
    return self;
}

@end

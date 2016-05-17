//
//  UIBarButtonItem+BackButtonStyle.m
//  SimpleView
//
//  Created by ileo on 16/5/17.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIBarButtonItem+BackButtonStyle.h"
#import "SimpleViewHeader.h"
#import "UIView+Sizes.h"

@implementation UIBarButtonItem (BackButtonStyle)

+(NSArray *)backButtonItemsWithOffsetX:(CGFloat)offsetX image:(UIImage *)image{
    return @[[UIBarButtonItem barButtonItemSpaceWithWidth:offsetX],[UIBarButtonItem barButtonItemWithButton:[UIButton buttonWithCenter:CGPointZero normalImage:image click:nil]]];
}

+(NSArray *)backButtonItemsWithOffsetX:(CGFloat)offsetX image:(UIImage *)image titleOffsetX:(CGFloat)titleOffsetX titleColor:(UIColor *)color titleFont:(UIFont *)font{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero normalImage:image click:nil];
    UILabel *label = [[[UILabel labelWithFrame:CGRectMake(button.width + titleOffsetX, 0, 80, 50) font:font text:nil textColor:color] labelResetTextAlignment:NSTextAlignmentLeft] setupOnView:button];
    label.centerY = button.height/2;
    label.tag = TAG_TITLE_LABEL;
    return @[[UIBarButtonItem barButtonItemSpaceWithWidth:offsetX],[UIBarButtonItem barButtonItemWithButton:button]];
}

@end

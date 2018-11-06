//
//  UITextField+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/6/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UITextField+SimpleFactory.h"

@implementation UITextField (SimpleFactory)

+(UITextField *)textFieldWithFrame:(CGRect)frame textColor:(UIColor *)color font:(UIFont *)font{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.textColor = color;
    textField.font = font;
    return textField;
}





@end

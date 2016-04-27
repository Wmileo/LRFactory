//
//  UIBarButtonItem+SimpleFactory.m
//  SimpleView
//
//  Created by ileo on 16/4/27.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIBarButtonItem+SimpleFactory.h"

@implementation UIBarButtonItem (SimpleFactory)

+(UIBarButtonItem *)barButtonItemSpaceWithWidth:(CGFloat)width{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = width;
    return space;
}

+(UIBarButtonItem *)barButtonItemWithButton:(UIButton *)button{
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end

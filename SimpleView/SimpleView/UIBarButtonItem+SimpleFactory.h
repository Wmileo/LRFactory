//
//  UIBarButtonItem+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/4/27.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SimpleFactory)

/**
 *  生成空格BarButtonItem
 */
+(UIBarButtonItem *)barButtonItemSpaceWithWidth:(CGFloat)width;

/**
 *  生成有Button的BarButtonItem
 */
+(UIBarButtonItem *)barButtonItemWithButton:(UIButton *)button;

@end

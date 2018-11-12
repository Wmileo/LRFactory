//
//  UILabel+LRFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/4.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LRFactory)

- (void)lrf_setupText:(NSString *)text font:(UIFont *)font fitSize:(BOOL)fit;

@end

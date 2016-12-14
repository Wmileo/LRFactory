//
//  UIView+KeyframeAnimation.h
//  SimpleView
//
//  Created by leo on 2016/12/13.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString * const ANIMATION_SCALE = @"transform.scale";
NSString * const ANIMATION_OPACITY = @"opacity";

@interface UIView (KeyframeAnimation)

-(void)addAnimationKeyPath:(NSString *)keyPath values:(NSArray *)values duration

@end

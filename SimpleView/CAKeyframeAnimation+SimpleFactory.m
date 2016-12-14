//
//  CAKeyframeAnimation+SimpleFactory.m
//  SimpleView
//
//  Created by leo on 2016/12/13.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "CAKeyframeAnimation+SimpleFactory.h"

NSString * const ANIMATION_SCALE = @"transform.scale";
NSString * const ANIMATION_OPACITY = @"opacity";

@implementation CAKeyframeAnimation (SimpleFactory)

+(CAKeyframeAnimation *)animationWithKeyPath:(NSString *)keyPath values:(NSArray *)values duration:(NSTimeInterval)duration{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    animation.duration = duration;
    animation.values = values;
    return animation;
}

@end

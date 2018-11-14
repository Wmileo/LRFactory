//
//  CAKeyframeAnimation+LRFactory.m
//  WalletMerchant
//
//  Created by leo on 2017/2/20.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import "CAKeyframeAnimation+LRFactory.h"

NSString * const LRF_ANIMATION_SCALE = @"transform.scale";
NSString * const LRF_ANIMATION_OPACITY = @"opacity";

@implementation CAKeyframeAnimation (LRFactory)

+(CAKeyframeAnimation *)lrf_animationType:(NSString *)type Values:(NSArray *)values duration:(NSTimeInterval)duration{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:type];
    animation.duration = duration;
    animation.values = values;
    return animation;
}



@end

//
//  CAKeyframeAnimation+LRFactory.h
//  WalletMerchant
//
//  Created by leo on 2017/2/20.
//  Copyright © 2017年 qianbao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

extern NSString * const LRF_ANIMATION_SCALE;
extern NSString * const LRF_ANIMATION_OPACITY;

@interface CAKeyframeAnimation (LRFactory) 

+ (CAKeyframeAnimation *)lrf_animationType:(NSString *)type Values:(NSArray *)values duration:(NSTimeInterval)duration;

@end


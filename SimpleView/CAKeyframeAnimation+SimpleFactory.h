//
//  CAKeyframeAnimation+SimpleFactory.h
//  SimpleView
//
//  Created by leo on 2016/12/13.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAKeyframeAnimation (SimpleFactory)

+(CAKeyframeAnimation *)animationWithKeyPath:(NSString *)keyPath values:(NSArray *)values duration:(NSTimeInterval)duration;

@end

//
//  UIColor+LRFactory.h
//  SimpleView
//
//  Created by leo on 2018/11/8.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LRFactory)

+(UIColor *)lrf_colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END

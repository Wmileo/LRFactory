//
//  UIControl+LRFactory.h
//  SimpleView
//
//  Created by leo on 2018/11/7.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (LRFactory)

- (void)lrf_handleEvent:(UIControlEvents)event block:(void(^)(id sender))block;

@end

NS_ASSUME_NONNULL_END

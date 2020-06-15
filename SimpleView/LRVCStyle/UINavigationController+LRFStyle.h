//
//  UINavigationController+LRFStyle.h
//  Aspects
//
//  Created by leo on 2020/6/14.
//

#import <UIKit/UIKit.h>
#import "LRFNavigationBarStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (LRFStyle)

@property (nonatomic, readonly) LRFNavigationBarStyle *lrf_defaultBarStyle;

@end

NS_ASSUME_NONNULL_END

//
//  UIViewController+LRFNavigationTitle.h
//  SimpleView
//
//  Created by leo on 2018/11/13.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LRFNavigationTitle)

//font不建议大于29
- (void)lrf_setupNavigationTitleColor:(UIColor *)color font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END

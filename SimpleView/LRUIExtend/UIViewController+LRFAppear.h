//
//  UIViewController+LRFAppear.h
//  SimpleView
//
//  Created by leo on 2018/11/12.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LRFAppear)

- (void)viewDidDisappear_lrfForever;
- (void)viewWillDisappear_lrfForever:(BOOL)animated;
- (void)viewWillAppear_lrfFirstTime:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END

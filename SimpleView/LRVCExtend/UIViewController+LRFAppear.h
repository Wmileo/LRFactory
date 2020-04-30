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

// 需子类重写， 默认空实现
- (void)lrf_viewWillAppearFirstTime:(BOOL)animated;
- (void)lrf_viewWillDisappearForever:(BOOL)animated;
- (void)lrf_viewDidDisappearForever:(BOOL)animated;

// 
- (void)lrf_addActionWhileViewWillAppear:(void(^)(BOOL animated, BOOL isFirstTime))action;
- (void)lrf_addActionWhileViewDidAppear:(void(^)(BOOL animated))action;
- (void)lrf_addActionWhileViewWillDisappear:(void(^)(BOOL animated, BOOL isForever))action;
- (void)lrf_addActionWhileViewDidDisappear:(void(^)(BOOL animated, BOOL isForever))action;

@end

NS_ASSUME_NONNULL_END

//
//  UIViewController+LRFPresent.h
//  SimpleView
//
//  Created by ileo on 16/6/3.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LRFPresent)

/**
 *  弹出界面，带弹出界面消失的回调信息
 */
- (void)lrf_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion willDismissCallback:(void(^)(NSDictionary *info))willDismissCallback didDismissCallback:(void(^)(NSDictionary *info))didDismissCallback;

/**
 *  消失界面，带回调信息
 */
- (void)lrf_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion info:(NSDictionary *)info;

/**
 *  被该控制器present
 */
@property (nonatomic, readonly) UIViewController *lrf_viewControllerByPresent;

@end

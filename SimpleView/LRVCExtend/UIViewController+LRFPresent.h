//
//  UIViewController+LRFPresent.h
//  SimpleView
//
//  Created by ileo on 16/6/3.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (LRFPresent)

/**
 *  弹出界面，带弹出界面消失的回调信息
 */
- (void)lrf_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ __nullable)(void))completion willDismissCallback:(void(^ __nullable)(id _Nullable info))willDismissCallback didDismissCallback:(void(^ __nullable)(id _Nullable info))didDismissCallback;

/**
 *  消失界面，带回调信息
 */
- (void)lrf_dismissViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion info:(id _Nullable)info;


@end


NS_ASSUME_NONNULL_END

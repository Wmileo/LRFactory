//
//  UIViewController+LRFPush.h
//  Pods
//
//  Created by leo on 2017/7/6.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (LRFPush)

@property (nonatomic, assign) BOOL lrf_popIgnore;//pop时忽略

- (void)viewWillAppear_lrfByNavigationPush:(BOOL)animated;
- (void)viewWillAppear_lrfByNavigationPop:(BOOL)animated;
- (void)viewWillDisappear_lrfByNavigationPush:(BOOL)animated;
- (void)viewWillDisappear_lrfByNavigationPop:(BOOL)animated;

@end

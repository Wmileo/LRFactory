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

@property (nonatomic, copy) void (^lrf_viewWillAppearByNavigationPush)(BOOL animated);
@property (nonatomic, copy) void (^lrf_viewWillAppearByNavigationPop)(BOOL animated);
@property (nonatomic, copy) void (^lrf_viewWillDisappearByNavigationPush)(BOOL animated);
@property (nonatomic, copy) void (^lrf_viewWillDisappearByNavigationPop)(BOOL animated);

@end

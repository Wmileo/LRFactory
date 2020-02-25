//
//  UIViewController+LRFAppear.h
//  SimpleView
//
//  Created by leo on 2018/11/12.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (LRFAppear)

@property (nonatomic, copy) void (^lrf_viewDidDisappearForever)(BOOL animated);
@property (nonatomic, copy) void (^lrf_viewWillDisappearForever)(BOOL animated);
@property (nonatomic, copy) void (^lrf_viewWillAppearFirstTime)(BOOL animated);

@property (nonatomic, copy) void (^lrf_viewWillAppear)(BOOL animated, BOOL isFirstTime);
@property (nonatomic, copy) void (^lrf_viewDidAppear)(BOOL animated);
@property (nonatomic, copy) void (^lrf_viewWillDisappear)(BOOL animated, BOOL isForever);
@property (nonatomic, copy) void (^lrf_viewDidDisappear)(BOOL animated, BOOL isForever);

@end


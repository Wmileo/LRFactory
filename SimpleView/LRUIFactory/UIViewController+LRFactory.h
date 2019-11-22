//
//  UIViewController+LRFactory.h
//  SimpleView
//
//  Created by leo on 2017/3/31.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LRFactory)

//导航的上一个页面
@property (nonatomic, readonly) UIViewController *lrf_prevNavigationViewController;

//导航的下一个页面
@property (nonatomic, readonly) UIViewController *lrf_nextNavigationViewController;

//是否当前可见的
@property (nonatomic, readonly) BOOL lrf_isVisible;

//是否最终控制器（比如该控制器还包含子控制器则返回NO）
@property (nonatomic, readonly) BOOL lrf_isFinalController;

@end

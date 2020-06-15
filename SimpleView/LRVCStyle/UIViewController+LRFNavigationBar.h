//
//  UIViewController+LRFNavigationBar.h
//  SimpleView
//
//  Created by leo on 2018/11/14.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+LRFStyle.h"

@interface UIViewController (LRFNavigationBar)

//edgesForExtendedLayout  UIRectEdgeNone为从导航底部开始页面

- (void) lrf_hookNavigationBarStyle;

@property (nonatomic, readonly) BOOL lrf_isNavigationBarStyleHandle;

@property (nonatomic, readonly) LRFNavigationBarStyle *lrf_navigationBarStyle;


@end

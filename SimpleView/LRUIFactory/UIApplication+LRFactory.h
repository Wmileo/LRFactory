//
//  UIApplication+LRFactory.h
//  SimpleView
//
//  Created by leo on 2018/11/6.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (LRFactory)

+ (UIViewController *)lrf_currentViewController;

+ (UIWindow *)lrf_mainWindow;

@end


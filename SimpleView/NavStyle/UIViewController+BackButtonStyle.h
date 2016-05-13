//
//  UIViewController+BackButtonStyle.h
//  SimpleView
//
//  Created by ileo on 16/5/10.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIViewControllerBackButtonDataSource <NSObject>

@optional

/**
 *  是否能右滑返回手势
 */
-(BOOL)viewControllerShouldGesturePopBack;

@end


@interface UIViewController (BackButtonStyle) 

/**
 *  配置右滑返回手势  ps.应用开启时配置
 */
+(void)configViewControllerGesturePopBack;



@end

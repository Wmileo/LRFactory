//
//  UIViewController+BackButtonStyle.h
//  SimpleView
//
//  Created by ileo on 16/5/10.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+BackButtonStyle.h"

@protocol UIViewControllerBackButtonDataSource <NSObject>

@optional

/**
 *  是否能右滑返回手势
 */
-(BOOL)viewControllerShouldGesturePopBack;

/**
 *  点击返回按钮
 */
-(void)navClickOnBackItem;

/**
 *  返回按钮文字描述
 */
-(NSString *)navBackItemTitle;

@end


@interface UIViewController (BackButtonStyle) 

/**
 *  配置右滑返回手势  ps.应用开启时配置
 */
+(void)configViewControllerGesturePopBack;

#pragma mark - 返回按钮
/**
 *  配置返回按钮样式 key为identification  value为数组元素为barButtonItem
 */
+(void)configBackItemIdentifications:(NSDictionary* (^)())identifications;

/**
 *  设置返回按钮 样式为identification对应的样式
 */
-(instancetype)navSetupBackItemWithIdentification:(NSString *)identification;

/**
 *  返回上一个ViewController的title
 */
-(NSString *)navLastTitle;

@end

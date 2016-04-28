//
//  UIViewController+SimpleNavigation.h
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (SimpleNavigation)









/**
 *  设置按钮nav barbuttonitem
 */
-(id)navSetupLeftButton:(UIButton *)button;
-(id)navSetupRightButton:(UIButton *)button;

/**
 *  设置图片nav barbuttonitem
 */
-(id)navSetupLeftImageName:(NSString *)name action:(void (^)())action;
-(id)navSetupRightImageName:(NSString *)name action:(void(^)())action;

/**
 *  设置文字nav barbuttonitem
 */
-(id)navSetupLeftTitle:(NSString *)title action:(void(^)())action;
-(id)navSetupRightTitle:(NSString *)title action:(void(^)())action;

/**
 *  设置间隔nav barbuttonitem
 */
-(id)navSetupLeftSpaceWithWidth:(CGFloat)width;
-(id)navSetupRightSpaceWithWidth:(CGFloat)width;

/**
 *  添加按钮nav barbuttonitem
 */
-(id)navAddLeftButton:(UIButton *)button;
-(id)navAddRightButton:(UIButton *)button;

/**
 *  添加图片nav barbuttonitem
 */
-(id)navAddLeftImageName:(NSString *)name action:(void (^)())action;
-(id)navAddRightImageName:(NSString *)name action:(void(^)())action;

/**
 *  添加文字nav barbuttonitem
 */
-(id)navAddLeftTitle:(NSString *)title action:(void(^)())action;
-(id)navAddRightTitle:(NSString *)title action:(void(^)())action;

/**
 *  添加间隔nav barbuttonitem
 */
-(id)navAddLeftSpaceWithWidth:(CGFloat)width;
-(id)navAddRightSpaceWithWidth:(CGFloat)width;



@end

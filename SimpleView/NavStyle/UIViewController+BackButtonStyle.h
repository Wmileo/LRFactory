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

/**
 *  点击返回按钮
 */
-(void)navClickOnBackItem;

/**
 *  返回按钮文字描述
 */
-(NSString *)navBackItemTitle;


/**
 *  返回按钮将要响应
 */
-(void)navBackItemWillHandleClick;


@end


@interface UIViewController (BackButtonStyle) <UIViewControllerBackButtonDataSource>

/**
 *  配置右滑返回手势  ps.应用开启时配置
 */
+(void)configViewControllerGesturePopBack;

#pragma mark - 返回按钮
/**
 *  配置返回按钮样式 key为style  value为BackItemModel
 */
+(void)configBackItemStyles:(NSDictionary*)styles;

/**
 *  配置默认返回按钮样式
 */
+(void)configDefaultBackItemWithStyle:(NSString *)style;

/**
 *  设置返回按钮 样式为style对应的样式
 */
-(instancetype)navSetupBackItemWithStyle:(NSString *)style;

/**
 *  设置返回按钮 样式为style对应的样式 点击为action
 */
-(instancetype)navSetupBackItemWithStyle:(NSString *)style action:(void (^)())action;

/**
 *  返回上一个ViewController的title
 */
-(NSString *)navLastTitle;

@end

@interface BackItemModel : NSObject

@property (nonatomic, assign) CGFloat offsetX;//位移  负数往左移  正数往右移
@property (nonatomic, strong) UIImage *icon;//返回按钮的图标
@property (nonatomic, assign) BOOL hasTitle;//是否有title
@property (nonatomic, assign) CGFloat titleOffsetX;//title距离icon的位移
@property (nonatomic, strong) UIColor *titleColor;//title颜色
@property (nonatomic, strong) UIFont *titleFont;//title字体

+(BackItemModel *)modelWithOffsetX:(CGFloat)offsetX icon:(UIImage *)icon;//只生成图标 不生成文字
+(BackItemModel *)modelWithOffsetX:(CGFloat)offsetX icon:(UIImage *)icon titleOffsetX:(CGFloat)titleOffsetX titleColor:(UIColor *)color titleFont:(UIFont *)font;//生成图标文字

@end



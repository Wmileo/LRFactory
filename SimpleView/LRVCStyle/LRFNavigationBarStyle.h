//
//  LRFNavigationBarStyle.h
//  SimpleView
//
//  Created by leo on 2020/6/15.
//  Copyright © 2020 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRFNavigationBarStyle : NSObject

- (void)bindingViewController:(UIViewController *)viewController;

- (void)updateWithNavigationController:(UINavigationController *)navigationController;
- (void)updateWithNavigationBarStyle:(LRFNavigationBarStyle *)style;

- (void)layoutNavigationBar:(BOOL)animated;

- (void)startObserve;
- (void)endObserve;

/**
 *  是否实时更新
 */
@property (nonatomic, assign) BOOL isRealTime;

/**
 *  导航栏隐藏
 */
@property (nonatomic, assign) BOOL isHidden;
- (void)setIsHidden:(BOOL)isHidden animated:(BOOL)animated;

/**
 *  背景颜色
 */
@property (nonatomic, strong, nullable) UIColor *tintColor;

/**
 *  item字体颜色
 */
@property (nonatomic, strong, nullable) UIColor *itemTintColor;

/**
 * title字体样式颜色
 */
@property (nonatomic, copy, nullable) NSDictionary<NSAttributedStringKey,id> *titleTextAttributes;
@property (nonatomic, strong, nullable) UIFont *titleFont;
@property (nonatomic, strong, nullable) UIColor *titleColor;

/**
 *  底部阴影 nil为默认阴影
 */
@property (nonatomic, strong, nullable) UIImage *shadowImage;

/**
 *  背景图片 nil为默认图片
 */
@property (nonatomic, strong, nullable) UIImage *backgroundImage;

/**
 *  导航栏背景半透明
 */
@property (nonatomic, assign) BOOL isTranslucent;

/**
 *  导航栏背景透明
 */
@property (nonatomic, assign) BOOL isClear;

@end

NS_ASSUME_NONNULL_END

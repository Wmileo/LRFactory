//
//  UIViewController+LRFNavigationItem.h
//  SimpleView
//
//  Created by leo on 2018/11/16.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LRF_BarButtonItem_Side){
    LRF_BarButtonItem_Side_Left,
    LRF_BarButtonItem_Side_Right
};

@interface UIViewController (LRFNavigationItem)

@property (nonatomic, readonly) NSArray<UIView *> *lrf_navigationItemLeftViews;
@property (nonatomic, readonly) NSArray<UIView *> *lrf_navigationItemRightViews;

#pragma mark - setup

- (void)lrf_setupNavigationItemWithBarButtonItem:(UIBarButtonItem *)barButtonItem side:(LRF_BarButtonItem_Side)side;

- (void)lrf_setupNavigationItemWithButton:(UIButton *)button side:(LRF_BarButtonItem_Side)side;

- (void)lrf_setupNavigationItemWithImage:(UIImage *)image side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action;

- (void)lrf_setupNavigationItemWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action;

//只支持正数
- (void)lrf_setupNavigationItemWithSpace:(CGFloat)width side:(LRF_BarButtonItem_Side)side;

#pragma mark - add   左边从左到右。 右边从右到左

- (void)lrf_addNavigationItemWithBarButtonItem:(UIBarButtonItem *)barButtonItem side:(LRF_BarButtonItem_Side)side;

- (void)lrf_addNavigationItemWithButton:(UIButton *)button side:(LRF_BarButtonItem_Side)side;

- (void)lrf_addNavigationItemWithImage:(UIImage *)image side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action;

- (void)lrf_addNavigationItemWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action;

//只支持正数
- (void)lrf_addNavigationItemWithSpace:(CGFloat)width side:(LRF_BarButtonItem_Side)side;


@end

NS_ASSUME_NONNULL_END

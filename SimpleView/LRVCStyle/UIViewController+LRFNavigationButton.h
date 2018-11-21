//
//  UIViewController+LRFNavigationButton.h
//  SimpleView
//
//  Created by leo on 2018/11/19.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+LRFNavigationItem.h"

@interface UIViewController (LRFNavigationButton)

@property (nonatomic, strong) UIColor *lrf_navigationItemColor;
@property (nonatomic, strong) UIFont *lrf_navigationItemFont;

- (void)lrf_setupNavigationItemWithText:(NSString *)text side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action;

- (void)lrf_addNavigationItemWithText:(NSString *)text side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action;

#pragma mark - back

@property (nonatomic, strong) UIImage *lrf_navigationBackImage;//图片
@property (nonatomic, strong) UIColor *lrf_navigationBackColor;//文字颜色
@property (nonatomic, strong) UIFont *lrf_navigationBackFont;//文字字体
@property (nonatomic, assign) CGFloat lrf_navigationBackGap;//图片文字间隙
@property (nonatomic, copy) NSString *lrf_navigationBackTitle;//文字
@property (nonatomic, copy) void (^lrf_navigationBackClick)(void);//点击

@property (nonatomic, readonly) NSString *lrf_navigationBackPrevTitle;//上一级页面title

@end


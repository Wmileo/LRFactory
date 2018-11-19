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

@property (nonatomic, copy) void (^lrf_clickBack)(void);

- (void)lrf_setupNavigationBackItemWithImage:(UIImage *)image;
- (void)lrf_setupNavigationBackItemWithText:(NSString *)text;

@end


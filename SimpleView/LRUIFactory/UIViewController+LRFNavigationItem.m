//
//  UIViewController+LRFNavigationItem.m
//  SimpleView
//
//  Created by leo on 2018/11/16.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFNavigationItem.h"
#import "UIView+LRFactory.h"
#import "UIButton+LRFactory.h"
#import "UIBarButtonItem+LRFactory.h"

@implementation UIViewController (LRFNavigationItem)

- (void)lrf_setupNavigationItemWithBarButtonItem:(UIBarButtonItem *)barButtonItem side:(LRF_BarButtonItem_Side)side{
    if (side == LRF_BarButtonItem_Side_Left) {
        [self.navigationItem setLeftBarButtonItems:@[barButtonItem]];
    }else{
        [self.navigationItem setRightBarButtonItems:@[barButtonItem]];
    }
}

- (void)lrf_setupNavigationItemWithButton:(UIButton *)button side:(LRF_BarButtonItem_Side)side{
    [self lrf_setupNavigationItemWithBarButtonItem:[UIBarButtonItem lrf_barButtonItemWithButton:button] side:side];
}

- (void)lrf_setupNavigationItemWithImage:(UIImage *)image side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action{
    [self lrf_setupNavigationItemWithButton:[self buttonWithImage:image side:side action:action] side:side];
}

- (void)lrf_setupNavigationItemWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action{
    [self lrf_setupNavigationItemWithButton:[self buttonWithText:text color:color font:font action:action] side:side];
}

- (void)lrf_setupNavigationItemWithSpace:(CGFloat)width side:(LRF_BarButtonItem_Side)side{
    [self lrf_setupNavigationItemWithBarButtonItem:[UIBarButtonItem lrf_barButtonItemSpaceWithWidth:width] side:side];
}

- (void)lrf_addNavigationItemWithBarButtonItem:(UIBarButtonItem *)barButtonItem side:(LRF_BarButtonItem_Side)side{
    NSArray *items = side == LRF_BarButtonItem_Side_Left ? self.navigationItem.leftBarButtonItems : self.navigationItem.rightBarButtonItems;
    NSMutableArray *arr = [NSMutableArray arrayWithArray:items];
    [arr addObject:barButtonItem];
    if (side == LRF_BarButtonItem_Side_Left) {
        [self.navigationItem setLeftBarButtonItems:arr];
    }else{
        [self.navigationItem setRightBarButtonItems:arr];
    }
}

- (void)lrf_addNavigationItemWithButton:(UIButton *)button side:(LRF_BarButtonItem_Side)side{
    [self lrf_addNavigationItemWithBarButtonItem:[UIBarButtonItem lrf_barButtonItemWithButton:button] side:side];
}

- (void)lrf_addNavigationItemWithImage:(UIImage *)image side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action{
    [self lrf_addNavigationItemWithButton:[self buttonWithImage:image side:side action:action] side:side];
}

- (void)lrf_addNavigationItemWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font side:(LRF_BarButtonItem_Side)side action:(void (^)(void))action{
    [self lrf_addNavigationItemWithButton:[self buttonWithText:text color:color font:font action:action] side:side];
}

- (void)lrf_addNavigationItemWithSpace:(CGFloat)width side:(LRF_BarButtonItem_Side)side{
    [self lrf_addNavigationItemWithBarButtonItem:[UIBarButtonItem lrf_barButtonItemSpaceWithWidth:width] side:side];
}


#pragma mark - set get

- (NSArray<UIView *> *)lrf_navigationItemLeftViews{
    return [self lrf_navigationItemViewsWithItems:self.navigationItem.leftBarButtonItems];
}

- (NSArray<UIView *> *)lrf_navigationItemRightViews{
    return [self lrf_navigationItemViewsWithItems:self.navigationItem.rightBarButtonItems];
}

- (NSArray<UIView *> *)lrf_navigationItemViewsWithItems:(NSArray<UIBarButtonItem *> *)items{
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:items.count];
    [items enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj.customView;
        if (view) {
            [views addObject:view];
        }
    }];
    return [views copy];
}

- (UIButton *)buttonWithText:(NSString *)text color:(UIColor *)color font:(UIFont *)font action:(void(^)(void))action{
    UIButton *button = [UIButton lrf_view];
    [button lrf_setupNormalText:text color:color font:font fitSize:YES];
    [button lrf_setupFixedType:LRF_Fixed_CenterX_CenterY point:CGPointZero];
    [button lrf_handleEventTouchUpInsideBlock:action];
    return button;
}

- (UIButton *)buttonWithImage:(UIImage *)image side:(LRF_BarButtonItem_Side)side action:(void(^)(void))action{
    UIButton *button = [UIButton lrf_view];
    [button lrf_setupNormalImage:image aligning:(side == LRF_BarButtonItem_Side_Left ? LRF_Image_Aligning_Left : LRF_Image_Aligning_Right)];
    [button lrf_setupFixedType:LRF_Fixed_CenterX_CenterY point:CGPointZero];
    [button lrf_handleEventTouchUpInsideBlock:action];
    return button;
}

@end

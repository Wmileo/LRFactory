//
//  UIViewController+SimpleNavigation.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+SimpleNavigation.h"
#import "UIBarButtonItem+SimpleFactory.h"
#import "UIButton+SimpleFactory.h"

@implementation UIViewController (SimpleNavigation)

/**
 *  设置按钮nav barbuttonitem
 */
-(id)navSetupLeftButton:(UIButton *)button{
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
    return self;
}
-(id)navSetupRightButton:(UIButton *)button{
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
    return self;
}

#warning highlight
/**
 *  设置图片nav barbuttonitem
 */
-(id)navSetupLeftImageName:(NSString *)name action:(void (^)())action{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero normalImage:[UIImage imageNamed:name] click:action onView:nil];
    return [self navSetupLeftButton:button];
}
-(id)navSetupRightImageName:(NSString *)name action:(void(^)())action{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero normalImage:[UIImage imageNamed:name] click:action onView:nil];
    return [self navSetupRightButton:button];
}

#warning color font
/**
 *  设置文字nav barbuttonitem
 */
-(id)navSetupLeftTitle:(NSString *)title action:(void(^)())action{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero title:title textColor:nil font:nil click:action onView:nil];
    return [self navSetupLeftButton:button];
}
-(id)navSetupRightTitle:(NSString *)title action:(void(^)())action{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero title:title textColor:nil font:nil click:action onView:nil];
    return [self navSetupRightButton:button];
}

/**
 *  设置间隔nav barbuttonitem
 */
-(id)navSetupLeftSpaceWithWidth:(CGFloat)width{
    [self.navigationItem setLeftBarButtonItem:[UIBarButtonItem barButtonItemSpaceWithWidth:width]];
    return self;
}
-(id)navSetupRightSpaceWithWidth:(CGFloat)width{
    [self.navigationItem setRightBarButtonItem:[UIBarButtonItem barButtonItemSpaceWithWidth:width]];
    return self;
}

/**
 *  添加按钮nav barbuttonitem
 */
-(id)navAddLeftButton:(UIButton *)button{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [arr addObject:[UIBarButtonItem barButtonItemWithButton:button]];
    [self.navigationItem setLeftBarButtonItems:arr];
    return self;
}
-(id)navAddRightButton:(UIButton *)button{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [arr addObject:[UIBarButtonItem barButtonItemWithButton:button]];
    [self.navigationItem setRightBarButtonItems:arr];
    return self;
}

#warning highlight
/**
 *  添加图片nav barbuttonitem
 */
-(id)navAddLeftImageName:(NSString *)name action:(void (^)())action{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero normalImage:[UIImage imageNamed:name] click:action onView:nil];
    return [self navAddLeftButton:button];
}
-(id)navAddRightImageName:(NSString *)name action:(void(^)())action{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero normalImage:[UIImage imageNamed:name] click:action onView:nil];
    return [self navAddRightButton:button];
}

#warning color font
/**
 *  添加文字nav barbuttonitem
 */
-(id)navAddLeftTitle:(NSString *)title action:(void(^)())action{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero title:title textColor:nil font:nil click:action onView:nil];
    return [self navAddLeftButton:button];
}
-(id)navAddRightTitle:(NSString *)title action:(void(^)())action{
    UIButton *button = [UIButton buttonWithCenter:CGPointZero title:title textColor:nil font:nil click:action onView:nil];
    return [self navAddRightButton:button];
}

/**
 *  添加间隔nav barbuttonitem
 */
-(id)navAddLeftSpaceWithWidth:(CGFloat)width{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [arr addObject:[UIBarButtonItem barButtonItemSpaceWithWidth:width]];
    [self.navigationItem setLeftBarButtonItems:arr];
    return self;
}
-(id)navAddRightSpaceWithWidth:(CGFloat)width{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [arr addObject:[UIBarButtonItem barButtonItemSpaceWithWidth:width]];
    [self.navigationItem setRightBarButtonItems:arr];
    return self;
}

@end

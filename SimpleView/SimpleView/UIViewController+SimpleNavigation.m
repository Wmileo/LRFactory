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
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, BarButtonSide){
    BarButtonSideLeft,
    BarButtonSideRight
};


@implementation UIViewController (SimpleNavigation)

#pragma mark - 设置按钮

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

/**
 *  设置图片nav barbuttonitem
 */
-(id)navSetupLeftImageName:(NSString *)name action:(void (^)())action{
    return [self navSetupLeftButton:[self buttonWithImageName:name action:action]];
}
-(id)navSetupRightImageName:(NSString *)name action:(void(^)())action{
    return [self navSetupRightButton:[self buttonWithImageName:name action:action]];
}

/**
 *  设置文字nav barbuttonitem
 */
-(id)navSetupLeftTitle:(NSString *)title action:(void(^)())action{
    return [self navSetupLeftButton:[self buttonSide:BarButtonSideLeft withTitle:title action:action]];
}
-(id)navSetupRightTitle:(NSString *)title action:(void(^)())action{
    return [self navSetupRightButton:[self buttonSide:BarButtonSideRight withTitle:title action:action]];
}

/**
 *  设置间隔nav barbuttonitem
 */
-(id)navSetupLeftSpaceWithWidth:(CGFloat)width{
    [self.navigationItem setLeftBarButtonItems:@[[UIBarButtonItem barButtonItemSpaceWithWidth:width]]];
    return self;
}
-(id)navSetupRightSpaceWithWidth:(CGFloat)width{
    [self.navigationItem setRightBarButtonItems:@[[UIBarButtonItem barButtonItemSpaceWithWidth:width]]];
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

/**
 *  添加图片nav barbuttonitem
 */
-(id)navAddLeftImageName:(NSString *)name action:(void (^)())action{
    return [self navAddLeftButton:[self buttonWithImageName:name action:action]];
}
-(id)navAddRightImageName:(NSString *)name action:(void(^)())action{
    return [self navAddRightButton:[self buttonWithImageName:name action:action]];
}

/**
 *  添加文字nav barbuttonitem
 */
-(id)navAddLeftTitle:(NSString *)title action:(void(^)())action{
    return [self navAddLeftButton:[self buttonSide:BarButtonSideLeft withTitle:title action:action]];
}
-(id)navAddRightTitle:(NSString *)title action:(void(^)())action{
    return [self navAddRightButton:[self buttonSide:BarButtonSideRight withTitle:title action:action]];
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

-(UIButton *)buttonSide:(BarButtonSide)side withTitle:(NSString *)title action:(void(^)())action{
    UIColor *color = [UIViewController navTextColor];
    UIFont *font = [UIViewController navTextFont];

    if (side == BarButtonSideLeft) {
        if ([[self class] respondsToSelector:@selector(navBarButtonItemLeftTextColor)]) {
            color = [[self class] navBarButtonItemLeftTextColor];
        }
        if ([[self class] respondsToSelector:@selector(navBarButtonItemLeftTextFont)]) {
            font = [[self class] navBarButtonItemLeftTextFont];
        }
    }else if (side == BarButtonSideRight) {
        if ([[self class] respondsToSelector:@selector(navBarButtonItemRightTextColor)]) {
            color = [[self class] navBarButtonItemRightTextColor];
        }
        if ([[self class] respondsToSelector:@selector(navBarButtonItemRightTextFont)]) {
            font = [[self class] navBarButtonItemRightTextFont];
        }
    }

    return [UIButton buttonWithCenter:CGPointZero title:title textColor:color font:font click:action onView:nil];
}

-(UIButton *)buttonWithImageName:(NSString *)name action:(void(^)())action{
    return [UIButton buttonWithCenter:CGPointZero normalImage:[UIImage imageNamed:name] click:action onView:nil];
}

#pragma mark - setter getter

static char keyTextColor, keyTextFont;

+(void)configNavButtonTextColor:(UIColor *)color font:(UIFont *)font{
    objc_setAssociatedObject(self, &keyTextColor, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &keyTextFont, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+(UIColor *)navTextColor{
    return objc_getAssociatedObject(self, &keyTextColor);
}

+(UIFont *)navTextFont{
    return objc_getAssociatedObject(self, &keyTextFont);
}

@end

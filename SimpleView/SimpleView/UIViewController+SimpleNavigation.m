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
#import "UILabel+SimpleFactory.h"
#import "UIView+Sizes.h"
#import <objc/runtime.h>
#import "NSObject+Method.h"
#import "UINavigationController+SimpleFactory.h"

typedef NS_ENUM(NSInteger, BarButtonSide){
    BarButtonSideLeft,
    BarButtonSideRight
};

@implementation UIViewController (SimpleNavigation)

#pragma mark - title

static char keyTitleColor;
static char keyTitleFont;
static char keyIsTitleCustom;

-(void)navResetTitleColor:(UIColor *)color font:(UIFont *)font{
    
    self.navigationItem.titleView = [UILabel labelWithCenter:CGPointZero font:font text:self.title textColor:color];
    
    objc_setAssociatedObject(self, &keyIsTitleCustom, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &keyTitleFont, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &keyTitleColor, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(setTitle:) withSEL:@selector(SimpleNavigation_setTitle:)];
    });
}

-(void)SimpleNavigation_setTitle:(NSString *)title{
    [self SimpleNavigation_setTitle:title];
    if ([objc_getAssociatedObject(self, &keyIsTitleCustom) boolValue]) {
        self.navigationItem.titleView = [UILabel labelWithCenter:CGPointZero font:objc_getAssociatedObject(self, &keyTitleFont) text:self.title textColor:objc_getAssociatedObject(self, &keyTitleColor)];
    }
}

#pragma mark - 设置按钮

-(instancetype)navSetupLeftBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self.navigationItem setLeftBarButtonItems:@[barButtonItem]];
    return self;
}

-(instancetype)navSetupRightBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self.navigationItem setRightBarButtonItems:@[barButtonItem]];
    return self;
}

/**
 *  设置按钮nav barbuttonitem
 */
-(instancetype)navSetupLeftButton:(UIButton *)button{
    return [self navSetupLeftBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
}
-(instancetype)navSetupRightButton:(UIButton *)button{
    return [self navSetupRightBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
}

/**
 *  设置图片nav barbuttonitem
 */
-(instancetype)navSetupLeftImageName:(NSString *)name action:(void (^)())action{
    return [self navSetupLeftButton:[self buttonWithImageName:name action:action]];
}
-(instancetype)navSetupRightImageName:(NSString *)name action:(void(^)())action{
    return [self navSetupRightButton:[self buttonWithImageName:name action:action]];
}

/**
 *  设置文字nav barbuttonitem
 */
-(instancetype)navSetupLeftTitle:(NSString *)title action:(void(^)())action{
    if (![UIViewController hadConfigTextColorAndFont]) {
        return [self navSetupLeftBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:title action:action]];
    }else{
        return [self navSetupLeftButton:[self buttonSide:BarButtonSideLeft withTitle:title action:action]];
    }
}
-(instancetype)navSetupRightTitle:(NSString *)title action:(void(^)())action{
    if (![UIViewController hadConfigTextColorAndFont]) {
        return [self navSetupRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:title action:action]];
    }else{
        return [self navSetupRightButton:[self buttonSide:BarButtonSideRight withTitle:title action:action]];
    }
}

/**
 *  设置间隔nav barbuttonitem
 */
-(instancetype)navSetupLeftSpaceWithWidth:(CGFloat)width{
    [self.navigationItem setLeftBarButtonItems:@[[UIBarButtonItem barButtonItemSpaceWithWidth:width]]];
    return self;
}
-(instancetype)navSetupRightSpaceWithWidth:(CGFloat)width{
    [self.navigationItem setRightBarButtonItems:@[[UIBarButtonItem barButtonItemSpaceWithWidth:width]]];
    return self;
}

-(instancetype)navAddLeftBarButtonItem:(UIBarButtonItem *)barButtonItem{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [arr addObject:barButtonItem];
    [self.navigationItem setLeftBarButtonItems:arr];
    return self;
}

-(instancetype)navAddRightBarButtonItem:(UIBarButtonItem *)barButtonItem{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [arr addObject:barButtonItem];
    [self.navigationItem setRightBarButtonItems:arr];
    return self;
}

/**
 *  添加按钮nav barbuttonitem
 */
-(instancetype)navAddLeftButton:(UIButton *)button{
    return [self navAddLeftBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];

}
-(instancetype)navAddRightButton:(UIButton *)button{
    return [self navAddRightBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
}

/**
 *  添加图片nav barbuttonitem
 */
-(instancetype)navAddLeftImageName:(NSString *)name action:(void (^)())action{
    return [self navAddLeftButton:[self buttonWithImageName:name action:action]];
}
-(instancetype)navAddRightImageName:(NSString *)name action:(void(^)())action{
    return [self navAddRightButton:[self buttonWithImageName:name action:action]];
}

/**
 *  添加文字nav barbuttonitem
 */
-(instancetype)navAddLeftTitle:(NSString *)title action:(void(^)())action{
    if (![UIViewController hadConfigTextColorAndFont]) {
        return [self navAddLeftBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:title action:action]];
    }else{
        return [self navAddLeftButton:[self buttonSide:BarButtonSideLeft withTitle:title action:action]];
    }
}
-(instancetype)navAddRightTitle:(NSString *)title action:(void(^)())action{
    if (![UIViewController hadConfigTextColorAndFont]) {
        return [self navAddRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:title action:action]];
    }else{
        return [self navAddRightButton:[self buttonSide:BarButtonSideRight withTitle:title action:action]];
    }
}

/**
 *  添加间隔nav barbuttonitem
 */
-(instancetype)navAddLeftSpaceWithWidth:(CGFloat)width{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [arr addObject:[UIBarButtonItem barButtonItemSpaceWithWidth:width]];
    [self.navigationItem setLeftBarButtonItems:arr];
    return self;
}
-(instancetype)navAddRightSpaceWithWidth:(CGFloat)width{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [arr addObject:[UIBarButtonItem barButtonItemSpaceWithWidth:width]];
    [self.navigationItem setRightBarButtonItems:arr];
    return self;
}

-(UIButton *)buttonSide:(BarButtonSide)side withTitle:(NSString *)title action:(void(^)())action{
    UIColor *color = [UIViewController navTextColor];
    UIFont *font = [UIViewController navTextFont];

    if (side == BarButtonSideLeft) {
        if ([self respondsToSelector:@selector(navBarButtonItemLeftTextColor)]) {
            color = [self performSelector:@selector(navBarButtonItemLeftTextColor)];
        }
        if ([self respondsToSelector:@selector(navBarButtonItemLeftTextFont)]) {
            font = [self performSelector:@selector(navBarButtonItemLeftTextFont)];
        }
    }else if (side == BarButtonSideRight) {
        if ([self respondsToSelector:@selector(navBarButtonItemRightTextColor)]) {
            color = [self performSelector:@selector(navBarButtonItemRightTextColor)];
        }
        if ([self respondsToSelector:@selector(navBarButtonItemRightTextFont)]) {
            font = [self performSelector:@selector(navBarButtonItemRightTextFont)];
        }
    }
    UIButton *button = [UIButton buttonWithCenter:CGPointZero title:title textColor:color font:font click:action];
    return button;
}

-(UIButton *)buttonWithImageName:(NSString *)name action:(void(^)())action{
    return [UIButton buttonWithCenter:CGPointZero normalImage:[UIImage imageNamed:name] click:action];
}

#pragma mark - setter getter

static UIColor *textColor;
static UIFont *textFont;
static BOOL hadConfigTextColorAndFont;

+(void)configNavButtonTextColor:(UIColor *)color font:(UIFont *)font{
    textColor = color;
    textFont = font;
    hadConfigTextColorAndFont = YES;
    [[UINavigationBar appearance] setTintColor:color];
}

+(BOOL)hadConfigTextColorAndFont{
    return hadConfigTextColorAndFont;
}

+(UIColor *)navTextColor{
    return textColor;
}

+(UIFont *)navTextFont{
    return textFont;
}

+(void)configNavTitleTextColor:(UIColor *)color font:(UIFont *)font{
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : color, NSFontAttributeName : font}];
}

static UIColor *navBackgroundColor;
static UIStatusBarStyle defaultStatusBarStyle;

+(void)configNavBackgroundColor:(UIColor *)color{
    navBackgroundColor = color;
    [[UINavigationBar appearance] setBarTintColor:color];
}

+(UIColor *)navBackgroundColor{
    return navBackgroundColor;
}

+(void)configDefaultPreferredStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    [UINavigationController configChildViewControllerForStatusBarStyle];
    defaultStatusBarStyle = statusBarStyle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       [UIViewController exchangeSEL:@selector(preferredStatusBarStyle) withSEL:@selector(SimpleNavigation_preferredStatusBarStyle)];
    });
}

+(void)configViewControllerRectEdgeNoneForExtendedLayout{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController exchangeSEL:@selector(viewDidLoad) withSEL:@selector(SimpleNavigation_viewDidLoad)];
    });
}

+(void)autoHidesBottomBarWhenPush{
    [UINavigationController autoHidesBottomBarWhenPush];
}

-(UIStatusBarStyle)SimpleNavigation_preferredStatusBarStyle{
    return defaultStatusBarStyle;
}

-(void)SimpleNavigation_viewDidLoad{
    if (self.navigationController) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self SimpleNavigation_viewDidLoad];
}

-(NSArray<UIView *> *)navLeftViews{
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:self.navigationItem.leftBarButtonItems.count];
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj.customView;
        if (view) {
            [views addObject:view];
        }
    }];
    return [views copy];
}

-(NSArray<UIView *> *)navRightViews{
    NSMutableArray *views = [NSMutableArray arrayWithCapacity:self.navigationItem.rightBarButtonItems.count];
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *view = obj.customView;
        if (view) {
            [views addObject:view];
        }
    }];
    return [views copy];
}

@end

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
#import "Aspects.h"

typedef NS_ENUM(NSInteger, BarButtonSide){
    BarButtonSideLeft,
    BarButtonSideRight
};

@implementation UIViewController (SimpleNavigation)

#pragma mark - title
-(void)navResetTitleColor:(UIColor *)color font:(UIFont *)font{
    
    self.navigationItem.titleView = [UILabel labelWithCenter:CGPointZero font:font text:self.title textColor:color];

    __weak __typeof(self) wself = self;
    [self aspect_hookSelector:@selector(setTitle:) withOptions:AspectPositionAfter usingBlock:^(){
        wself.navigationItem.titleView = [UILabel labelWithCenter:CGPointZero font:font text:wself.title textColor:color];
    } error:NULL];
    
}

#pragma mark - 设置按钮

-(instancetype)navSetupLeftBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    return self;
}

-(instancetype)navSetupRightBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self.navigationItem setRightBarButtonItem:barButtonItem];
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
        return [self navSetupLeftBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:title action:action]];
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

+(void)configNavBackgroundColor:(UIColor *)color{
    navBackgroundColor = color;
    [[UINavigationBar appearance] setBarTintColor:color];
}

+(UIColor *)navBackgroundColor{
    return navBackgroundColor;
}

+(void)configDefaultPreferredStatusBarStyle:(UIStatusBarStyle)statusBarStyle{
    [UINavigationController aspect_hookSelector:@selector(childViewControllerForStatusBarStyle) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UINavigationController *navC = invocation.target;
        UIViewController *vc = navC.visibleViewController;
        [invocation setReturnValue:&vc];
    } error:NULL];
    
    [UIViewController aspect_hookSelector:@selector(preferredStatusBarStyle) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
        UIStatusBarStyle style = statusBarStyle;
        NSInvocation *invocation = info.originalInvocation;
        [invocation setReturnValue:&style];
    } error:NULL];
}

+(void)configNavBarTranslucent:(BOOL)translucent{
    [UINavigationController aspect_hookSelector:@selector(initWithRootViewController:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UINavigationController *navC = invocation.target;
        navC.navigationBar.translucent = translucent;
    } error:NULL];
}

+(void)configViewControllerRectEdgeNoneForExtendedLayout{
    [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UIViewController *vc = invocation.target;
        if (vc.navigationController) {
            vc.edgesForExtendedLayout = UIRectEdgeNone;
        }
    } error:NULL];
}

@end

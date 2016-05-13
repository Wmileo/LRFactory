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

-(id)navSetupLeftBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self.navigationItem setLeftBarButtonItem:barButtonItem];
    return self;
}

-(id)navSetupRightBarButtonItem:(UIBarButtonItem *)barButtonItem{
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    return self;
}

/**
 *  设置按钮nav barbuttonitem
 */
-(id)navSetupLeftButton:(UIButton *)button{
    return [self navSetupLeftBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
}
-(id)navSetupRightButton:(UIButton *)button{
    return [self navSetupRightBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
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
    if (![UIViewController hadConfigTextColorAndFont]) {
        return [self navSetupLeftBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:title action:action]];
    }else{
        return [self navSetupLeftButton:[self buttonSide:BarButtonSideLeft withTitle:title action:action]];
    }
}
-(id)navSetupRightTitle:(NSString *)title action:(void(^)())action{
    if (![UIViewController hadConfigTextColorAndFont]) {
        return [self navSetupLeftBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:title action:action]];
    }else{
        return [self navSetupRightButton:[self buttonSide:BarButtonSideRight withTitle:title action:action]];
    }
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

-(id)navAddLeftBarButtonItem:(UIBarButtonItem *)barButtonItem{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.leftBarButtonItems];
    [arr addObject:barButtonItem];
    [self.navigationItem setLeftBarButtonItems:arr];
    return self;
}

-(id)navAddRightBarButtonItem:(UIBarButtonItem *)barButtonItem{
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.navigationItem.rightBarButtonItems];
    [arr addObject:barButtonItem];
    [self.navigationItem setRightBarButtonItems:arr];
    return self;
}

/**
 *  添加按钮nav barbuttonitem
 */
-(id)navAddLeftButton:(UIButton *)button{
    return [self navAddLeftBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];

}
-(id)navAddRightButton:(UIButton *)button{
    return [self navAddRightBarButtonItem:[UIBarButtonItem barButtonItemWithButton:button]];
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
    if (![UIViewController hadConfigTextColorAndFont]) {
        return [self navAddLeftBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:title action:action]];
    }else{
        return [self navAddLeftButton:[self buttonSide:BarButtonSideLeft withTitle:title action:action]];
    }
}
-(id)navAddRightTitle:(NSString *)title action:(void(^)())action{
    if (![UIViewController hadConfigTextColorAndFont]) {
        return [self navAddRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:title action:action]];
    }else{
        return [self navAddRightButton:[self buttonSide:BarButtonSideRight withTitle:title action:action]];
    }
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

    return [UIButton buttonWithCenter:CGPointZero title:title textColor:color font:font click:action];
}

-(UIButton *)buttonWithImageName:(NSString *)name action:(void(^)())action{
    return [UIButton buttonWithCenter:CGPointZero normalImage:[UIImage imageNamed:name] click:action];
}

#pragma mark - setter getter

static char keyTextColor, keyTextFont, keyHadConfigTextColorAndFont;

+(void)configNavButtonTextColor:(UIColor *)color font:(UIFont *)font{
    objc_setAssociatedObject(self, &keyTextColor, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &keyTextFont, font, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &keyHadConfigTextColorAndFont, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[UINavigationBar appearance] setTintColor:color];
}

+(BOOL)hadConfigTextColorAndFont{
    return [objc_getAssociatedObject(self, &keyHadConfigTextColorAndFont) boolValue];
}

+(UIColor *)navTextColor{
    return objc_getAssociatedObject(self, &keyTextColor);
}

+(UIFont *)navTextFont{
    return objc_getAssociatedObject(self, &keyTextFont);
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

@end

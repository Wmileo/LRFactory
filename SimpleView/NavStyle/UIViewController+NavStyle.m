//
//  UIViewController+NavStyle.m
//  SimpleView
//
//  Created by leo on 2017/4/22.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import "UIViewController+NavStyle.h"
#import "UIViewController+SimpleStatus.h"
#import "UIViewController+BackButtonStyle.h"
#import "UIViewController+NavBackgroundStyle.h"
#import "UIViewController+SimpleNavigation.h"
#import "NSObject+Method.h"

@implementation UIViewController (NavStyle)

static NSDictionary *navStyles;
static NSString *defaultNavStyle;

+(void)configNavStyles:(NSDictionary *)styles{
    navStyles = styles;
}

+(void)configDefaultNavStyle:(NSString *)style{
    defaultNavStyle = style;
    NavStyleModel *model = navStyles[style];
    NSAssert(model, @"请先配置Styles");
    [[UINavigationBar appearance] setTintColor:model.textColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : model.titleColor, NSFontAttributeName : model.textFont}];
    [UIViewController configNavBackgroundColor:nil];
    [UIViewController configNavBackgroundStyle];
    [UIViewController configDefaultPreferredStatusBarStyle:UIStatusBarStyleLightContent statusHidden:NO];
    [UIViewController configDefaultBackItemWithStyle:model.backStyle];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeSEL:@selector(viewDidLoad) withSEL:@selector(NavStyle_viewDidLoad)];
    });
}

-(void)NavStyle_viewDidLoad{
    [self navSetupStyle:defaultNavStyle];
    [self NavStyle_viewDidLoad];
}

-(instancetype)navSetupStyle:(NSString *)style{
    NavStyleModel *model = navStyles[style];
    [self navResetButtonTextColor:model.textColor font:model.textFont];
    [self navResetTitleColor:model.titleColor font:model.titleFont];
    if (self.navigationController.viewControllers.count > 1) {
        [self navSetupBackItemWithStyle:model.backStyle];
    }
    model.Config(self);
    return self;
}

@end


@implementation NavStyleModel

+(NavStyleModel *)modelWithTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont textColor:(UIColor *)textColor textFont:(UIFont *)textFont backStyle:(NSString *)backStyle config:(void (^)(UIViewController *))config{
    NavStyleModel *model = [[NavStyleModel alloc] init];
    model.titleColor = titleColor;
    model.titleFont = titleFont;
    model.textColor = textColor;
    model.textFont = textFont;
    model.backStyle = backStyle;
    model.Config = config;
    return model;
}


@end

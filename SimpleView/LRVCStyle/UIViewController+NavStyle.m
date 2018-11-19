//
//  UIViewController+NavStyle.m
//  SimpleView
//
//  Created by leo on 2017/4/22.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import "UIViewController+NavStyle.h"
#import "UIViewController+BackButtonStyle.h"
#import "LRVCExtend.h"
#import "UIViewController+LRFNavigationTitle.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>
#import "UINavigationController+BackButtonStyle.h"
#import "UIViewController+LRFNavigationButton.h"


@implementation UIViewController (NavStyle)

static NSDictionary *navStyles;
static NSString *defaultNavStyle;

+(void)configNavStyles:(NSDictionary *)styles{
    navStyles = styles;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self lrf_exchangeSEL:@selector(viewDidLoad) withSEL:@selector(NavStyle_viewDidLoad)];
    });
    [UINavigationController configViewControllerSetupDefaultBackButton];
//    [UIViewController configSimpleStatusBar];
}

+(void)configDefaultNavStyle:(NSString *)style{
    defaultNavStyle = style;
    NavStyleModel *model = navStyles[style];
    NSAssert(model, @"请先配置Styles");
    [[UINavigationBar appearance] setTintColor:model.textColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : model.titleColor, NSFontAttributeName : model.textFont}];
    [UIViewController configDefaultBackItemWithStyle:model.backStyle];
}

-(void)NavStyle_viewDidLoad{
    if (self.navStyle) {
        [self navSetupStyle:self.navStyle];
    }else if (defaultNavStyle) {
        [self navSetupStyle:defaultNavStyle];
    }
    [self NavStyle_viewDidLoad];
}

-(instancetype)navSetupStyle:(NSString *)style{
    NavStyleModel *model = navStyles[style];
    self.lrf_navigationItemColor = model.textColor;
    self.lrf_navigationItemFont = model.textFont;
    [self lrf_setupNavigationTitleColor:model.titleColor font:model.titleFont];
    [self navSetupBackItemWithStyle:model.backStyle];
    model.Config(self);
    return self;
}

static char keyNavStyle;

-(NSString *)navStyle{
    return objc_getAssociatedObject(self, &keyNavStyle);
}

-(void)setNavStyle:(NSString *)navStyle{
    objc_setAssociatedObject(self, &keyNavStyle, navStyle, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self navSetupStyle:navStyle];
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

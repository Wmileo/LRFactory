//
//  UIViewController+BackButtonStyle.m
//  SimpleView
//
//  Created by ileo on 16/5/10.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+BackButtonStyle.h"
#import "SimpleViewHeader.h"
#import "NSObject+Block.h"
#import "UIView+Sizes.h"
#import "Aspects.h"

@interface UIViewController() <UIGestureRecognizerDelegate>

@end

@implementation UIViewController (BackButtonStyle)

+(void)configViewControllerGesturePopBack{
    [UINavigationController aspect_hookSelector:@selector(initWithRootViewController:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UINavigationController *navC = invocation.target;
        navC.interactivePopGestureRecognizer.delegate = navC;
    } error:NULL];
    [UINavigationController aspect_hookSelector:@selector(pushViewController:animated:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UINavigationController *navC = invocation.target;
        navC.interactivePopGestureRecognizer.enabled = NO;
    } error:NULL];
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info){
        NSInvocation *invocation = info.originalInvocation;
        UIViewController *vc = invocation.target;
        if (vc.navigationController) {
            vc.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    } error:NULL];
}

static NSDictionary *backItemIdentifications;

+(void)configBackItemIdentifications:(NSDictionary *(^)())identifications{
    backItemIdentifications = identifications();
}

-(instancetype)navSetupBackItemWithIdentification:(NSString *)identification{
    
    [self resetBackItemWithIdentification:identification];
    
    __weak __typeof(self) wself = self;
    [self aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionBefore|AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> info){
        [wself resetBackItemWithIdentification:identification];
    } error:NULL];
    
    return self;
}

-(void)resetBackItemWithIdentification:(NSString *)identification{
    
    BackItemModel *model = backItemIdentifications[identification];

    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:3];
    if (model.offsetX != 0){
        [tmp addObject:[UIBarButtonItem barButtonItemSpaceWithWidth:model.offsetX]];
    }
    
    NSString *title = self.navLastTitle;
    if ([self respondsToSelector:@selector(navBackItemTitle)]) {
        title = [self performSelector:@selector(navBackItemTitle)];
    }
    __weak __typeof(self) wself = self;
    if (model.icon) {
        UIButton *button = [UIButton buttonWithCenter:CGPointZero normalImage:model.icon click:^{
            [wself clickOnBack];
        }];
        if (model.hasTitle) {
            UILabel *label = [[[UILabel labelWithFrame:CGRectMake(button.width + model.titleOffsetX, 0, 80, 50) font:model.titleFont text:title textColor:model.titleColor] labelResetTextAlignment:NSTextAlignmentLeft] setupOnView:button];
            label.centerY = button.height/2;
        }
        [tmp addObject:[UIBarButtonItem barButtonItemWithButton:button]];
    }else if (model.hasTitle) {
        [tmp addObject:[UIBarButtonItem barButtonItemWithButton:[UIButton buttonWithCenter:CGPointZero title:title textColor:model.titleColor font:model.titleFont click:^{
            [wself clickOnBack];
        }]]];
    }
    
    if (tmp.count > 0) {
        [self.navigationItem setLeftBarButtonItems:[tmp copy]];
    }
}

-(void)clickOnBack{
    if ([self respondsToSelector:@selector(navClickOnBackItem)]) {
        [self performSelector:@selector(navClickOnBackItem)];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(NSString *)navLastTitle{
    if (self.navigationController) {
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index > 0) {
            return (self.navigationController.viewControllers[index - 1]).title;
        }
    }
    return nil;
}

#pragma mark - 右滑返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self isKindOfClass:[UINavigationController class]]) {
        UIViewController *vc = ((UINavigationController *)self).visibleViewController;
        if ([vc respondsToSelector:@selector(viewControllerShouldGesturePopBack)]) {
            return (BOOL)[vc performSelector:@selector(viewControllerShouldGesturePopBack)];
        }
        return ((UINavigationController *)self).viewControllers.count != 1;
    }
    return NO;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

@end


@implementation BackItemModel

+(BackItemModel *)modelWithOffsetX:(CGFloat)offsetX icon:(UIImage *)icon titleOffsetX:(CGFloat)titleOffsetX titleColor:(UIColor *)color titleFont:(UIFont *)font{
    BackItemModel *model = [[BackItemModel alloc] init];
    model.offsetX = offsetX;
    model.icon = icon;
    model.titleOffsetX = titleOffsetX;
    model.titleColor = color;
    model.titleFont = font;
    model.hasTitle = YES;
    return model;
}

+(BackItemModel *)modelWithOffsetX:(CGFloat)offsetX icon:(UIImage *)icon{
    BackItemModel *model = [[BackItemModel alloc] init];
    model.offsetX = offsetX;
    model.icon = icon;
    model.hasTitle = NO;
    return model;
}

@end

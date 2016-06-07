//
//  UIViewController+SimplePresent.m
//  SimpleView
//
//  Created by ileo on 16/6/3.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+SimplePresent.h"
#import <objc/runtime.h>

@implementation UIViewController (SimplePresent)

static char keyPresentWillDismissBlock;
static char keyPresentDidDismissBlock;
static char keyPresenterViewController;

-(instancetype)resetModalTransitionStyle:(UIModalTransitionStyle)style{
    self.modalTransitionStyle = style;
    return self;
}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion willDismissCallback:(PresentBlock)willDismissCallback didDismissCallback:(PresentBlock)didDismissCallback{
    objc_setAssociatedObject(self, &keyPresentWillDismissBlock, willDismissCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &keyPresentDidDismissBlock, didDismissCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIViewController *viewController = viewControllerToPresent;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        viewController = ((UINavigationController *) viewControllerToPresent).topViewController;
    }
    objc_setAssociatedObject(viewController, &keyPresenterViewController, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion success:(BOOL)success info:(id)info{
    __weak __typeof(self) wself = self;
    UIViewController *presenterViewController = objc_getAssociatedObject(wself, &keyPresenterViewController);
    PresentBlock willDismissBlock = (PresentBlock)objc_getAssociatedObject(presenterViewController, &keyPresentWillDismissBlock);
    PresentBlock didDismissBlock = (PresentBlock)objc_getAssociatedObject(presenterViewController, &keyPresentDidDismissBlock);
    if (willDismissBlock) {
        willDismissBlock(success,info);
    }
    [self dismissViewControllerAnimated:flag completion:^{
        if (completion) {
            completion();
        }
        if (didDismissBlock) {
            didDismissBlock(success,info);
        }
    }];
}

@end

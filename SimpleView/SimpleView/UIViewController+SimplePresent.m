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

static char keyPresentBlock;
static char keyPresenterViewController;

-(instancetype)resetModalTransitionStyle:(UIModalTransitionStyle)style{
    self.modalTransitionStyle = style;
    return self;
}

-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion callback:(PresentBlock)callback{
    objc_setAssociatedObject(self, &keyPresentBlock, callback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    UIViewController *viewController = viewControllerToPresent;
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        viewController = ((UINavigationController *) viewControllerToPresent).topViewController;
    }
    objc_setAssociatedObject(viewController, &keyPresenterViewController, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion success:(BOOL)success info:(id)info{
    __weak __typeof(self) wself = self;
    [self dismissViewControllerAnimated:flag completion:^{
        if (completion) {
            completion();
        }
        UIViewController *presenterViewController = objc_getAssociatedObject(wself, &keyPresenterViewController);
        PresentBlock block = (PresentBlock)objc_getAssociatedObject(presenterViewController, &keyPresentBlock);
        if (block) {
            block(flag,info);
        }
    }];
}

@end

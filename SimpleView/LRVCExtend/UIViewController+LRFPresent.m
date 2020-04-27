//
//  UIViewController+LRFPresent.m
//  SimpleView
//
//  Created by ileo on 16/6/3.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+LRFPresent.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>

@implementation UIViewController (LRFPresent)

+(void)load{
    [UIViewController lrf_injectPresent];
}

static char keyPresentWillDismissBlock;
static char keyPresentDidDismissBlock;

- (void)lrf_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion willDismissCallback:(void (^)(NSDictionary *))willDismissCallback didDismissCallback:(void (^)(NSDictionary *))didDismissCallback{
    objc_setAssociatedObject(self, &keyPresentWillDismissBlock, willDismissCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &keyPresentDidDismissBlock, didDismissCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)lrf_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion info:(NSDictionary *)info{
    UIViewController *vc = self.presentingViewController;
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = ((UINavigationController *)vc).visibleViewController;
    }
    void (^WillDismissBlock)(NSDictionary *) = objc_getAssociatedObject(vc, &keyPresentWillDismissBlock);
    void (^DidDismissBlock)(NSDictionary *) = objc_getAssociatedObject(vc, &keyPresentDidDismissBlock);
    if (WillDismissBlock) {
        WillDismissBlock(info);
    }
    [self dismissViewControllerAnimated:flag completion:^{
        if (completion) {
            completion();
        }
        if (DidDismissBlock) {
            DidDismissBlock(info);
        }
    }];
}

+ (void)lrf_injectPresent{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_exchangeSEL:@selector(presentViewController:animated:completion:) withSEL:@selector(LRFPresent_presentViewController:animated:completion:)];
    });
}

#pragma mark -

static char keyViewControllerByPresent;
-(UIViewController *)lrf_viewControllerByPresent{
    return [self lrf_getAssociatedObjectWithKey:&keyViewControllerByPresent];
}

-(void)LRFPresent_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    [viewControllerToPresent lrf_setWeakAssociatedObject:self withKey:&keyViewControllerByPresent];
    [self LRFPresent_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end

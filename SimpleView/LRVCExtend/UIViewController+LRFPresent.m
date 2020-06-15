//
//  UIViewController+LRFPresent.m
//  SimpleView
//
//  Created by ileo on 16/6/3.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIViewController+LRFPresent.h"
#import "NSObject+LRFactory.h"

@implementation UIViewController (LRFPresent)

+(void)load{
    [UIViewController lrf_injectPresent];
}

+ (void)lrf_injectPresent{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_exchangeSEL:@selector(dismissViewControllerAnimated:completion:) withSEL:@selector(LRFPresent_dismissViewControllerAnimated:completion:)];
    });
}

static char keyPresentWillDismissBlock;
static char keyPresentDidDismissBlock;

- (void)lrf_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ __nullable)(void))completion willDismissCallback:(void (^ __nullable)(id _Nullable))willDismissCallback didDismissCallback:(void (^ __nullable)(id _Nullable))didDismissCallback{
    [self lrf_setCopyAssociatedObject:willDismissCallback withKeyPoint:&keyPresentWillDismissBlock];
    [self lrf_setCopyAssociatedObject:didDismissCallback withKeyPoint:&keyPresentDidDismissBlock];
    [self presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)lrf_dismissViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion info:(id _Nullable)info{
    UIViewController *vc = self.presentingViewController;
    if (!vc) {
        return;
    }
    if ([vc isKindOfClass:[UINavigationController class]]) {
        vc = ((UINavigationController *)vc).visibleViewController;
    }
    void (^WillDismissBlock)(id _Nullable) = [vc lrf_getAssociatedObjectWithKeyPoint:&keyPresentWillDismissBlock];
    void (^DidDismissBlock)(id _Nullable) = [vc lrf_getAssociatedObjectWithKeyPoint:&keyPresentDidDismissBlock];
    if (WillDismissBlock) {
        WillDismissBlock(info);
    }
    [self LRFPresent_dismissViewControllerAnimated:flag completion:^{
        if (completion) {
            completion();
        }
        if (DidDismissBlock) {
            DidDismissBlock(info);
        }
    }];
}

- (void)LRFPresent_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self lrf_dismissViewControllerAnimated:flag completion:completion info:nil];
}

//static char keyViewControllerByPresent;
//- (UIViewController * _Nullable)lrf_viewControllerByPresent{
//    return [self lrf_getAssociatedObjectWithKeyAdr:&keyViewControllerByPresent];
//}
//
//-(void)LRFPresent_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ __nullable)(void))completion{
//    [viewControllerToPresent lrf_setWeakAssociatedObject:self withKey:&keyViewControllerByPresent];
//    [self LRFPresent_presentViewController:viewControllerToPresent animated:flag completion:completion];
//}

@end

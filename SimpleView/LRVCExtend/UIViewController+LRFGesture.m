//
//  UIViewController+LRFGesture.m
//  SimpleView
//
//  Created by leo on 2018/11/12.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIViewController+LRFGesture.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>

@interface UIViewController ()

@end

@interface UINavigationController (LRFGesture) <UIGestureRecognizerDelegate>

+(void)lrf_injectNavGesture;

@end

@implementation UIViewController (LRFGesture)

+(void)load{
    [UIViewController lrf_injectGesture];
}

+(void)lrf_injectGesture{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_injectNavGesture];
        [UIViewController lrf_exchangeSEL:@selector(viewDidAppear:) withSEL:@selector(LRFGesture_viewDidAppear:)];
    });
}

-(void)LRFGesture_viewDidAppear:(BOOL)animated{
    [self LRFGesture_viewDidAppear:animated];
    if (self.navigationController) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - set get

static char keyCanGesturePop;

- (void)setLrf_canGesturePop:(BOOL)lrf_canGesturePop{
    objc_setAssociatedObject(self, &keyCanGesturePop, @(lrf_canGesturePop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)lrf_canGesturePop{
    if (objc_getAssociatedObject(self, &keyCanGesturePop)) {
        return [objc_getAssociatedObject(self, &keyCanGesturePop) boolValue];
    }else{
        return YES;
    }
}

@end

@implementation UINavigationController (LRFGesture)

+(void)lrf_injectNavGesture{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UINavigationController lrf_exchangeSEL:@selector(pushViewController:animated:) withSEL:@selector(LRFGesture_pushViewController:animated:)];
    });
}

-(void)LRFGesture_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count == 1) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
    self.interactivePopGestureRecognizer.enabled = NO;
    [self LRFGesture_pushViewController:viewController animated:animated];
}

#pragma mark - 右滑返回
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.viewControllers.count == 1) {
        return NO;
    }else{
        UIViewController *vc = self.visibleViewController;
        return vc.lrf_canGesturePop;
    }
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

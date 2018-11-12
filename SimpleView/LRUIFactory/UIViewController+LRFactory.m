//
//  UIViewController+LRFactory.m
//  SimpleView
//
//  Created by leo on 2017/3/31.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import "UIViewController+LRFactory.h"
#import "NSObject+LRFactory.h"
#import <objc/runtime.h>
#import "UINavigationController+LRFactory.h"

@implementation UIViewController (LRFactory)

-(UIViewController *)navLastViewController{
    if ([self.navigationController.viewControllers containsObject:self]) {
        NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
        if (index > 0) {
            return self.navigationController.viewControllers[index - 1];
        }
    }else if (self.navigationController.viewControllers.count > 0) {
        return [self.navigationController.viewControllers lastObject];
    }
    return nil;
}

-(UIViewController *)navNextViewController{
    if ([self.navigationController.viewControllers containsObject:self]) {
        NSUInteger index = [self.navigationController.viewControllers indexOfObject:self];
        index++;
        if (index < self.navigationController.viewControllers.count) {
            return self.navigationController.viewControllers[index];
        }
    }
    return nil;
}

@end

//
//  UINavigationController+SimpleFactory.h
//  SimpleView
//
//  Created by ileo on 16/5/6.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (SimpleFactory)

+(UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)viewController;

-(UINavigationController *)navigationControllerRemoveBackgroundView;

@end

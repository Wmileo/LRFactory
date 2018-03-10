//
//  UIViewController+SimpleFactory.h
//  SimpleView
//
//  Created by leo on 2017/3/31.
//  Copyright © 2017年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SimpleFactory)

+(void)configSimple;

+(UIViewController *)currentViewController;

+(UIWindow *)mainWindow;

-(UIViewController *)navLastViewController;//导航的上一个页面
-(UIViewController *)navNextViewController;//导航的下一个页面

-(void)viewDidDisappearForever;
-(void)viewWillDisappearForever:(BOOL)animated;

@end

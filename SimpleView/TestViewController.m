//
//  TestViewController.m
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "TestViewController.h"
#import "UIViewController+SimpleNavigation.h"
#import "SimpleView/SimpleViewHeader.h"
#import "UIViewController+BackButtonStyle.h"
#import "UIViewController+NavBackgroundStyle.h"



@interface TestViewController () <UIViewControllerBackButtonDataSource, UIViewControllerNavBackgroundDataSource>

@end

@implementation TestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    [self navResetTitleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:20]];
    self.title = @"aaa";
    self.view.backgroundColor = [UIColor whiteColor];
    [[[UIButton buttonEmptyWithFrame:CGRectMake(0, 0, 100, 100) click:^{
        NSLog(@"click");
    }] resetBackgroundColor:[UIColor yellowColor]] setupOnView:self.view];
    
    [self navSetupBackItemWithIdentification:@"back"];
    
}

//-(BOOL)viewControllerShouldGesturePopBack{
//    return NO;
//}

-(UIColor *)navBackgroundColor{
    return [UIColor blueColor];
}

@end

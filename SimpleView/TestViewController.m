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
#import "ViewController.h"
#import "UIViewController+SimplePresent.h"
#import "TableViewController.h"
#import "UIViewController+NavStyle.h"

@interface TestViewController () <UIViewControllerBackButtonDataSource>

@end

@implementation TestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
       self.title = @"aaa";


    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navBackgroundColor = [UIColor whiteColor];
    
    [[[[[UIButton buttonEmptyWithFrame:CGRectMake(50, 100, 100, 100) click:^{
        NSLog(@"click");
        
    }] resetBackgroundColor:[UIColor blueColor]] setupOnView:self.view] resetCornerRadius:11] resetConfig:^(UIButton *ui) {
        ui.backgroundColor = [UIColor yellowColor];
    }];
    
    
    [self navSetupRightTitle:@"table" action:^{
    }];

//    self.navigationBarHidden = YES;
//    self.statusBarHidden = YES;
    
    
//    [self navSetupStyle:@"bababa"];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

//-(BOOL)viewControllerShouldGesturePopBack{
//    return NO;
//}

//-(UIColor *)navBackgroundColor{
//    return [UIColor grayColor];
//}

//-(NSString *)navBackItemTitle{
//    return @"返回";
//}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}


-(void)viewDidBePopped{
    NSLog(@"pop");

}

@end

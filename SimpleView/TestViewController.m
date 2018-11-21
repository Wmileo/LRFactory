//
//  TestViewController.m
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "TestViewController.h"
#import "LRUIFactory.h"
#import "LRVCExtend.h"
#import "LRVCStyle.h"
#import "ViewController.h"
#import "TableViewController.h"
#import "LRFactory.h"
#import "UIImageView+LRFactory.h"

@interface TestViewController ()

@end

@implementation TestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"aaa";
    self.lrf_statusBarHidden = NO;
    self.view.backgroundColor = [UIColor blueColor];
    self.lrf_navigationBarTintColor = [UIColor yellowColor];
    
    UIButton *b = [UIButton lrf_viewWithFrame:CGRectMake(50, 100, 100, 100)];
    [b lrf_handleEventTouchUpInsideBlock:^{
        NSLog(@"click");
        TableViewController *vc = [[TableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    b.backgroundColor = [UIColor blueColor];
    [self.view addSubview:b];
    [b lrf_showDebugFrame];

    [self lrf_setupNavigationItemWithText:@"table" side:LRF_BarButtonItem_Side_Right action:^{
        NSLog(@"table");
    }];
    
//    self.lrf_statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear_lrfByForever:(BOOL)animated{
    
}

-(void)viewWillAppear_lrfByFirstTime:(BOOL)animated{
    
}

-(void)viewDidBePopped{
    NSLog(@"pop");

}

@end

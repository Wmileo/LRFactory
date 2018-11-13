//
//  TestViewController.m
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "TestViewController.h"
#import "UIViewController+SimpleNavigation.h"
#import "LRUIFactory.h"
#import "LRUIExtend.h"
#import "UIViewController+BackButtonStyle.h"
#import "UIViewController+NavBackgroundStyle.h"
#import "ViewController.h"
#import "TableViewController.h"
#import "UIViewController+NavStyle.h"
#import "LRFactory.h"
#import "UIImageView+LRFactory.h"

@interface TestViewController () <UIViewControllerBackButtonDataSource>

@end

@implementation TestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"aaa";

    self.view.backgroundColor = [UIColor blueColor];
    self.navBackgroundColor = [UIColor redColor];
//    [[[UIView viewWithFrame:CGRectMake(0, -64, 320, 480)] setupOnView:self.view] resetBackgroundColor:[UIColor blackColor]];
    
    UIButton *b = [UIButton lrf_viewWithFrame:CGRectMake(50, 100, 100, 100)];
    [b lrf_handleEventTouchUpInsideBlock:^{
        NSLog(@"click");
        TableViewController *vc = [[TableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    b.backgroundColor = [UIColor blueColor];
    [self.view addSubview:b];
    [b lrf_showDebugFrame];
    
    [self navSetupRightTitle:@"table" action:^{
    }];

//    self.navBackgroundTranslucent = YES;
    
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

-(void)viewWillDisappear_lrfByForever:(BOOL)animated{
    
}

-(void)viewWillAppear_lrfByFirstTime:(BOOL)animated{
    
}


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

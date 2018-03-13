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
#import "SimpleHeader.h"
#import "UIImageView+SimpleFactory.h"

@interface TestViewController () <UIViewControllerBackButtonDataSource>

@end

@implementation TestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"aaa";

    self.view.backgroundColor = [UIColor blueColor];
    self.navBackgroundColor = [UIColor redColor];
//    [[[UIView viewWithFrame:CGRectMake(0, -64, 320, 480)] setupOnView:self.view] resetBackgroundColor:[UIColor blackColor]];
    
    [[[[[UIButton buttonEmptyWithFrame:CGRectMake(50, 100, 100, 100) click:^{
        NSLog(@"click");
        TableViewController *vc = [[TableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }] resetBackgroundColor:[UIColor blueColor]] setupOnView:self.view] resetCornerRadius:11] resetConfig:^(UIButton *ui) {
        ui.backgroundColor = [UIColor yellowColor];
    }];
    
    
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

-(void)viewWillDisappearForever:(BOOL)animated{
    
}

-(void)viewWillAppearFirstTime:(BOOL)animated{
    
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

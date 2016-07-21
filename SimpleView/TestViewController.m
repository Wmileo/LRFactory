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

@interface TestViewController () <UIViewControllerBackButtonDataSource, UIViewControllerNavBackgroundDataSource>

@end

@implementation TestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
       self.title = @"aaa";
    [self navResetTitleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:20]];

    self.view.backgroundColor = [UIColor whiteColor];
    [[[[[UIButton buttonEmptyWithFrame:CGRectMake(50, 100, 100, 100) click:^{
        NSLog(@"click");
    }] resetBackgroundColor:[UIColor blueColor]] setupOnView:self.view] resetCornerRadius:11] resetConfig:^(UIButton *ui) {
        ui.backgroundColor = [UIColor yellowColor];
    }];
    
    [self navAddLeftSpaceWithWidth:50];
    __weak __typeof(self) wself = self;
    [self navSetupRightTitle:@"ABC" action:^{
        [wself.navigationController pushViewController:[[ViewController alloc] init] animated:YES];

//        [wself dismissViewControllerAnimated:YES completion:nil success:NO info:@{@"info":@"aaaa"}];
        
    }];
    
//    [self navSetupBackItemWithIdentification:@"back" action:^{
//        NSLog(@"逗你");
//    }];

}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIView viewWithFrame:CGRectMake(50, 50, 50, 50)] setupOnView:self.view];
//    [self navSetupLeftTitle:@"---" action:nil];

}
//
//-(BOOL)viewControllerShouldGesturePopBack{
//    return NO;
//}

-(UIColor *)navBackgroundColor{
    return [UIColor grayColor];
}

//-(NSString *)navBackItemTitle{
//    return @"返回";
//}

@end

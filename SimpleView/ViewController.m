//
//  ViewController.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "ViewController.h"
#import "SimpleViewHeader.h"
#import "TestViewController.h"

@interface ViewController () <UIViewControllerNavigationDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];

//    [self navResetTitleColor:[UIColor blueColor] font:[UIFont systemFontOfSize:40]];
    self.title = @"test";
//    [self navSetupLeftTitle:@"aaa" action:^{
//        NSLog(@"aa");
//    }];
//    [self navSetup LeftSpaceWithWidth:-30];
//    [self navAddLeftSpaceWithWidth:-100];
    
    [self navAddLeftTitle:@"cc" action:^{
        NSLog(@"cc");
        [[[UIButton buttonEmptyWithFrame:CGRectMake(50, 50, 50, 50) click:nil] setupOnView:self.view] resetBackgroundColor:[UIColor whiteColor]];

    }];
    
    [self navSetupRightSpaceWithWidth:10];
    __weak __typeof(self) wself = self;
    [self navAddRightTitle:@"bb" action:^{
        [wself.navigationController pushViewController:[[TestViewController alloc] init] animated:YES];
    }];
    

    
    // Do any additional setup after loading the view, typically from a nib.
}

-(UIFont *)navBarButtonItemLeftTextFont{
    return [UIFont systemFontOfSize:50];
}

-(UIColor *)navBarButtonItemLeftTextColor{
    return [UIColor orangeColor];
}

//-(UIFont *)navBarButtonItemRightTextFont{
//    return [UIFont systemFontOfSize:40];
//}
//
//-(UIColor *)navBarButtonItemRightTextColor{
//    return [UIColor grayColor];
//}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+SimpleNavigation.h"

@interface ViewController () <UIViewControllerNavigationDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
//    [self navSetupLeftTitle:@"aaa" action:^{
//        NSLog(@"aa");
//    }];
//    [self navSetup LeftSpaceWithWidth:-30];
//    [self navAddLeftSpaceWithWidth:-100];
    
    [self navAddLeftTitle:@"cc" action:^{
        NSLog(@"cc");
    }];
    
    [self navSetupRightSpaceWithWidth:100];
    [self navAddRightTitle:@"bb" action:^{
        NSLog(@"bb");
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

+(UIColor *)navBarButtonItemLeftTextColor{
    return [UIColor orangeColor];
}

+(UIFont *)navBarButtonItemLeftTextFont{
    return [UIFont systemFontOfSize:50];
}

+(UIFont *)navBarButtonItemRightTextFont{
    return [UIFont systemFontOfSize:40];
}

+(UIColor *)navBarButtonItemRightTextColor{
    return [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

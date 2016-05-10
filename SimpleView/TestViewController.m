//
//  TestViewController.m
//  SimpleView
//
//  Created by ileo on 16/5/5.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "TestViewController.h"
#import "UIViewController+SimpleNavigation.h"

@implementation TestViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    [self navResetTitleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:20]];
    self.title = @"aaa";
    self.view.backgroundColor = [UIColor whiteColor];
}

@end

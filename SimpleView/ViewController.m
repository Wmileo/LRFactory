//
//  ViewController.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "ViewController.h"
#import "LRUIFactory.h"
#import "LRVCExtend.h"
#import "LRFactory.h"
#import "LRVCStyle.h"

@interface ViewController () <UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self navSetupStyle:@"lalala"];
    
    self.lrf_navigationBarTintColor = [UIColor orangeColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.lrf_navigationBarHidden = NO;
    self.lrf_statusBarHidden = YES;
    
    self.lrf_navigationBarShadowImage = [[UIImage alloc] init];
    UIView *v = [UIView lrf_viewWithFrame:CGRectMake(0, -64, 320, 64)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
//    [self navResetTitleColor:[UIColor blueColor] font:[UIFont systemFontOfSize:40]];
    self.title = @"testaaaaaaaaaaaaaaaaaa";
    
    NSMutableParagraphStyle *p = [[NSMutableParagraphStyle alloc] init];
    p.lineBreakMode = NSLineBreakByTruncatingHead;
    p.alignment = NSTextAlignmentJustified;
    
    NSAttributedString *att = [[[[[NSAttributedString lrf_attributedStringWithText:@"aaaaaaaaaa"] lrf_copyAttributedStringWithFont:[UIFont systemFontOfSize:14]] lrf_copyAttributedStringWithColor:[UIColor blueColor]] lrf_copyAttributedStringWithUnderLineWithColor:[UIColor blueColor]] lrf_copyAttributedStringWithLink:@"aaa"];
    NSAttributedString *att1 = [NSAttributedString lrf_attributedStringWithLineFeedSize:10];
    NSAttributedString *att2 = [[[NSAttributedString lrf_attributedStringWithText:@"bbbbbbb"] lrf_copyAttributedStringWithFont:[UIFont systemFontOfSize:19]] lrf_copyAttributedStringWithColor:[UIColor redColor]];
    NSAttributedString *att3 = [[[[[[NSAttributedString lrf_attributedStringWithText:@"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"] lrf_copyAttributedStringWithFont:[UIFont systemFontOfSize:8]] lrf_copyAttributedStringWithColor:[UIColor grayColor]] lrf_copyAttributedStringWithParagraphStyle:p] lrf_copyAttributedStringWithLineSpacing:17] lrf_copyAttributedStringWithFirstLineHeadIndent:50];
    
    UILabel *label = [UILabel lrf_viewWithFrame:CGRectMake(50, 100, 200, 200)];
    [label lrf_showDebugFrame];
    [self.view addSubview:label];
    label.attributedText = [NSAttributedString lrf_attributedStringWithAttributedStrings:@[att3,[NSAttributedString lrf_attributedStringWithLineFeedSize:1],att,att1,att2,att3]];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentLeft;
    label.lrf_height = label.attributedText.size.height;
    
    
    UITextView *text = [UITextView lrf_viewWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.view addSubview:text];
    
    text.attributedText = att;
    text.editable = NO;
    text.delegate = self;
    
    UIImageView *iv = [UIImageView lrf_view];
    [iv lrf_setupFixedType:LRF_Fixed_CenterX_CenterY point:self.view.lrf_boundsCenter];
    [iv lrf_setupImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo_top_86d58ae1.png"]]] fitSize:YES];
    [self.view addSubview:iv];
    
    [self lrf_setupNavigationItemWithImage:[UIImage imageNamed:@"back"] side:LRF_BarButtonItem_Side_Left action:^{
        NSLog(@"aaa");
    }];
    

    [self lrf_setupNavigationItemWithSpace:10 side:LRF_BarButtonItem_Side_Right];
    __weak __typeof(self) wself = self;
    
    [self lrf_addNavigationItemWithText:@"bb" side:LRF_BarButtonItem_Side_Right action:^{
        ViewController *test = [[ViewController alloc] init];
        //        test.statusHide = YES;
        test.lrf_navigationBarTintColor = [UIColor redColor];
        test.lrf_navigationBarShadowImage = nil;
        //        [test navSetupBackItemWithIdentification:@"back"];
        [wself.navigationController pushViewController:test animated:YES];
    }];
    


    self.lrf_statusBarStyle = UIStatusBarStyleDefault;
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self navSetupLeftTitle:@"___" action:nil];
    
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    return YES;
}

//-(UIFont *)navBarButtonItemLeftTextFont{
//    return [UIFont systemFontOfSize:50];
//}
//
//-(UIColor *)navBarButtonItemLeftTextColor{
//    return [UIColor orangeColor];
//}

//-(UIFont *)navBarButtonItemRightTextFont{
//    return [UIFont systemFontOfSize:40];
//}
//
//-(UIColor *)navBarButtonItemRightTextColor{
//    return [UIColor grayColor];
//}

//-(UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

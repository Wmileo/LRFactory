//
//  ViewController.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "ViewController.h"
#import "LRUIFactory.h"
#import "LRUIExtend.h"
#import "LRFactory.h"
#import "TestViewController.h"
#import "UIViewController+BackButtonStyle.h"
#import "UIViewController+NavBackgroundStyle.h"
#import "UIViewController+NavStyle.h"

@interface ViewController () <UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self navSetupStyle:@"lalala"];
    
    self.navBackgroundColor = [UIColor yellowColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navBarHidden                                                                                                                                                                                                                                          = NO;
//    self.statusHide = YES;
    
    self.navShadowImage = [[UIImage alloc] init];
    UIView *v = [UIView lrf_viewWithFrame:CGRectMake(0, -64, 320, 64)];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
//    [self navResetTitleColor:[UIColor blueColor] font:[UIFont systemFontOfSize:40]];
    self.title = @"testaaaaaaaaaaaaaaaaaa";
    [self navResetTitleColor:[UIColor redColor] font:[UIFont systemFontOfSize:20]];
    
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
    [iv lrf_setupFixedType:Fixed_CenterX_CenterY point:self.view.lrf_boundsCenter];
    [iv lrf_setupImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo_top_86d58ae1.png"]]] fitSize:YES];
    [self.view addSubview:iv];
    
//    [self navSetupRightTitle:@"SAAA" action:^{
//        NSLog(@"aa");
//    }];
    
//    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"NNN" style:UIBarButtonItemStylePlain target:nil action:nil];
//    UIBarButtonItem *barButtonItemR = [[UIBarButtonItem alloc] initWithTitle:@"N制作NN" style:UIBarButtonItemStyleBordered target:nil action:nil];
//
//    [self.navigationItem setLeftBarButtonItem:barButtonItem];
//    [self.navigationItem setRightBarButtonItem:barButtonItemR];

//    [self navSetup LeftSpaceWithWidth:-30];
//    [self navAddLeftSpaceWithWidth:-100];
    
//    [self navAddLeftTitle:@"cc" action:^{
//        NSLog(@"cc");
//        [[[UIButton buttonEmptyWithFrame:CGRectMake(50, 50, 50, 50) click:nil] setupOnView:self.view] resetBackgroundColor:[UIColor whiteColor]];
//
//    }];
    
    [self navSetupRightSpaceWithWidth:10];
    __weak __typeof(self) wself = self;
    [self navAddRightTitle:@"bb" action:^{
        
        NSLog(@"%@\n%@",wself.navLeftViews,wself.navRightViews);
        
        
        TestViewController *test = [[TestViewController alloc] init];
//        test.statusHide = YES;
        test.navBackgroundColor = [UIColor redColor];
        test.navShadowImage = nil;
//        [test navSetupBackItemWithIdentification:@"back"];
        [wself.navigationController pushViewController:test animated:YES];
        
//        [wself presentViewController:[UINavigationController navigationControllerWithRootViewController:test] animated:YES completion:nil willDismissCallback:^(BOOL success, id info) {
//            NSLog(@"%zd - %@",success,info);
//        } didDismissCallback:^(BOOL success, id info) {
//            NSLog(@"%zd - %@",success,info);
//        }];
    }];


//    [self navSetupBackItemWithIdentification:@"back"];
    
//    [self navSetupLeftButton:[UIButton buttonWithCenter:CGPointZero title:@"啊哈哈哈" textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:10] click:^{
//        
//    }]];

    self.lrf_statusBarStyle = UIStatusBarStyleDefault;
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
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

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

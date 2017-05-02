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
#import "UIViewController+BackButtonStyle.h"
#import "UIViewController+SimplePresent.h"
#import "UIView+Sizes.h"
#import "UIViewController+NavBackgroundStyle.h"
#import "UIViewController+NavStyle.h"

@interface ViewController () <UITextViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    [self navSetupStyle:@"lalala"];
    
    self.navBackgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBarHidden = NO;
//    self.statusHide = YES;
    
    self.navShadowImage = [[UIImage alloc] init];
    
    [[[UIView viewWithFrame:CGRectMake(0, -64, 320, 64)] resetBackgroundColor:[UIColor whiteColor]] setupOnView:self.view];

//    [self navResetTitleColor:[UIColor blueColor] font:[UIFont systemFontOfSize:40]];
    self.title = @"testaaaaaaaaaaaaaaaaaa";
    [self navResetTitleColor:[UIColor redColor] font:[UIFont systemFontOfSize:20]];
    
    NSMutableParagraphStyle *p = [[NSMutableParagraphStyle alloc] init];
    p.lineBreakMode = NSLineBreakByTruncatingHead;
    p.alignment = NSTextAlignmentJustified;
    
    NSAttributedString *att = [[[[[NSAttributedString attributedStringWithText:@"aaaaaaaaaa"] copyAttributedStringWithFont:[UIFont systemFontOfSize:14]] copyAttributedStringWithColor:[UIColor blueColor]] copyAttributedStringWithUnderLineWithColor:[UIColor blueColor]] copyAttributedStringWithLink:@"aaa"];
    NSAttributedString *att1 = [NSAttributedString attributedStringWithLineFeedSize:10];
    NSAttributedString *att2 = [[[NSAttributedString attributedStringWithText:@"bbbbbbb"] copyAttributedStringWithFont:[UIFont systemFontOfSize:19]] copyAttributedStringWithColor:[UIColor redColor]];
    NSAttributedString *att3 = [[[[[[NSAttributedString attributedStringWithText:@"cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc"] copyAttributedStringWithFont:[UIFont systemFontOfSize:8]] copyAttributedStringWithColor:[UIColor grayColor]] copyAttributedStringWithParagraphStyle:p] copyAttributedStringWithLineSpacing:17] copyAttributedStringWithFirstLineHeadIndent:50];
    
    UILabel *label = [[[[[[UILabel viewWithFrame:CGRectMake(50, 100, 200, 200)] labelResetAttributedText:[NSAttributedString attributedStringWithAttributedStrings:@[att3,[NSAttributedString attributedStringWithLineFeedSize:1],att,att1,att2,att3]]] setupOnView:self.view] labelResetNumberOfLines:0] labelResetTextAlignment:NSTextAlignmentLeft] showDebugFrame];
    
    label.height = label.attributedText.size.height;
    
    
    UITextView *text = [[UITextView viewWithFrame:CGRectMake(0, 0, 100, 100)] setupOnView:self.view];
    text.attributedText = att;
    text.editable = NO;
    text.delegate = self;
    
    
    [[UIImageView imageViewWithCenter:self.view.center image:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://s.qianbaocard.com/file/images.do?name=201612/02/58412bd866ea9_small.png&date=1480997107265"]]]] setupOnView:self.view];
    
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

    self.statusBarStyle = UIStatusBarStyleDefault;
    
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

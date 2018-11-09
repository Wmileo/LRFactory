//
//  AppDelegate.m
//  SimpleView
//
//  Created by ileo on 16/4/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "AppDelegate.h"
#import "LRUIFactory.h"
#import "ViewController.h"
#import "TestViewController.h"
#import "LRUIExtend.h"
#import "UIViewController+BackButtonStyle.h"
#import "UIViewController+NavBackgroundStyle.h"
#import "UINavigationController+SimpleFactory.h"
#import "UIViewController+NavStyle.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UINavigationController configNavigationAction];
//    [UIViewController configViewControllerRectEdgeNoneForExtendedLayout];
    [UIViewController configNavBackgroundColor:[UIColor yellowColor]];
//    [UIViewController configViewControllerGesturePopBack];
//    [UIViewController configNavBackgroundStyle];
    [UIViewController configBackItemStyles:@{
                                                      @"back":[BackItemModel modelWithOffsetX:-10 icon:[UIImage imageNamed:@"back"] titleOffsetX:0 titleColor:[UIColor blueColor] titleFont:[UIFont systemFontOfSize:20]]}];
    [UIViewController configDefaultBackItemWithStyle:@"back"];
    
    
    [UIViewController configNavStyles:
  @{@"lalala" : [NavStyleModel modelWithTitleColor:[UIColor redColor] titleFont:[UIFont systemFontOfSize:20] textColor:[UIColor redColor] textFont:[UIFont systemFontOfSize:20] backStyle:@"back" config:^(UIViewController *vc) {
        vc.navShadowImage = [[UIImage alloc] init];
    }],
    @"bababa" : [NavStyleModel modelWithTitleColor:[UIColor blueColor] titleFont:[UIFont systemFontOfSize:10] textColor:[UIColor blueColor] textFont:[UIFont systemFontOfSize:10] backStyle:@"back" config:^(UIViewController *vc) {
        
        vc.navShadowImage = nil;
    }]
                                        
    }];
    
//    [UIViewController configDefaultNavStyle:@"bababa"];
    
    
    [UIViewController lrf_configDefaultStatusBarStyle:UIStatusBarStyleLightContent statusHidden:NO];
    
    [UIViewController configViewControllerGesturePopBack];
    [UIViewController configViewControllerRectEdgeNoneForExtendedLayout];
    [UIViewController configNavBackgroundStyle];
    [UIViewController configSimple];

    [UIViewController autoHidesBottomBarWhenPush];

    [[UINavigationBar appearance] setShadowImage:nil];
    
    
    
    
    
    
    
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    UINavigationController *nav = [UINavigationController navigationControllerWithRootViewController:[[ViewController alloc] init]];
    
    tab.viewControllers = @[nav,[UINavigationController navigationControllerWithRootViewController:[[TestViewController alloc] init]]];
    
    self.window.rootViewController = tab;
    
//    [UIViewController configDefaultPreferredStatusBarStyle:UIStatusBarStyleDefault statusHidden:NO];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

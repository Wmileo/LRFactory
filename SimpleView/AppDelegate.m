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
#import "LRVCExtend.h"
#import "LRVCStyle.h"
#import "UINavigationController+LRFactory.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    
    [UIViewController lrf_styleAddWithIdentifier:@"lalala" style:^(UIViewController *vc) {
//        vc.lrf_navigationTitleColor = [UIColor redColor];
//        vc.lrf_navigationTitleFont = [UIFont systemFontOfSize:20];
        vc.lrf_navigationItemColor = [UIColor redColor];
        vc.lrf_navigationItemFont = [UIFont systemFontOfSize:20];
        vc.lrf_navigationBarStyle.shadowImage = [[UIImage alloc] init];
    }];
    [UIViewController lrf_styleAddWithIdentifier:@"bababa" style:^(UIViewController *vc) {
//        vc.lrf_navigationTitleColor = [UIColor blueColor];
//        vc.lrf_navigationTitleFont = [UIFont systemFontOfSize:10];
        vc.lrf_navigationItemColor = [UIColor blueColor];
        vc.lrf_navigationItemFont = [UIFont systemFontOfSize:10];
        vc.lrf_navigationBackImage = [UIImage imageNamed:@"back"];
        vc.lrf_navigationBackTitle = vc.lrf_navigationBackPrevTitle;
        vc.lrf_navigationBackColor = [UIColor blueColor];
        vc.lrf_navigationBackFont = [UIFont systemFontOfSize:20];
        vc.lrf_navigationBarStyle.shadowImage = nil;
    }];
    [UIViewController lrf_styleSetupDefaultIdentifier:@"bababa"];
    
    [UIViewController lrf_autoHidesTabBar];
    
    [[UINavigationBar appearance] setShadowImage:nil];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    
    UINavigationController *nav = [UINavigationController lrf_navigationControllerWithRootViewController:[[ViewController alloc] init]];
    UINavigationController *nav1 = [UINavigationController lrf_navigationControllerWithRootViewController:[[ViewController alloc] init]];
    
    tab.viewControllers = @[nav,nav1];
    
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

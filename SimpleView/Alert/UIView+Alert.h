//
//  UIView+Alert.h
//  SimpleView
//
//  Created by leo on 2016/12/12.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlertDelegate <NSObject>

-(void)alertShow:(UIView *)view;
-(void)alertDismiss:(UIView *)view;

@end


@interface UIView (Alert)

@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, strong) UIColor *alertShadeColor;

-(void)showAlert;
-(void)dismissAlert;

@end

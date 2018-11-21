//
//  UIViewController+LRFViewControllerStyle.h
//  SimpleView
//
//  Created by leo on 2018/11/21.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (LRFViewControllerStyle)

+ (void)lrf_styleAddWithIdentifier:(NSString *)identifier style:(void(^)(UIViewController *vc))style;

+ (void)lrf_styleSetupDefaultIdentifier:(NSString *)identifier;

@property (nonatomic, copy) NSString *lrf_styleIdentifier;

@end


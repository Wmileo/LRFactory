//
//  UIViewController+LRFAppear.h
//  SimpleView
//
//  Created by leo on 2018/11/12.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (LRFAppear)

@property (nonatomic, copy) void (^lrf_viewDidDisappearForever)(BOOL animated);
@property (nonatomic, copy) void (^lrf_viewWillDisappearForever)(BOOL animated);
@property (nonatomic, copy) void (^lrf_viewWillAppearFirstTime)(BOOL animated);

@end


//
//  UIViewController+SimplePush.h
//  Pods
//
//  Created by leo on 2017/7/6.
//
//

#import <UIKit/UIKit.h>


@interface UINavigationController (SimplePush)

@end


@interface UIViewController (SimplePush)

+(void)configSimplePush;

@property (nonatomic, assign) BOOL popIgnore;//pop时忽略

@end

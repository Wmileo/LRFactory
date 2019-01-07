//
//  UIGestureRecognizer+LRFactory.h
//  SimpleView
//
//  Created by leo on 2018/11/7.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIGestureRecognizer (LRFactory)

- (void)lrf_handleGestureRecognizer:(void(^)(id recognizer))block;

@end


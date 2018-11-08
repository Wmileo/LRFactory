//
//  UIGestureRecognizer+LRFactory.m
//  SimpleView
//
//  Created by leo on 2018/11/7.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIGestureRecognizer+LRFactory.h"
#import <objc/runtime.h>

@implementation UIGestureRecognizer (LRFactory)

static char keyHandleBlock;

-(void)lrf_handleGestureRecognizer:(void (^)(id _Nonnull))block{
    objc_setAssociatedObject(self, &keyHandleBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(lrf_actionGestureRecognizer:)];
}

-(void)lrf_actionGestureRecognizer:(id)recognizer{
    void (^Block)(id) = objc_getAssociatedObject(self, &keyHandleBlock);
    if (Block) {
        Block(recognizer);
    }
}

@end

//
//  UIControl+LRFactory.m
//  SimpleView
//
//  Created by leo on 2018/11/7.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "UIControl+LRFactory.h"
#import <objc/runtime.h>

@implementation UIControl (LRFactory)

static char keyHandleBlock;

-(void)lrf_handleEvent:(UIControlEvents)event block:(void (^)(id _Nonnull))block{
    objc_setAssociatedObject(self, &keyHandleBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(lrf_actionEvent:) forControlEvents:event];
}

-(void)lrf_actionEvent:(id)sender{
    void (^Block)(id) = objc_getAssociatedObject(self, &keyHandleBlock);
    if (Block) {
        Block(sender);
    }
}

@end

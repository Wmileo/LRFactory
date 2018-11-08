//
//  UIBarButtonItem+LRFactory.m
//  SimpleView
//
//  Created by ileo on 16/4/27.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "UIBarButtonItem+LRFactory.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (LRFactory)

+(UIBarButtonItem *)lrf_barButtonItemSpaceWithWidth:(CGFloat)width{
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = width;
    return space;
}

+(UIBarButtonItem *)lrf_barButtonItemWithButton:(UIButton *)button{
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+(UIBarButtonItem *)lrf_barButtonItemWithImage:(UIImage *)image action:(void (^)(void))action{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:nil action:nil];
    [barButtonItem lrf_handleAction:^(id sender) {
        if (action) {
            action();
        }
    }];
    return barButtonItem;
}

+(UIBarButtonItem *)lrf_barButtonItemWithTitle:(NSString *)title action:(void (^)(void))action{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:nil action:nil];
    [barButtonItem lrf_handleAction:^(id sender) {
        if (action) {
            action();
        }
    }];
    return barButtonItem;
}

static char keyHandleBlock;

-(void)lrf_handleAction:(void (^)(id))block{
    objc_setAssociatedObject(self, &keyHandleBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.target = self;
    self.action = @selector(lrf_actionClick:);
}

-(void)lrf_actionClick:(id)sender{
    void (^Block)(id) = objc_getAssociatedObject(self, &keyHandleBlock);
    if (Block) {
        Block(sender);
    }
}


@end

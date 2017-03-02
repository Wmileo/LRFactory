//
//  NSObject+Method.m
//  SimpleView
//
//  Created by ileo on 16/7/19.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "NSObject+Method.h"
#import <objc/runtime.h>

@implementation NSObject (Method)

static char tagObjectKey;

-(void)setTagObject:(id)tagObject{
    objc_setAssociatedObject(self, &tagObjectKey, tagObject, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(id)tagObject{
    return objc_getAssociatedObject(self, &tagObjectKey);
}

+(void)exchangeSEL:(SEL)sel1 withSEL:(SEL)sel2{
    method_exchangeImplementations(class_getInstanceMethod([self class], sel1), class_getInstanceMethod([self class], sel2));
}

@end

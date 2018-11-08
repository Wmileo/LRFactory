//
//  NSObject+LRFactory.m
//  SimpleView
//
//  Created by leo on 2018/11/7.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "NSObject+LRFactory.h"
#import <objc/runtime.h>

@implementation NSObject (LRFactory)


static char tagObjectCopyKey;
static char tagObjectStrongKey;

-(void)setTagObject_copy:(id)tagObject_copy{
    objc_setAssociatedObject(self, &tagObjectCopyKey, tagObject_copy, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(id)tagObject_copy{
    return objc_getAssociatedObject(self, &tagObjectCopyKey);
}


-(void)setTagObject_strong:(id)tagObject_strong{
    objc_setAssociatedObject(self, &tagObjectStrongKey, tagObject_strong, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)tagObject_strong{
    return objc_getAssociatedObject(self, &tagObjectStrongKey);
}

+(void)lrf_exchangeSEL:(SEL)sel1 withSEL:(SEL)sel2{
    method_exchangeImplementations(class_getInstanceMethod([self class], sel1), class_getInstanceMethod([self class], sel2));
}

+(void)lrf_exchangeClassSEL:(SEL)sel1 withClassSEL:(SEL)sel2{
    method_exchangeImplementations(class_getClassMethod([self class], sel1), class_getClassMethod([self class], sel2));
}


@end

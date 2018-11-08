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

static char keyTagObjectCopy;
static char keyTagObjectStrong;
static char keyTagInteger;

-(void)setLrf_tag_copy:(id)lrf_tag_copy{
    objc_setAssociatedObject(self, &keyTagObjectCopy, lrf_tag_copy, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(id)lrf_tag_copy{
    return objc_getAssociatedObject(self, &keyTagObjectCopy);
}

-(void)setLrf_tag_strong:(id)lrf_tag_strong{
    objc_setAssociatedObject(self, &keyTagObjectStrong, lrf_tag_strong, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)lrf_tag_strong{
    return objc_getAssociatedObject(self, &keyTagObjectStrong);
}

-(void)setLrf_tag:(NSInteger)lrf_tag{
    objc_setAssociatedObject(self, &keyTagInteger, @(lrf_tag), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSInteger)lrf_tag{
    return [objc_getAssociatedObject(self, &keyTagInteger) integerValue];
}

#pragma mark - method

+(void)lrf_exchangeSEL:(SEL)sel1 withSEL:(SEL)sel2{
    method_exchangeImplementations(class_getInstanceMethod([self class], sel1), class_getInstanceMethod([self class], sel2));
}

+(void)lrf_exchangeClassSEL:(SEL)sel1 withClassSEL:(SEL)sel2{
    method_exchangeImplementations(class_getClassMethod([self class], sel1), class_getClassMethod([self class], sel2));
}


@end

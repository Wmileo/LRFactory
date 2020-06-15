//
//  NSObject+LRFactory.m
//  SimpleView
//
//  Created by leo on 2018/11/7.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "NSObject+LRFactory.h"

@interface LRFDeallocObject : NSObject

@property (nonatomic, copy, nullable) NSArray<void(^)(void)> *lrf_willDeallocActions;

@end

@implementation LRFDeallocObject

- (void)dealloc{
    [self.lrf_willDeallocActions enumerateObjectsUsingBlock:^(void (^ _Nonnull obj)(void), NSUInteger idx, BOOL * _Nonnull stop) {
        obj();
    }];
}

@end

@implementation NSObject (LRFactory)

static char keyTagObjectCopy;
static char keyTagObjectStrong;
static char keyTagInteger;

- (void)setLrf_tag_copy:(id _Nullable)lrf_tag_copy{
    [self lrf_setNonatomicCopyAssociatedObject:lrf_tag_copy withKeyPoint:&keyTagObjectCopy];
}

- (id _Nullable)lrf_tag_copy{
    return [self lrf_getAssociatedObjectWithKeyPoint:&keyTagObjectCopy];
}

- (void)setLrf_tag_strong:(id _Nullable)lrf_tag_strong{
    [self lrf_setNonatomicStrongAssociatedObject:lrf_tag_strong withKeyPoint:&keyTagObjectStrong];
}

- (id _Nullable)lrf_tag_strong{
    return [self lrf_getAssociatedObjectWithKeyPoint:&keyTagObjectStrong];
}

- (void)setLrf_tag:(NSInteger)lrf_tag{
    [self lrf_setNonatomicStrongAssociatedObject:@(lrf_tag) withKeyPoint:&keyTagInteger];
}

- (NSInteger)lrf_tag{
    return [[self lrf_getAssociatedObjectWithKeyPoint:&keyTagInteger] integerValue];
}

#pragma mark - weak dealloc

static char keyLRFDeallocObject;

- (void)lrf_addActionWhileWillDealloc:(void (^)(void))action{
    LRFDeallocObject *obj = [self lrf_getAssociatedObjectWithKeyPoint:&keyLRFDeallocObject];
    if (!obj) {
        obj = [[LRFDeallocObject alloc] init];
        [self lrf_setNonatomicStrongAssociatedObject:obj withKeyPoint:&keyLRFDeallocObject];
    }
    NSArray<void(^)(void)> *actions = obj.lrf_willDeallocActions;
    NSArray<void(^)(void)> *tmp = actions ? [actions arrayByAddingObject:action] : @[action];
    obj.lrf_willDeallocActions = tmp;
}

#pragma mark - property

- (void)lrf_setAssociatedObject:(id _Nullable)objc withKeyPoint:(const void *)point policy:(objc_AssociationPolicy)policy{
    objc_setAssociatedObject(self, point, objc, policy);
}

- (id _Nullable)lrf_getAssociatedObjectWithKeyPoint:(const void *)point{
    return objc_getAssociatedObject(self, point);
}

- (void)lrf_setAssignAssociatedObject:(id _Nullable)objc withKeyPoint:(const void *)point{
    [self lrf_setAssociatedObject:objc withKeyPoint:point policy:OBJC_ASSOCIATION_ASSIGN];
}

- (void)lrf_setWeakAssociatedObject:(id _Nullable)objc withKeyPoint:(const void *)point{
    [self lrf_setAssignAssociatedObject:objc withKeyPoint:point];
    __weak typeof(self) wself = self;
    [objc lrf_addActionWhileWillDealloc:^{
        [wself lrf_setAssignAssociatedObject:nil withKeyPoint:point];
    }];
}

- (void)lrf_setStrongAssociatedObject:(id _Nullable)objc withKeyPoint:(const void *)point{
    [self lrf_setAssociatedObject:objc withKeyPoint:point policy:OBJC_ASSOCIATION_RETAIN];
}

- (void)lrf_setNonatomicStrongAssociatedObject:(id _Nullable)objc withKeyPoint:(const void *)point{
    [self lrf_setAssociatedObject:objc withKeyPoint:point policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

- (void)lrf_setCopyAssociatedObject:(id _Nullable)objc withKeyPoint:(const void *)point{
    [self lrf_setAssociatedObject:objc withKeyPoint:point policy:OBJC_ASSOCIATION_COPY];
}

- (void)lrf_setNonatomicCopyAssociatedObject:(id _Nullable)objc withKeyPoint:(const void *)key{
    [self lrf_setAssociatedObject:objc withKeyPoint:key policy:OBJC_ASSOCIATION_COPY_NONATOMIC];
}

#pragma mark - method

+ (void)lrf_exchangeSEL:(SEL)sel1 withSEL:(SEL)sel2{
    Method method1 = class_getInstanceMethod([self class], sel1);
    Method method2 = class_getInstanceMethod([self class], sel2);
    IMP imp1 = method_getImplementation(method1);
    IMP imp2 = method_getImplementation(method2);
    class_replaceMethod([self class], sel1, imp2, method_getTypeEncoding(method1));
    class_replaceMethod([self class], sel2, imp1, method_getTypeEncoding(method2));
}

+ (void)lrf_exchangeClassSEL:(SEL)sel1 withClassSEL:(SEL)sel2{
    Method method1 = class_getClassMethod([self class], sel1);
    Method method2 = class_getClassMethod([self class], sel2);
    IMP imp1 = method_getImplementation(method1);
    IMP imp2 = method_getImplementation(method2);
    class_replaceMethod([self class], sel1, imp2, method_getTypeEncoding(method1));
    class_replaceMethod([self class], sel2, imp1, method_getTypeEncoding(method2));
}

#pragma mark - hook

static NSString *LRFHookPrefix = @"__LRF__";

- (Class)lrf_hookSubClass{
    Class realClass = object_getClass(self);
    Class showClass = [self class];
    if ([NSStringFromClass(realClass) hasPrefix:LRFHookPrefix]) {
        return realClass;
    }
    if (![NSStringFromClass(realClass) isEqualToString:NSStringFromClass(showClass)]) {
        return realClass;
    }
    NSString *subNameStr = [LRFHookPrefix stringByAppendingString:NSStringFromClass(showClass)];
    const char *subName = subNameStr.UTF8String;
    Class subClass = objc_getClass(subName);
    Class subMetaClass = object_getClass(subClass);
    if (!subClass) {
        subClass = objc_allocateClassPair(showClass, subName, 0);
        objc_registerClassPair(subClass);
        subMetaClass = object_getClass(subClass);
        lrf_hookClass(self, subClass);
        lrf_hookClass(self, subMetaClass);
    }
    if (class_isMetaClass(realClass)) {
        object_setClass(self, subMetaClass);
        return subMetaClass;
    } else {
        object_setClass(self, subClass);
        return subClass;
    }
}

static void lrf_hookClass(id self, Class sub) {
    Method method = class_getInstanceMethod(sub, @selector(class));
    Class showClass = [self class];
    IMP newIMP = imp_implementationWithBlock(^() {
        return showClass;
    });
    class_replaceMethod(sub, @selector(class), newIMP, method_getTypeEncoding(method));
}

#pragma mark - actions

- (NSArray * _Nullable)lrf_getActionsWithKeyPoint:(const void *)point{
    return [self lrf_getAssociatedObjectWithKeyPoint:point];
}

- (void)lrf_addAction:(id)action withKeyPoint:(const void *)point{
    NSArray *actions = [self lrf_getActionsWithKeyPoint:point];
    if (actions) {
        actions = [actions arrayByAddingObject:action];
    } else {
        actions = @[action];
    }
    [self lrf_setCopyAssociatedObject:actions withKeyPoint:point];
}

@end

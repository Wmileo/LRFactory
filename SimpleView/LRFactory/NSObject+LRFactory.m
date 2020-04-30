//
//  NSObject+LRFactory.m
//  SimpleView
//
//  Created by leo on 2018/11/7.
//  Copyright © 2018 ileo. All rights reserved.
//

#import "NSObject+LRFactory.h"

NS_ASSUME_NONNULL_BEGIN

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
    [self lrf_setNonatomicCopyAssociatedObject:lrf_tag_copy withKey:&keyTagObjectCopy];
}

- (id _Nullable)lrf_tag_copy{
    return [self lrf_getAssociatedObjectWithKey:&keyTagObjectCopy];
}

- (void)setLrf_tag_strong:(id _Nullable)lrf_tag_strong{
    [self lrf_setNonatomicStrongAssociatedObject:lrf_tag_strong withKey:&keyTagObjectStrong];
}

- (id _Nullable)lrf_tag_strong{
    return [self lrf_getAssociatedObjectWithKey:&keyTagObjectStrong];
}

- (void)setLrf_tag:(NSInteger)lrf_tag{
    [self lrf_setNonatomicStrongAssociatedObject:@(lrf_tag) withKey:&keyTagInteger];
}

- (NSInteger)lrf_tag{
    return [[self lrf_getAssociatedObjectWithKey:&keyTagInteger] integerValue];
}

#pragma mark - weak dealloc

static char keyLRFDeallocObject;

- (void)lrf_addActionWhileWillDealloc:(void (^)(void))action{
    LRFDeallocObject *obj = [self lrf_getAssociatedObjectWithKey:&keyLRFDeallocObject];
    if (!obj) {
        obj = [[LRFDeallocObject alloc] init];
        [self lrf_setNonatomicStrongAssociatedObject:obj withKey:&keyLRFDeallocObject];
    }
    NSArray<void(^)(void)> *actions = obj.lrf_willDeallocActions;
    NSArray<void(^)(void)> *tmp = actions ? [actions arrayByAddingObject:action] : @[action];
    obj.lrf_willDeallocActions = tmp;
}

#pragma mark - property

- (void)lrf_setAssociatedObject:(id _Nullable)objc withKey:(const void *)key policy:(objc_AssociationPolicy)policy{
    objc_setAssociatedObject(self, key, objc, policy);
}

- (id _Nullable)lrf_getAssociatedObjectWithKey:(const void *)key{
    return objc_getAssociatedObject(self, key);
}

- (void)lrf_setAssignAssociatedObject:(id _Nullable)objc withKey:(const void *)key{
    [self lrf_setAssociatedObject:objc withKey:key policy:OBJC_ASSOCIATION_ASSIGN];
}

- (void)lrf_setWeakAssociatedObject:(id _Nullable)objc withKey:(const void *)key{
    [self lrf_setAssignAssociatedObject:objc withKey:key];
    __weak typeof(self) wself = self;
    [objc lrf_addActionWhileWillDealloc:^{
        [wself lrf_setAssignAssociatedObject:nil withKey:key];
    }];
}

- (void)lrf_setStrongAssociatedObject:(id _Nullable)objc withKey:(const void *)key{
    [self lrf_setAssociatedObject:objc withKey:key policy:OBJC_ASSOCIATION_RETAIN];
}

- (void)lrf_setNonatomicStrongAssociatedObject:(id _Nullable)objc withKey:(const void *)key{
    [self lrf_setAssociatedObject:objc withKey:key policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC];
}

- (void)lrf_setCopyAssociatedObject:(id _Nullable)objc withKey:(const void *)key{
    [self lrf_setAssociatedObject:objc withKey:key policy:OBJC_ASSOCIATION_COPY];
}

- (void)lrf_setNonatomicCopyAssociatedObject:(id _Nullable)objc withKey:(const void *)key{
    [self lrf_setAssociatedObject:objc withKey:key policy:OBJC_ASSOCIATION_COPY_NONATOMIC];
}

#pragma mark - method

+ (void)lrf_exchangeSEL:(SEL)sel1 withSEL:(SEL)sel2{
    method_exchangeImplementations(class_getInstanceMethod([self class], sel1), class_getInstanceMethod([self class], sel2));
}

+ (void)lrf_exchangeClassSEL:(SEL)sel1 withClassSEL:(SEL)sel2{
    method_exchangeImplementations(class_getClassMethod([self class], sel1), class_getClassMethod([self class], sel2));
}

#pragma mark - actions

- (NSArray * _Nullable)lrf_getActionsWithKey:(const void *)key{
    return [self lrf_getAssociatedObjectWithKey:key];
}

- (void)lrf_addAction:(id)action key:(const void *)key{
    NSArray *actions = [self lrf_getActionsWithKey:key];
    if (actions) {
        actions = [actions arrayByAddingObject:action];
    } else {
        actions = @[action];
    }
    [self lrf_setCopyAssociatedObject:actions withKey:key];
}

@end

NS_ASSUME_NONNULL_END

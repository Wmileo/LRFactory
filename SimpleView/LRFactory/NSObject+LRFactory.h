//
//  NSObject+LRFactory.h
//  SimpleView
//
//  Created by leo on 2018/11/7.
//  Copyright © 2018 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LRFactory)

@property (nonatomic, copy, nullable) id lrf_tag_copy;//用于区分，存值，copy
@property (nonatomic, strong, nullable) id lrf_tag_strong;//用于区分，存值，strong
@property (nonatomic, assign) NSInteger lrf_tag;

+ (void)lrf_exchangeSEL:(SEL)sel1 withSEL:(SEL)sel2;
+ (void)lrf_exchangeClassSEL:(SEL)sel1 withClassSEL:(SEL)sel2;

- (void)lrf_setAssociatedObject:(id _Nullable)objc withKey:(const void *)key policy:(objc_AssociationPolicy)policy;
- (id _Nullable)lrf_getAssociatedObjectWithKey:(const void *)key;
- (void)lrf_setAssignAssociatedObject:(id _Nullable)objc withKey:(const void *)key;
- (void)lrf_setWeakAssociatedObject:(id _Nullable)objc withKey:(const void *)key;
- (void)lrf_setStrongAssociatedObject:(id _Nullable)objc withKey:(const void *)key;
- (void)lrf_setNonatomicStrongAssociatedObject:(id _Nullable)objc withKey:(const void *)key;
- (void)lrf_setCopyAssociatedObject:(id _Nullable)objc withKey:(const void *)key;
- (void)lrf_setNonatomicCopyAssociatedObject:(id _Nullable)objc withKey:(const void *)key;

- (void)lrf_addActionWillDealloc:(void(^)(void))action;

@end

NS_ASSUME_NONNULL_END

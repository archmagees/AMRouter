//
//  AMComponent.m
//  AMRouter
//
//  Created by archmagees on 2018/06/04.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import "AMComponent.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static AMComponent *sharedInstance = nil;

@interface AMComponent ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, __kindof NSObject *> *cachedTargets;

@end

@implementation AMComponent {
    dispatch_queue_t operate_target_queue;
    dispatch_semaphore_t target_semaphore;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AMComponent alloc] init];
    });
    return sharedInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
        sharedInstance.cachedTargets = [NSMutableDictionary dictionary];
        sharedInstance->operate_target_queue =
        dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        sharedInstance->target_semaphore = dispatch_semaphore_create(1);
    });
    return sharedInstance;
}

- (instancetype)init {
    return sharedInstance;
}

#pragma mark - Public

+ (nullable id)targetWithName:(NSString *)targetName
                  classPrefix:(nullable NSString *)classPrefix
          componentNameSuffix:(nullable NSString *)suffix
                  shouldCache:(BOOL)shouldCache {
    
    if (!targetName.length) {
        return nil;
    }
    
    NSString *className = [NSString stringWithFormat:@"%@%@%@",
                           classPrefix ?: @"",
                           targetName ?: @"",
                           suffix ?: @"Component"];
    
    return [[self sharedInstance] targetForKey:className
                                   shouldCache:shouldCache];
}

+ (void)releaseCachedTarget:(__kindof NSObject *)target {
    if (!target) {
        return;
    }
    
    [[self sharedInstance] releaseTargetWithName:NSStringFromClass(target.class)];
}

#pragma mark - Private

- (nullable id)targetForKey:(NSString *)key
                shouldCache:(BOOL)shouldCache {
    
    __block _Nullable id target = nil;
    
    
    dispatch_sync(operate_target_queue, ^{
        dispatch_semaphore_wait(self->target_semaphore,
                                DISPATCH_TIME_NOW);
        
        target = [self.cachedTargets objectForKey:key];
        
        if (!target) {
            Class targetClass = NSClassFromString(key);
            target = [[[targetClass class] alloc] init];
        }
        
        if (shouldCache && target) {
            [self.cachedTargets setObject:target forKey:key];
        }
        
        dispatch_semaphore_signal(self->target_semaphore);
    });

    return target;
}

- (void)releaseTargetWithName:(NSString *)targetNameKey {
    dispatch_async(operate_target_queue, ^{
        dispatch_semaphore_wait(self->target_semaphore, dispatch_time(DISPATCH_TIME_NOW, 3));
        
        [self.cachedTargets removeObjectForKey:targetNameKey];
        
        dispatch_semaphore_signal(self->target_semaphore);
    });
}

@end

NS_ASSUME_NONNULL_END

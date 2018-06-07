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

@implementation AMComponent

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
    NSString *className =
    [self classNameWithTargetName:targetName
                      classPrefix:classPrefix
                           suffix:suffix];
    
    _Nullable id target = [[[self sharedInstance] cachedTargets] objectForKey:className];
    
    if (target) {
        return target;
    }
    
    Class targetClass = NSClassFromString(className);
    
    target = [[[targetClass class] alloc] init];
    
    if (shouldCache) {
        [[[self sharedInstance] cachedTargets] setObject:target
                                                  forKey:className];
    }

    return target;
}

+ (void)releaseCachedTarget:(__kindof NSObject *)target {
    if (!target) {
        return;
    }
    
    [[[self sharedInstance] cachedTargets] removeObjectForKey:NSStringFromClass(target.class)];
    
}

#pragma mark - Private

+ (NSString *)classNameWithTargetName:(NSString *)targetName
                          classPrefix:(nullable NSString *)classPrefix
                               suffix:(nullable NSString *)suffix {
    NSAssert(targetName.length > 0, @"target name should not be empty");
    NSString *className = [NSString stringWithFormat:@"%@%@%@",
                           classPrefix ?: @"",
                           targetName,
                           suffix ?: @"Component"];
    return className;
}

@end

NS_ASSUME_NONNULL_END

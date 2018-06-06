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
@property (nonatomic, copy, nullable) NSString *classPrefix;

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

+ (void)registerClassPrefix:(NSString *)classPrefix {
    NSAssert(classPrefix.length > 0, @"class prefix should not be nil, %s", __FUNCTION__);
    // now it can be invoked multiply
    [[self sharedInstance] setClassPrefix:classPrefix];
}

+ (nullable id)openUrl:(NSString *)url
              userInfo:(nullable NSDictionary *)userInfo
            completion:(nullable AMComponentCompletion)completion {
    /// @todo: add later.
    /// @warning return value is nil now.
    return nil;
}

- (id)targetWithName:(NSString *)targetName {
    
    _Nullable id target = self.cachedTargets[targetName];
    
    if (target) {
        return target;
    }
    
    NSString *className = [self classNameForTarget:targetName];
    Class targetClass = NSClassFromString(className);
    
    target = [[[targetClass class] alloc] init];
    
    self.cachedTargets[targetName] = target;
    return target;
}


- (void)releaseCachedTarget:(NSString *)targetName {
    [self.cachedTargets removeObjectForKey:targetName];
}

#pragma mark - Private

- (NSString *)classNameForTarget:(NSString *)targetName {
    NSString *classPrefix = self.classPrefix ?: @"";
    return [NSString stringWithFormat:@"%@%@Component", classPrefix, targetName];
}

@end

NS_ASSUME_NONNULL_END

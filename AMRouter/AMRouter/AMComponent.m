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
@property (nonatomic, copy, null_resettable) NSString *classPrefix;

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

+ (void)registerClassPrefix:(nullable NSString *)classPrefix {
    // now it can be invoked multiply, it could be nil
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
    
    NSString *className = [self classNameForTarget:targetName];
    
    _Nullable id target = self.cachedTargets[className];
    
    if (target) {
        return target;
    }
    
    Class targetClass = NSClassFromString(className);
    
    target = [[[targetClass class] alloc] init];
    
    self.cachedTargets[className] = target;
    return target;
}


- (void)releaseCachedTarget:(NSString *)targetName {
    [self.cachedTargets removeObjectForKey:[self classNameForTarget:targetName]];
}

#pragma mark - Private

- (NSString *)classNameForTarget:(NSString *)targetName {
    return [NSString stringWithFormat:@"%@%@Component",
            self.classPrefix, targetName];
}

- (NSString *)classPrefix {
    if (!_classPrefix) {
        _classPrefix = @"";
    }
    return _classPrefix;
}

@end

NS_ASSUME_NONNULL_END

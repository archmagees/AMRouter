//
//  AMComponent.h
//  AMRouter
//
//  Created by archmagees on 2018/06/04.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * @brief Create category files to each component.
 */
@interface AMComponent : NSObject

/**
 * @brief Get the component instance, and it is cached.
 * @discussion
 * The instance's class name's format is like this:
 * `ClassPrefix(if exists)+TargetName+Component`.
 *
 * @param targetName
 * A string value which is a factor to composite a class name.
 *
 * @param classPrefix
 * A string value indicates the class prefix of the customized module class,
 * could be nil.
 *
 * @param suffix
 * If your component class name is not end with `component`, maybe `module`,
 * then you could set it as a different string, could be nil. For example, the
 * return value's class name should be `AMShareComponent`, if you pass `Share`,
 * `AM` and `nil` to the method, becasue the default suffix is `component`.
 *
 * @param shouldCache
 * A boolean value indicates that the return value whether or not should be
 * cached. Default is `NO`.
 *
 * @return
 * An instance which class is `ClassPrefix+TargetName+ComponentNameSuffix`.
 * Could be nil means there is no class which name is given.
 */
+ (nullable id)targetWithName:(NSString *)targetName
                  classPrefix:(nullable NSString *)classPrefix
          componentNameSuffix:(nullable NSString *)suffix
                  shouldCache:(BOOL)shouldCache;

/**
 * @brief Release the cached target.
 *
 * @param target
 * An instance that has been cached before.
 */
+ (void)releaseCachedTarget:(__kindof NSObject *)target;

@end

NS_ASSUME_NONNULL_END

//typedef void(^AMComponentCompletion)(NSDictionary *info);

/**
 * @brief Initialize an object by url.
 *
 * @param url
 * A string, syntax is like this: scheme://host/action?key&value
 *
 * @param userInfo
 * A convenience way to set the key value in url, could be nil.
 *
 * @param completion
 * A convenience way to set the completion callback, could be nil.
 *
 * @return
 * An object that initialized by the url, could be nil.
 *
 * @todo
 * Add url-scheme func later.
 */
//+ (nullable id)openUrl:(NSString *)url
//              userInfo:(nullable NSDictionary *)userInfo
//            completion:(nullable AMComponentCompletion)completion;


@interface AMComponent (Depreated)
+ (void)registerClassPrefix:(nullable NSString *)classPrefix DEPRECATED_ATTRIBUTE;
@end

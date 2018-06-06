//
//  AMComponent.h
//  AMRouter
//
//  Created by archmagees on 2018/06/04.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AMComponentCompletion)(NSDictionary *info);

/**
 * @brief Create category files to each component.
 */
@interface AMComponent : NSObject

+ (instancetype)sharedInstance;

/**
 * @brief Register your specific class prefix.
 * @discussion
 * This method should be invoked in the very beginning of the app.
 *
 * @param classPrefix
 * The specific class prefix of your app.
 *
 * @attention
 * If your module has class prefix then you should invoke this before using this
 * class.
 *
 * @todo
 * Implement func.
 */
+ (void)registerClassPrefix:(NSString *)classPrefix;


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
 */
+ (nullable id)openUrl:(NSString *)url
              userInfo:(nullable NSDictionary *)userInfo
            completion:(nullable AMComponentCompletion)completion;

- (id)targetWithName:(NSString *)targetName;

- (void)releaseCachedTarget:(NSString *)targetName;


@end

NS_ASSUME_NONNULL_END

//
//  AMUrlSchemeSynthesizer.h
//  AMRouter
//
//  Created by archmagees on 2018/06/10.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMUrlSchemeSynthesizer : NSObject

/**
 * @brief Create a string by replacing the placeholders in pattern.
 * @discussion
 * Pattern format is just like the url components. That is:
 * `scheme://host/path.pathextension?query#fragment`, and usually the pattern
 * format is passed as `:action?key1=:value1&key2=:value2`.
 *
 * @param pattern
 * A string value indicates the template format.
 *
 * @param replacements
 * An array which elements is NSString type, each of them will be used to
 * replace the placeholders in template string.
 *
 * @return
 * A string that has been processed. If it is nil, means there maybe an error
 * in one of the parameters.
 */
+ (nullable NSString *)synthesizedStringWithPattern:(NSString *)pattern
                                       replacements:(NSArray<NSString *> *)replacements;

@end

NS_ASSUME_NONNULL_END

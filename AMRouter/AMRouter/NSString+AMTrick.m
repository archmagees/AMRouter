//
//  NSString+AMTrick.m
//  AMRouter
//
//  Created by archmagees on 2018/06/10.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import "NSString+AMTrick.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSString (AMTrick)

- (NSUInteger)am_countOfOccurrencesOfString:(NSString *)specSymbol {
    if (!self.length) {
        return 0;
    }
    
    if (!specSymbol.length) {
        return 0;
    }
    
    NSString *stringWithoutSymbol =
    [self stringByReplacingOccurrencesOfString:specSymbol withString:@""];
    NSUInteger diff = self.length - stringWithoutSymbol.length;
    return diff;
}

@end

NS_ASSUME_NONNULL_END

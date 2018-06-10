//
//  AMUrlSchemeSynthesizer.m
//  AMRouter
//
//  Created by archmagees on 2018/06/10.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import "AMUrlSchemeSynthesizer.h"
#import "NSString+AMTrick.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const kColonSymbol = @":";
static NSString * const kDelimiterSymbols = @"/?&.";
static NSString * const kSeparatorSymbols = @"://";

@implementation AMUrlSchemeSynthesizer

#pragma mark - Public

+ (nullable NSString *)synthesizedStringWithPattern:(NSString *)pattern
                                       replacements:(NSArray<NSString *> *)replacements {
    if (!pattern.length || !replacements.count) {
        return nil;
    }
    
    NSMutableArray *tempReplacements = [replacements mutableCopy];
    
    // failsafe check if it has a scheme part
    NSArray<NSString *> *components =
    [pattern componentsSeparatedByString:kSeparatorSymbols];
    
    NSMutableArray<NSString *> *synthesizedStrings = [NSMutableArray array];
    

    void(^replacePlaceholder)(NSString * _Nonnull, NSArray<NSString *> * _Nonnull, BOOL * _Nonnull, BOOL * _Nonnull) = ^(NSString * _Nonnull stringWithPlaceholder, NSArray<NSString *> * _Nonnull matchedReplacements, BOOL * _Nonnull formatError, BOOL * _Nonnull stop) {
        
        NSString *actualComponent = [self stringByReplacingPlaceholdersInString:stringWithPlaceholder withReplacements:matchedReplacements];
        
        if (!actualComponent.length) {
            *stop = YES;
            *formatError = YES;
            return;
        }
        [synthesizedStrings addObject:actualComponent];
    };
    
    __block BOOL formatError = NO;
    
    [components enumerateObjectsUsingBlock:^(NSString * _Nonnull stringComponent, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![stringComponent containsString:kColonSymbol]) {
            [synthesizedStrings addObject:stringComponent];
        }
        else {
            // TODO: still can optimize it by using loop count
            if (idx == 0 && components.count == 2) {
                replacePlaceholder(stringComponent,
                                   @[ replacements[0] ],
                                   &formatError,
                                   stop);
                [tempReplacements removeObjectAtIndex:0];
            }
            else {
                replacePlaceholder(stringComponent,
                                   tempReplacements,
                                   &formatError,
                                   stop);
            }
        }
    }];
    
    
    return formatError ?
    nil : [synthesizedStrings componentsJoinedByString:kSeparatorSymbols];
}

#pragma mark - Private

+ (nullable NSString *)stringByReplacingPlaceholdersInString:(NSString *)string
                                            withReplacements:(const NSArray<NSString *> *)replacements {
    
    
    NSUInteger count = [string am_countOfOccurrencesOfString:kColonSymbol];
    NSUInteger loopCount = replacements.count;
    
    if (loopCount == 0 ||
        loopCount != count) {
        return nil;
    }
    
    NSCharacterSet *delimiterCharacterSet = [NSCharacterSet characterSetWithCharactersInString:kDelimiterSymbols];
    
    NSMutableString *mutableString = [string mutableCopy];
    
    const NSRange wholeRange = NSMakeRange(0, string.length);
    __block NSRange colonRange = NSMakeRange(0, 1);
    __block NSRange searchRange = NSMakeRange(0, wholeRange.length);
    __block NSRange replaceRange = NSMakeRange(0, 2);
    __block NSUInteger delimiterSymbolRangeLocation = 1;
    
    __block BOOL formatError = NO;
    
    [replacements enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // failsafe there is a @"" in the replacements array
        if (!obj.length) {
            formatError = YES;
            *stop = YES;
        }
        
        colonRange = [mutableString rangeOfString:kColonSymbol];
        searchRange = NSMakeRange(NSMaxRange(colonRange), wholeRange.length);
        searchRange = NSIntersectionRange(searchRange, wholeRange);
        
        
        delimiterSymbolRangeLocation =
        [mutableString rangeOfCharacterFromSet:delimiterCharacterSet
                                       options:NSLiteralSearch
                                         range:searchRange].location;
        // the last placeholder is not end with delimiter symbols
        if (delimiterSymbolRangeLocation == NSNotFound) {
            delimiterSymbolRangeLocation = wholeRange.length;
        }
        replaceRange =
        NSMakeRange(colonRange.location, delimiterSymbolRangeLocation);
        
        [mutableString replaceCharactersInRange:replaceRange withString:obj];
    
    }];
    
    return  formatError ? nil : [mutableString copy];
}

@end

NS_ASSUME_NONNULL_END

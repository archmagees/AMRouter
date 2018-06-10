//
//  NSStringExtensionMethodsSpec.m
//  AMRouter
//
//  Created by archmagees on 2018/06/08.
//  Copyright © 2018 archmagees. All rights reserved.
//

@import Quick;
@import Nimble;
@import Foundation;

QuickSpecBegin(NSStringExtensionMethodsSpec)

NSString * const kColonSymbol = @":";
NSString * const kDelimiterSymbols = @"/?&.";

context(@"there is a string", ^{
    
    
    __block NSString *url = nil;
    
    it(@":12345", ^ {
        
        url = @":12345";
        NSRange colonRange = [url rangeOfString:@":"];
        expect(colonRange.location).to(equal(0));
        expect(colonRange.length).to(equal(1));
        
        // wrong
        NSRange searchRange = NSMakeRange(NSMaxRange(colonRange), url.length);
        NSCharacterSet *delimiterCharacterSet = [NSCharacterSet characterSetWithCharactersInString:kDelimiterSymbols];
        
        expectAction(^ {
            [url rangeOfCharacterFromSet:delimiterCharacterSet
                                 options:NSLiteralSearch
                                   range:searchRange];
        }).to(raiseException().named(NSRangeException));
        
        // correct
        NSUInteger colonEndIndex = NSMaxRange(colonRange);
        searchRange = NSMakeRange(colonEndIndex, url.length - colonEndIndex);
        
        NSUInteger firstDelimiterIndex =
        [url rangeOfCharacterFromSet:delimiterCharacterSet
                             options:NSLiteralSearch
                               range:searchRange].location;
        expect(firstDelimiterIndex).to(equal(NSNotFound));
        
        NSRange replaceRange = NSMakeRange(colonRange.location,
                                           firstDelimiterIndex);
        replaceRange = NSIntersectionRange(replaceRange, NSMakeRange(0, url.length));
        
        NSMutableString *replacedUrl = [url mutableCopy];
        [replacedUrl replaceCharactersInRange:replaceRange withString:@"09876"];
        
        expect(replacedUrl).to(contain(@"09876"));
        
        
    });
});

QuickSpecEnd

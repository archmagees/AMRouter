//
//  NSDictionarySpec.m
//  AMRouter
//
//  Created by archmagees on 2018/06/11.
//  Copyright © 2018 archmagees. All rights reserved.
//

@import Quick;
@import Nimble;
@import Foundation;

QuickSpecBegin(NSDictionarySpec)

context(@"dictionary has multi level key values", ^{
    describe(@"one key's value is also a dictionary", ^{
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict addEntriesFromDictionary:
            @{
              @"1" : @{
                      @"2" : @"999",
                      @"_" : @"xyz"
                     },
              @"_" : @"abc"
            }];
        
        it(@"keys array should has not 4 elements", ^{
            expect(dict.allKeys.count).toNot(equal(4));
            expect(dict.allValues).toNot(contain(@"xyz"));
            
        });
    });
});

QuickSpecEnd

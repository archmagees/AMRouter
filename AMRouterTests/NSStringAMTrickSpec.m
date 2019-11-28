//
//  NSStringAMTrickSpec.m
//  AMRouter
//
//  Created by archmagees on 2018/06/10.
//  Copyright © 2018 archmagees. All rights reserved.
//

@import Quick;
@import Nimble;
#import "NSString+AMTrick.h"

QuickSpecBegin(NSStringAMTrickSpec)

context(@"there is a string", ^{
    describe(@":action/:id?name=:nameid&", ^{
        it(@"should has 3 colon symbols", ^{
            NSString *string = @":action/:id?name=:nameid&";
            
            NSUInteger count = [string am_countOfOccurrencesOfString:@":"];
            expect(count).to(equal(3));
        });
    });
    
    describe(@"is empty", ^{
       
        it(@"return value is 0", ^{
            NSString *string = @"";
            NSUInteger count = [string am_countOfOccurrencesOfString:@":"];
            expect(count).to(equal(0));
        });
    });
    
    describe(@":action", ^{
        
        it(@"has zero count of @\"\"", ^{
            NSString *string = @":action";
            NSUInteger count = [string am_countOfOccurrencesOfString:@""];
            expect(count).to(equal(0));
        });
    });
});

QuickSpecEnd

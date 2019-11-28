//
//  AMUrlSchemeSynthesizerSpec.m
//  AMRouter
//
//  Created by archmagees on 2018/06/10.
//  Copyright © 2018 archmagees. All rights reserved.
//

@import Quick;
@import Nimble;
#import "AMUrlSchemeSynthesizer.h"

QuickSpecBegin(AMUrlSchemeSynthesizerSpec)

context(@"there is template", ^{
    describe(@":scheme://:action?id=:id", ^{
        it(@"should become umeng://login after convert", ^{
            NSString *string =
            [AMUrlSchemeSynthesizer synthesizedStringWithPattern:@":scheme://:action?id=:id"
                                                    replacements:@[ @"umeng", @"login", @"123" ]];
            
            expect(string).to(contain(@"umeng://login?id=123"));
        });
    });
    
    describe(@"scheme://:action, but replacements is empty", ^{
        NSString *pattern = @"scheme://:action";
        it(@"should return nil", ^{
            NSString *string =
            [AMUrlSchemeSynthesizer synthesizedStringWithPattern:pattern
                                                    replacements:@[ @"" ]];
            
            expect(string).to(beNil());
        });
        
        it(@"should become scheme://login", ^{
           NSString *string =
            [AMUrlSchemeSynthesizer synthesizedStringWithPattern:pattern
                                                    replacements:@[ @"login" ]] ;
            
            expect(string).to(match(@"scheme://login"));
        });
        
        
        it(@"return nil when replacements count not pair with pattern", ^{
            NSString *string =
            [AMUrlSchemeSynthesizer synthesizedStringWithPattern:pattern
                                                    replacements:@[]];
            
            expect(string).to(beNil());
            
            string =
            [AMUrlSchemeSynthesizer synthesizedStringWithPattern:pattern
                                                    replacements:
             @[ @"", @"", @"" ]];
            
            expect(string).to(beNil());
            
        });
        
    });
});

QuickSpecEnd

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
    describe(@":scheme://:action", ^{
        it(@"should become umeng://login after convert", ^{
            NSString *string =
            [AMUrlSchemeSynthesizer synthesizedStringWithPattern:@":scheme://:action"
                                                    replacements:@[ @"umeng", @"login" ]];
            
            expect(string).to(contain(@"umeng://login"));
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
            
            expect(string).to(contain(@"scheme://login"));
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
            
            
        });
        
    });
});

QuickSpecEnd

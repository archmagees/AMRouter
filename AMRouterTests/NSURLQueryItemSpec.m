//
//  NSURLQueryItemSpec.m
//  AMRouter
//
//  Created by archmagees on 2018/06/08.
//  Copyright © 2018 archmagees. All rights reserved.
//

@import Quick;
@import Nimble;
@import Foundation;

QuickSpecBegin(NSURLQueryItemSpec)

context(@"there is a url", ^{
    
    it(@"fabric://modulename/actionname/subaction?key1=value1&222=value2&key1=value1", ^ {
        
        NSString *url = @"fabric://modulename/actionname/subaction?key1=value1&222=value2&key1=value1";
        NSURL *URL = [NSURL URLWithString:url];
        
        expect(URL.scheme).to(contain(@"fabric"));
        expect(URL.host).to(contain(@"modulename"));
        expect(URL.path).to(contain(@"actionname/subaction"));
        
        NSArray<NSURLQueryItem *> *queryItems =
        [[NSURLComponents alloc] initWithURL:URL
                     resolvingAgainstBaseURL:NO].queryItems;
        
        [queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
        }];
        
        NSLog(@"query items: %@", queryItems);
        
        expect(queryItems[0].name).to(contain(@"key1"));
        expect(queryItems[1].name).to(contain(@"222"));
        expect(queryItems[2].name).to(contain(@"key1"));
        
    });
    
});

QuickSpecEnd

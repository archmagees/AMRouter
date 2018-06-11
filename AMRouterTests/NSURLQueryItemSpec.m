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

context(@"url", ^{
    
    describe(@"has triple slash symobl", ^{
        NSString *tripleSlashUrl = @"fabric:///mission/login?id=:id";
        NSURL *URL = [NSURL URLWithString:tripleSlashUrl];
        it(@"host will become nil", ^{
            expect(URL.host).to(beNil());
            expect(URL.path).to(contain(@"login"));
            expect(URL.pathComponents).to(contain(@"mission"));
        });
        
    });
    
    describe(@"which format is normal", ^{
        //
        NSString *url = @"fabric://modulename.com/modulename.com2/v3/:actionname/:subaction.htm?key1=value1&:222=value2&key1=:value1";
        NSURL *URL = [NSURL URLWithString:url];
        
        it(url, ^{
            
            expect(URL.scheme).to(contain(@"fabric"));
            expect(URL.host).to(contain(@"modulename.com"));
            expect(URL.path).to(contain(@"modulename.com2/v3/:actionname/:subaction"));
            expect(URL.pathExtension).to(contain(@"htm"));
            
            NSArray<NSURLQueryItem *> *queryItems =
            [[NSURLComponents alloc] initWithURL:URL
                         resolvingAgainstBaseURL:NO].queryItems;
            
            [queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
            }];
            
            NSLog(@"query items: %@", queryItems);
            
            expect(queryItems[0].name).to(contain(@"key1"));
            expect(queryItems[1].name).to(contain(@":222"));
            expect(queryItems[2].name).to(contain(@"key1"));
            
            expect(queryItems[2].value).to(contain(@":value1"));
            
        });
        
        it(@"path components should not contain query items", ^{
            NSArray<NSString *> *pathComponents = URL.pathComponents;
            
            expect(pathComponents).to(contain(@":subaction.htm"));
            expect(pathComponents).toNot(contain(@"key1"));
            expect(pathComponents).toNot(contain(@"?"));
            expect(pathComponents).toNot(contain(@"value"));
            
        });
        
        it(@"first element in path components is slash", ^{
            expect(URL.pathComponents[0]).to(contain(@"/"));
        });
        
        it(@"has not host string in path components", ^{
            // first one will be replaced to "/", if url has only 2 slash
            expect(URL.pathComponents).toNot(contain(@"modulename.com"));
        });
        
    });
    
    
    
    
    
});

QuickSpecEnd

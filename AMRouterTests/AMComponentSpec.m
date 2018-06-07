//
//  AMComponentSpec.m
//  AMRouter
//
//  Created by archmagees on 2018/06/06.
//  Copyright © 2018 archmagees. All rights reserved.
//

@import Quick;
@import Nimble;
@import OCMock;
#import "AMComponent+Message.h"
#import "MessageModule.h"
#import "AMMessageComponent.h"

QuickSpecBegin(AMComponentSpec)

context(@"There is a component message", ^{
    it(@"should get notification status is YES", ^ {
        
        id<MessageComponentInterface> obj = [AMComponent message];
        expect(obj).to(beAKindOf([AMMessageComponent class]));
        
        expect(obj.unreadCount).to(equal(999));
        
    });
    
    it(@"should release the target after invoke method -release...", ^ {
        
        id obj1 = [AMComponent message];
        id obj2 = [AMComponent message];
        
        // because it is cached!!!
        expect(obj1).to(beIdenticalTo(obj2));
        expect(obj1).to(beAKindOf([AMMessageComponent class]));
        
        [AMComponent releaseCachedTarget:obj1];
        
        // not cached
        id obj3 = [AMComponent messageModule];
        id obj4 = [AMComponent messageModule];
        
        expect(obj3).to(beAKindOf([MessageModule class]));
        expect(obj4).to(beAKindOf([MessageModule class]));
        expect(obj3).toNot(beIdenticalTo(obj4));
    });
    
    it(@"register different class prefix", ^ {
        
        id<MessageComponentInterface> amObj = [AMComponent message];
        expect(amObj).to(beAKindOf([AMMessageComponent class]));
        expect(amObj.unreadCount).to(equal(999));
        
        id<MessageComponentInterface> nonClassPrefixObj = [AMComponent messageModule];
        
        expect(nonClassPrefixObj).to(beAKindOf([MessageModule class]));
        expect(nonClassPrefixObj.unreadCount).to(equal(3));

        
        id<MessageComponentInterface> classPrefixObj = [AMComponent message];
        // because this target is cached
        expect(classPrefixObj).to(beIdenticalTo(amObj));
        
    });
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
    it(@"if release target is nil, it will not crash", ^ {
        
        expectAction(^ {[AMComponent releaseCachedTarget:nil];}).toNot(raiseException());
    });
    
    it(@"should return nil if target name is empty", ^ {
        
        id obj =
        [AMComponent targetWithName:@""
                        classPrefix:nil
                componentNameSuffix:nil
                        shouldCache:YES];
        
        expect(obj).to(beNil());
        
    });
    
#pragma clang diagnostic pop
    
});

QuickSpecEnd

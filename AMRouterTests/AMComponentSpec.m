//
//  AMComponentSpec.m
//  AMRouter
//
//  Created by archmagees on 2018/06/06.
//  Copyright © 2018 archmagees. All rights reserved.
//

@import Quick;
@import Nimble;
#import "AMComponent+Message.h"
#import "MessageModule.h"
#import "AMMessageComponent.h"

QuickSpecBegin(AMComponentSpec)

context(@"There is a component message", ^{
    it(@"should get notification status is YES", ^ {
        
        MessageModule *obj = [AMComponent message];
        expect(obj).to(beAKindOf([MessageModule class]));
        
        expect(obj.notificationEnabled).to(beTrue());
        expect(obj.unreadCount).to(equal(3));
        
    });
    
    it(@"should release the target after invoke method -release...", ^ {
        
        MessageModule *obj1 = [AMComponent message];
        MessageModule *obj2 = [AMComponent message];
        
        expect(obj1).to(beIdenticalTo(obj2));
        
        [AMComponent releaseCachedTarget:obj1];
        
        MessageModule *obj3 = [AMComponent message];
        expect(obj1).to(beAKindOf([MessageModule class]));
        expect(obj3).to(beAKindOf([MessageModule class]));
        expect(obj3).toNot(beIdenticalTo(obj1));
    });
    
    it(@"register different class prefix", ^ {
        
        AMMessageComponent *amObj = [AMComponent message];
        expect(amObj).to(beAKindOf([AMMessageComponent class]));
        expect(amObj.notificationEnabled).to(beFalse());
        
        MessageModule *nonClassPrefixObj = [AMComponent message];
        
        expect(nonClassPrefixObj).to(beAKindOf([MessageModule class]));
        
        [AMComponent releaseCachedTarget:nonClassPrefixObj];

        
        AMMessageComponent *classPrefixObj = [AMComponent message];
        expect(classPrefixObj).to(beIdenticalTo(amObj));
        
        expect(classPrefixObj.unreadCount).to(equal(999));
        
    });
    
});

QuickSpecEnd

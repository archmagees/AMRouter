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
#import "MessageComponent.h"
#import "AMMessageComponent.h"

QuickSpecBegin(AMComponentSpec)

context(@"There is a component message", ^{
    it(@"should get notification status is YES", ^ {
        
        MessageComponent *obj = [AMComponent message];
        expect(obj).to(beAKindOf([MessageComponent class]));
        
        expect(obj.notificationEnabled).to(beTrue());
        expect(obj.unreadCount).to(equal(3));
        
    });
    
    it(@"should release the target after invoke method -release...", ^ {
        
        MessageComponent *obj1 = [AMComponent message];
        MessageComponent *obj2 = [AMComponent message];
        
        expect(obj1).to(beIdenticalTo(obj2));
        
        [[AMComponent sharedInstance] releaseCachedTarget:@"Message"];
        
        MessageComponent *obj3 = [AMComponent message];
        expect(obj1).to(beAKindOf([MessageComponent class]));
        expect(obj3).to(beAKindOf([MessageComponent class]));
        expect(obj3).toNot(beIdenticalTo(obj1));
    });
    
    it(@"register different class prefix", ^ {
        
        [AMComponent registerClassPrefix:@"AM"];
        AMMessageComponent *amObj = [AMComponent message];
        expect(amObj).to(beAKindOf([AMMessageComponent class]));
        expect(amObj.notificationEnabled).to(beFalse());
        
        [AMComponent registerClassPrefix:@""];
        MessageComponent *nonClassPrefixObj = [AMComponent message];
        
        expect(nonClassPrefixObj).to(beAKindOf([MessageComponent class]));
        
        [[AMComponent sharedInstance] releaseCachedTarget:@"Message"];
        
        [AMComponent registerClassPrefix:@"AM"];
        
        AMMessageComponent *classPrefixObj = [AMComponent message];
        expect(classPrefixObj).to(beIdenticalTo(amObj));
        
        expect(classPrefixObj.unreadCount).to(equal(999));
        
    });
    
    it(@"should return nil", ^ {
       id obj = [AMComponent openUrl:@""
                            userInfo:nil
                          completion:nil];
        expect(obj).to(beNil());
    });
});

QuickSpecEnd

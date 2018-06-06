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

QuickSpecBegin(AMComponentSpec)

context(@"There is a component message", ^{
    it(@"should get notification status is YES", ^ {
        
        MessageComponent *obj = [AMComponent message];
        expect(obj).to(beAKindOf([MessageComponent class]));
        
        expect(obj.notificationEnabled).to(beTrue());
        
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
});

QuickSpecEnd

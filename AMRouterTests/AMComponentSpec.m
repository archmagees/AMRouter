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
});

QuickSpecEnd

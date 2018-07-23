//
//  AMComponent+Message.m
//  Example
//
//  Created by archmagees on 2018/06/05.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import "AMComponent+Message.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const kTargetName = @"Message";

@implementation AMComponent (Message)

+ (id<MessageComponentInterface>)message {
    return [self targetWithName:kTargetName
                    classPrefix:@"AM"
            componentNameSuffix:nil
                    shouldCache:YES];
}

+ (id<MessageComponentInterface>)messageModule {
    return [self targetWithName:kTargetName
                    classPrefix:nil
            componentNameSuffix:@"Module"
                    shouldCache:NO];
}

@end

NS_ASSUME_NONNULL_END

//
//  AMComponent+Message.h
//  Example
//
//  Created by archmagees on 2018/06/05.
//  Copyright © 2018 archmagees. All rights reserved.
//


#import "AMComponent.h"
#import "MessageComponentInterface.h"

@interface AMComponent (Message)

+ (id<MessageComponentInterface>)message;

@end

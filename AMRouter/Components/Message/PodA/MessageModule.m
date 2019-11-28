//
//  MessageModule.m
//  Example
//
//  Created by archmagees on 2018/06/05.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import "MessageModule.h"

static NSUInteger unreadCount = 3;

@implementation MessageModule

- (BOOL)notificationEnabled {
    return YES;
}

- (NSUInteger)unreadCount {
    return unreadCount;
}

- (void)increaseUnreadCount:(NSInteger)count {
    unreadCount += count;
}

@end

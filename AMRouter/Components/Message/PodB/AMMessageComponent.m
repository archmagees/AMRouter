//
//  AMMessageComponent.m
//  AMRouter
//
//  Created by archmagees on 2018/06/06.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import "AMMessageComponent.h"

static NSUInteger unreadCount = 999;

@implementation AMMessageComponent

- (BOOL)notificationEnabled {
    return NO;
}

- (NSUInteger)unreadCount {
    return unreadCount;
}

- (void)increaseUnreadCount:(NSInteger)count {
    
    unreadCount += count;
}

@end

//
//  MessageComponentInterface.h
//  Example
//
//  Created by archmagees on 2018/06/05.
//  Copyright © 2018 archmagees. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageComponentInterface <NSObject>

@required

- (BOOL)notificationEnabled;

- (NSUInteger)unreadCount;

- (void)increaseUnreadCount:(NSInteger)count;

@end

//
//  ARCSocketManager.h
//  SimpleChat
//
//  Created by Antonio Carella on 8/13/15.
//  Copyright (c) 2015 SuperflousJazzHands. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARCSocketManager : NSObject

+ (ARCSocketManager *)sharedInstance;
- (void)writeData:(NSData *)data;

@end

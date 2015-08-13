//
//  ARCSocketManager.m
//  SimpleChat
//
//  Created by Antonio Carella on 8/13/15.
//  Copyright (c) 2015 SuperflousJazzHands. All rights reserved.
//

#import "ARCSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface ARCSocketManager ()

@property (strong, nonatomic) GCDAsyncSocket *socket;

@end

@implementation ARCSocketManager

+ (ARCSocketManager *)sharedInstance{
    
    static ARCSocketManager *_sharedManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
    
}

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        if (self.socket == nil) {
            self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        }
        
        NSError *err = nil;
        if (![self.socket connectToHost:@"localhost" onPort:8080 error:&err]) // Asynchronous!
        {
            // If there was an error, it's likely something like "already connected" or "no delegate set"
            NSLog(@"Socket connection error: %@", err);
        }
        
    }
    
    return self;
}

- (void)socket:(GCDAsyncSocket *)sender didConnectToHost:(NSString *)host port:(UInt16)port {
    
    NSLog(@"Socket connected!");
}

- (void)socket:(GCDAsyncSocket *)sender didReadData:(NSData *)data withTag:(long)tag {

    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Data read: %@", dataString);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"com.superflousjazzhands.AutoComplete.newData" object:data];
    [self.socket readDataWithTimeout:-1 tag:1];
     
}

- (void)writeData:(NSData *)data{

    [self.socket writeData:data withTimeout:-1 tag:1];
    [self.socket readDataToData:[GCDAsyncSocket CRLFData] withTimeout:-1 tag:1];
    
}

- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{

    NSLog(@"Data with tag: %ld written", tag);
}

@end

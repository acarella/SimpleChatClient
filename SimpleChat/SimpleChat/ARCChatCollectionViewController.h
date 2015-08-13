//
//  ARCChatCollectionViewController.h
//  SimpleChat
//
//  Created by Antonio Carella on 8/13/15.
//  Copyright (c) 2015 SuperflousJazzHands. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATLBaseConversationViewController.h"

@interface ARCChatCollectionViewController : ATLBaseConversationViewController <ATLAddressBarViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) NSTimeInterval dateDisplayTimeInterval;
@property (nonatomic) BOOL marksMessagesAsRead;
@property (nonatomic) BOOL shouldDisplayAvatarItemForOneOtherParticipant;

@end

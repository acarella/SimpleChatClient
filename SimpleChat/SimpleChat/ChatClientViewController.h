//
//  ChatClientViewController.h
//  SimpleChat
//
//  Created by Antonio Carella on 8/12/15.
//  Copyright (c) 2015 SuperflousJazzHands. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatClientViewController : UIViewController <NSStreamDelegate, UITableViewDataSource, UITableViewDelegate> {

    NSInputStream *inputStream;
    NSOutputStream *outputStream;
    NSMutableArray * messages;

}

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendMessage;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

//
//  ChatClientViewController.m
//  SimpleChat
//
//  Created by Antonio Carella on 8/12/15.
//  Copyright (c) 2015 SuperflousJazzHands. All rights reserved.
//


#import "ChatClientViewController.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>
#import "ARCSocketManager.h"

@interface ChatClientViewController () <GCDAsyncSocketDelegate>

@property (strong, nonatomic) ARCSocketManager *socketManager;

@end

@implementation ChatClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    messages = [[NSMutableArray alloc] init];
    self.socketManager = [ARCSocketManager sharedInstance];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataRecievedFromServer:) name:@"com.superflousjazzhands.AutoComplete.newData" object:nil];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}


- (IBAction)sendMessage:(id)sender {

    NSData *data = [[NSData alloc] initWithData:[self.messageTextField.text dataUsingEncoding:NSASCIIStringEncoding]];
    [self.socketManager writeData:data];
    
}

- (void) dataRecievedFromServer:(NSNotification *)notifcation {
    
    NSData *newData = [notifcation object];
    NSString *newString = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
    
    [messages addObject:newString];
    [self.tableView reloadData];
    [self.messageTextField setText:@""];
    
}

#pragma mark - tableView delegate and datasource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ChatCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *s = (NSString *) [messages objectAtIndex:indexPath.row];
    cell.textLabel.text = s;
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"com.superflousjazzhands.AutoComplete.newData" object:nil];
}

@end

/******************************************************************************
 * Copyright (c) AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFRootTableViewController.h"
#import "LSFLightsTableViewController.h"
#import <LSFSDKLightingDirector.h>

@interface LSFRootTableViewController ()

@property (nonatomic) BOOL wasControllerConnected;

-(void)leaderModelChangedNotificationReceived:(NSNotification *)notification;
-(void)wifiNotificationReceived: (NSNotification *)notification;

@end

@implementation LSFRootTableViewController

@synthesize data = _data;
@synthesize wasControllerConnected = _wasControllerConnected;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];
    self.wasControllerConnected = [[[LSFSDKLightingDirector getLightingDirector] leadController] connected];

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(wifiNotificationReceived:) name: @"WifiNotification" object: nil];
}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];

    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * Notification Handlers
 */
-(void)leaderModelChangedNotificationReceived:(NSNotification *)notification
{
    LSFSDKController *leaderModel = [notification.userInfo valueForKey: @"leader"];
    BOOL connected = leaderModel.connected;

    if (connected != self.wasControllerConnected)
    {
        self.wasControllerConnected = connected;
        [self.data removeAllObjects];
        [self.tableView reloadData];
    }
}

-(void)wifiNotificationReceived: (NSNotification *)notification
{
    NSLog(@"LSFRootTableViewController - wifiNotificationReceived() executing");

    [self.data removeAllObjects];
    [self.tableView reloadData];
}

@end

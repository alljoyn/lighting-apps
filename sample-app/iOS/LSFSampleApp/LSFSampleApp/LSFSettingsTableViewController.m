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

#import "LSFSettingsTableViewController.h"
#import "LSFSettingsInfoViewController.h"
#import <LSFSDKLightingDirector.h>
#import <LSFSDKLightingController.h>

@interface LSFSettingsTableViewController ()

-(void)leaderModelChangedNotificationReceived: (NSNotification *)notification;
-(void)startBundledController;

@end

@implementation LSFSettingsTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];

    //Set controller notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];

    [self.controllerNameLabel setText: [NSString stringWithFormat: @"%@ (V%u)", [[[LSFSDKLightingDirector getLightingDirector] leadController] name], [[[LSFSDKLightingDirector getLightingDirector] leadController] version]]];

    if ([[LSFSDKLightingController getLightingController] isRunning])
    {
        self.startControllerLabel.text = @"Stop Controller";
    }
    else
    {
        self.startControllerLabel.text = @"Start Controller";
    }
}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];

    //Clear notification handler
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * ControllerNotification Handler
 */
-(void)leaderModelChangedNotificationReceived: (NSNotification *)notification
{
    LSFSDKController *leader = [notification.userInfo valueForKey: @"leader"];
    [self.controllerNameLabel setText: [NSString stringWithFormat: @"%@ (V%u)", leader.name, leader.version]];
}

/*
 * UITableViewDelegate Implementation
 */
-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    switch (indexPath.section)
    {
        case 1:
            [self performSegueWithIdentifier: @"ScenesSettingInfo" sender: cell]; //reuseIdentifier = sourceCodeInfoCell
            break;
        case 2:
            [self performSegueWithIdentifier: @"ScenesSettingInfo" sender: cell]; //reuseIdentifier = teamInfoCell
            break;
        case 3:
            [self performSegueWithIdentifier: @"ScenesSettingInfo" sender: cell]; //reuseIdentifier = noticeInfoCell
            break;
        case 4:
            [self startBundledController];
            [self.tableView deselectRowAtIndexPath: indexPath animated: YES];
        default:
            break;
    }
}

/*
 * Segue Method Implementation
 */
-(void)prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([segue.identifier isEqualToString: @"ScenesSettingInfo"])
    {
        NSString *cellIdentifier = [(UITableViewCell*)sender reuseIdentifier];
        LSFSettingsInfoViewController *ssivc = [segue destinationViewController];
        if ([cellIdentifier isEqualToString:@"sourceCodeInfoCell"])
        {
            ssivc.title = @"Source Code";
            ssivc.inputText = @"SourceCode";
        }
        else if ([cellIdentifier isEqualToString:@"teamInfoCell"])
        {
            ssivc.title = @"Team";
            ssivc.inputText = @"Team";
        }
        else if ([cellIdentifier isEqualToString:@"noticeInfoCell"])
        {
            ssivc.title = @"Notice";
            ssivc.inputText = @"Notice";
        }

    }
}

-(void)startBundledController
{
    if ([self.startControllerLabel.text isEqualToString: @"Start Controller"])
    {
        NSLog(@"Starting Controller...");
        self.startControllerLabel.text = @"Stop Controller";
        [[LSFSDKLightingController getLightingController] start];
    }
    else
    {
        NSLog(@"Stopping Controller...");
        self.startControllerLabel.text = @"Start Controller";
        [[LSFSDKLightingController getLightingController] stop];
    }
}

@end

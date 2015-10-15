/******************************************************************************
 *  * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFSettingsTableViewController.h"
#import "LSFSettingsInfoViewController.h"
#import "LSFScenesV1ModuleProxy.h"
#import <LSFSDKLightingDirector.h>
#import <LSFSDKLightingController.h>

@interface LSFSettingsTableViewController ()

-(void)leaderModelChangedNotificationReceived: (NSNotification *)notification;

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

    // scenes v1 installed? label
    [self.scenesV1ModuleLabel setText: ([[[LSFScenesV1ModuleProxy getProxy] scenesV1Delegate] isInstalled] ? @"Installed" : @"Not Installed")];

    // controller label
    [self.controllerNameLabel setText: [NSString stringWithFormat: @"%@", [[[LSFSDKLightingDirector getLightingDirector] leadController] name]]];

    if ([[LSFSDKLightingController getLightingController] isRunning])
    {
        [self.controllerNameLabel setText: [NSString stringWithFormat: @"%@ (V%u)", self.controllerNameLabel.text, [[[LSFSDKLightingDirector getLightingDirector] leadController] version]]];

        self.controllerOnOffSwitch.on = YES;
    }
    else
    {
        self.controllerOnOffSwitch.on = NO;
    }

    self.isLeaderLabel.text = ([[LSFSDKLightingController getLightingController] isLeader]) ? @"true" : @"false";

    self.myControllerNameLabel.text = [[LSFSDKLightingController getLightingController] name];
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

-(IBAction)controllerSwitchValueChanged: (id)sender
{
    if ([sender isOn])
    {
        NSLog(@"Starting Controller...");
        [[LSFSDKLightingController getLightingController] start];
    }
    else
    {
        NSLog(@"Stopping Controller...");
        [[LSFSDKLightingController getLightingController] stop];
    }
}

/*
 * ControllerNotification Handler
 */
-(void)leaderModelChangedNotificationReceived: (NSNotification *)notification
{
    LSFSDKController *leader = [notification.userInfo valueForKey: @"leader"];

    if ([leader connected])
    {
        [self.controllerNameLabel setText: [NSString stringWithFormat: @"%@ (V%u)", leader.name, leader.version]];
        self.isLeaderLabel.text = ([[LSFSDKLightingController getLightingController] isLeader]) ? @"true" : @"false";
    }
    else
    {
        [self.controllerNameLabel setText: [NSString stringWithFormat: @"%@", leader.name]];
        self.isLeaderLabel.text = @"false";
    }
}

/*
 * UITableViewDelegate Implementation
 */
-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    switch (indexPath.section)
    {
        case 2:
        case 3:
        case 4:
            [self performSegueWithIdentifier: @"ScenesSettingInfo" sender: cell]; //reuseIdentifier = sourceCodeInfoCell
            break;
        case 5:
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

@end
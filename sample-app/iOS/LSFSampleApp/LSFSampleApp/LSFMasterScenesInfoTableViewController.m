/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFMasterScenesInfoTableViewController.h"
#import "LSFMasterSceneMembersTableViewController.h"
#import "LSFMasterScenesChangeNameViewController.h"
#import <LSFSDKLightingDirector.h>

@interface LSFMasterScenesInfoTableViewController ()

-(void)leaderModelChangedNotificationReceived:(NSNotification *)notification;
-(void)masterSceneChangedNotificationReceived: (NSNotification *)notification;
-(void)masterSceneRemovedNotificationReceived: (NSNotification *)notification;
-(void)alertMasterSceneDeleted: (LSFSDKMasterScene *)masterScene;

@end

@implementation LSFMasterScenesInfoTableViewController

@synthesize masterSceneID = _masterSceneID;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];

    if (![[[LSFSDKLightingDirector getLightingDirector] leadController] connected])
    {
        [self.navigationController popToRootViewControllerAnimated: NO];
    }

    //Set master scenes notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(masterSceneChangedNotificationReceived:) name: @"LSFMasterSceneChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(masterSceneRemovedNotificationReceived:) name: @"LSFMasterSceneRemovedNotification" object: nil];

    [self.tableView reloadData];
}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];

    //Clear scenes and master scenes notification handler
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
    if (![leaderModel connected])
    {
        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

-(void)masterSceneChangedNotificationReceived:(NSNotification *)notification
{
    LSFSDKMasterScene *masterScene = [notification.userInfo valueForKey: @"masterScene"];

    if ([self.masterSceneID isEqualToString: [masterScene theID]])
    {
        [self.tableView reloadData];
    }
}

-(void)masterSceneRemovedNotificationReceived:(NSNotification *)notification
{
    LSFSDKMasterScene *masterScene = [notification.userInfo valueForKey: @"masterScene"];

    if ([self.masterSceneID isEqualToString: [masterScene theID]])
    {
        [self alertMasterSceneDeleted: masterScene];
    }
}

-(void)alertMasterSceneDeleted: (LSFSDKMasterScene *)masterScene
{
    [self.navigationController popToRootViewControllerAnimated: YES];

    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Master Scene Not Found"
                                                        message: [NSString stringWithFormat: @"The master scene \"%@\" no longer exists.", [masterScene name]]
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    });
}

/*
 * UITableViewDataSource Implementation
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LSFSDKMasterScene *masterScene = [[LSFSDKLightingDirector getLightingDirector] getMasterSceneWithID: self.masterSceneID];
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: nil];
        cell.textLabel.text = @"Master Scene Name";
        cell.detailTextLabel.text = [masterScene name];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: nil];
        cell.textLabel.text = @"Scenes in the master scene";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}

-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self performSegueWithIdentifier: @"ChangeMasterSceneName" sender: nil];
    }
    else if (indexPath.section == 1)
    {
        [self performSegueWithIdentifier: @"ModifySceneMembers" sender: nil];
    }
}

/*
 * Segue Function
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"ModifySceneMembers"])
    {
        UINavigationController *nc = (UINavigationController *)[segue destinationViewController];
        LSFMasterSceneMembersTableViewController *msmtvc = (LSFMasterSceneMembersTableViewController *)nc.topViewController;

        LSFPendingScene *pendingMasterScene = [[LSFPendingScene alloc] init];
        pendingMasterScene.theID = self.masterSceneID;
        pendingMasterScene.memberIDs = [[[[LSFSDKLightingDirector getLightingDirector] getMasterSceneWithID: self.masterSceneID] getScenes] valueForKeyPath: @"theID"];
        msmtvc.pendingMasterScene = pendingMasterScene;

        msmtvc.usesCancel = YES;
    }
    else if ([segue.identifier isEqualToString: @"ChangeMasterSceneName"])
    {
        LSFMasterScenesChangeNameViewController *mscnvc = [segue destinationViewController];
        mscnvc.masterSceneID = self.masterSceneID;
    }
}

@end
/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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

#import "LSFGroupsPresetsTableViewController.h"
#import "LSFGroupsCreatePresetViewController.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>
#import <LSFSDKMyLampState.h>

@interface LSFGroupsPresetsTableViewController ()

@property (nonatomic, strong) NSArray *presetData;
@property (nonatomic, strong) NSMutableArray *presetDataSorted;

-(void)leaderModelChangedNotificationReceived:(NSNotification *)notification;
-(void)groupChangedNotificationReceived: (NSNotification *)notification;
-(void)groupRemovedNotificationReceived: (NSNotification *)notification;
-(void)presetNotificationReceived: (NSNotification *)notification;
-(void)reloadPresets;
-(BOOL)checkIfGroup: (LSFSDKGroup *) group matchesPreset: (LSFSDKPreset *) preset;

@end

@implementation LSFGroupsPresetsTableViewController

@synthesize groupID = _groupID;
@synthesize presetData = _presetData;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    //Set notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(groupChangedNotificationReceived:) name: @"LSFGroupChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(groupRemovedNotificationReceived:) name: @"LSFGroupRemovedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(presetNotificationReceived:) name: @"LSFPresetChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(presetNotificationReceived:) name: @"LSFPresetRemovedNotification" object: nil];

    [self reloadPresets];
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

-(void)groupChangedNotificationReceived: (NSNotification *)notification
{
    LSFSDKGroup *group = [notification.userInfo valueForKey: @"group"];

    if ([self.groupID isEqualToString: [group theID]])
    {
        [self reloadPresets];
    }
}

-(void)groupRemovedNotificationReceived: (NSNotification *)notification
{
    LSFSDKGroup *group = [notification.userInfo valueForKey: @"group"];

    if ([self.groupID isEqualToString: [group theID]])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Group Not Found"
                                                        message: [NSString stringWithFormat: @"The group \"%@\" no longer exists.", [group name]]
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];

        [self.navigationController popToRootViewControllerAnimated: YES];
    }
}

-(void)presetNotificationReceived: (NSNotification *)notification
{
    [self reloadPresets];
}

-(void)reloadPresets
{
    self.presetData = [[LSFSDKLightingDirector getLightingDirector] presets];
    [self sortPresetData];
    [self filterPresetData];

    [self.tableView reloadData];
}

/*
 * UITableViewDataSource Implementation
 */
-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"Save New Preset";
        cell.textLabel.textColor = [UIColor colorWithRed: 0 green: 0.478431 blue: 1.0 alpha: 1.0];
        return cell;
    }
    else
    {
        LSFSDKPreset *preset = [self.presetDataSorted objectAtIndex: [indexPath row]];
        LSFSDKGroup *group = [[LSFSDKLightingDirector getLightingDirector] getGroupWithID: self.groupID];
        BOOL stateMatchesPreset = [self checkIfGroup: group matchesPreset: preset];

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"GroupPresetCell" forIndexPath: indexPath];
        cell.textLabel.text = [preset name];

        if (stateMatchesPreset)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }

        return cell;
    }
}

-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self performSegueWithIdentifier: @"SaveGroupPreset" sender: nil];
        return;
    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];

    if (cell != nil)
    {
        if (cell.accessoryType == UITableViewCellAccessoryNone)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;

            LSFSDKPreset *preset = [self.presetDataSorted objectAtIndex: [indexPath row]];

            dispatch_async([[[LSFSDKLightingDirector getLightingDirector] lightingManager] dispatchQueue], ^{
                LSFSDKGroup *group = [[LSFSDKLightingDirector getLightingDirector] getGroupWithID: self.groupID];
                [group applyPreset: preset];
            });

            [self.navigationController popViewControllerAnimated: YES];
        }
        else
        {
            [self.navigationController popViewControllerAnimated: YES];
        }
    }
    else
    {
        //NSLog(@"Cell is nil");
    }
}

-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView: (UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return self.presetDataSorted.count;
    }
}

-(NSString *)tableView: (UITableView *)tableView titleForHeaderInSection: (NSInteger)section
{
    if (section == 1)
    {
        if (![self tableView:self.tableView numberOfRowsInSection:1])
        {
            return @"No presets have been saved yet";
        }
        else
        {
            return @"Presets";
        }
    }

    return @" ";
}

-(BOOL)tableView: (UITableView *)tableView canEditRowAtIndexPath: (NSIndexPath *)indexPath
{
    return indexPath.section == 1 ? YES : NO;
}

-(void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.presetDataSorted removeObjectAtIndex: indexPath.row];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        LSFSDKPreset *preset = [self.presetDataSorted objectAtIndex: [indexPath row]];

        dispatch_async([[[LSFSDKLightingDirector getLightingDirector] lightingManager] dispatchQueue], ^{
            [preset deleteItem];
        });
    }
}

-(CGFloat)tableView: (UITableView *)tableView heightForHeaderInSection: (NSInteger)section
{
    if (section == 0)
    {
        return 20.0f;
    }

    return UITableViewAutomaticDimension;
}

/*
 * Private functions
 */
-(BOOL)checkIfGroup: (LSFSDKGroup *) group matchesPreset: (LSFSDKPreset *) preset
{
    BOOL returnValue = NO;

    LSFSDKColor *groupColor = [group getColor];
    LSFSDKColor *presetColor = [preset getColor];

    if ([group getPowerOn] == [preset getPowerOn] && [groupColor hue] == [presetColor hue] &&
        [groupColor saturation] == [presetColor saturation] && [groupColor brightness] == [presetColor brightness] &&
        [groupColor colorTemp] == [presetColor colorTemp])
    {
        returnValue = YES;
    }

    return returnValue;
}

-(void)sortPresetData
{
    self.presetDataSorted = [[NSMutableArray alloc] initWithArray: [self.presetData sortedArrayUsingComparator: ^NSComparisonResult(id a, id b) {
        NSString *first = [(LSFSDKPreset *)a name];
        NSString *second = [(LSFSDKPreset *)b name];
        return [first localizedCaseInsensitiveCompare: second];
    }]];
}

-(void)filterPresetData
{
    NSMutableArray *presetsToRemove = [[NSMutableArray alloc] init];

    for (LSFSDKPreset *preset in self.presetDataSorted)
    {
        if ([preset.name hasPrefix: PRESET_NAME_PREFIX])
        {
            [presetsToRemove addObject: preset];
        }
    }

    for (LSFSDKPreset *preset in presetsToRemove)
    {
        [self.presetDataSorted removeObject: preset];
    }
}

/*
 * Segue Function
 */
- (void)prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([segue.identifier isEqualToString: @"SaveGroupPreset"])
    {
        LSFGroupsCreatePresetViewController *gcpvc = [segue destinationViewController];
        
        LSFSDKGroup *group = [[LSFSDKLightingDirector getLightingDirector] getGroupWithID: self.groupID];
        LSFSDKMyLampState *lampState = [[LSFSDKMyLampState alloc] initWithPower:[group getPower] color: [group getColor]];
        gcpvc.lampState = lampState;
        gcpvc.groupID = self.groupID;
    }
}

@end
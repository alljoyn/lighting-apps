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

#import "LSFSelectPresetTableViewController.h"
#import "LSFSavePresetViewController.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>

@interface LSFSelectPresetTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation LSFSelectPresetTableViewController

@synthesize state = _state;
@synthesize data = _data;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(presetNotificatioReceieved:) name: @"LSFPresetChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(presetNotificatioReceieved:) name: @"LSFPresetRemovedNotification" object: nil];

    [self loadPresets];
}

-(NSInteger)numberOfSectionsInTableView: (UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return section == 0 ? 1 : [self.data count];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 1 ? YES : NO;
}

-(NSString *)tableView: (UITableView *)tableView titleForHeaderInSection: (NSInteger)section
{
    if (section == 1)
    {
        if (![self tableView: self.tableView numberOfRowsInSection:1])
        {
            return @"No presets have been saved yet";
        }
        else
        {
            return @"Presets";
        }
    }

    return @"";
}

-(UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = @"Save New Preset";
        cell.textLabel.textColor  = [UIColor colorWithRed: 0 green: 0.478431 blue: 1.0 alpha: 1.0];

        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Preset" forIndexPath:indexPath];

        LSFSDKPreset *preset = [self.data objectAtIndex: [indexPath row]];
        cell.textLabel.text = preset.name;
        cell.accessoryType = [LSFUtilityFunctions preset: preset matchesMyLampState: self.state] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

        return cell;
    }
}

-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self performSegueWithIdentifier: @"SavePreset" sender: self];
    }
    else
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];

        if (cell.accessoryType == UITableViewCellAccessoryNone)
        {
            LSFSDKPreset *preset = [self.data objectAtIndex: indexPath.row];

            self.state.color = [preset getColor];
            self.state.power = [preset getPower];
        }

        [self.navigationController popViewControllerAnimated: YES];
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


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        LSFSDKPreset *preset = [self.data objectAtIndex: indexPath.row];

        [self.data removeObjectAtIndex: indexPath.row];

        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            [preset deleteItem];
        });
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"SavePreset"])
    {
        LSFSavePresetViewController *spvc = [segue destinationViewController];
        spvc.lampState = self.state;
    }
}

-(void)loadPresets
{
    NSArray *allPresets = [self sortByNameProperty: [[LSFSDKLightingDirector getLightingDirector] presets]];
    self.data = [[NSMutableArray alloc] init];

    for (LSFSDKPreset *preset in allPresets)
    {
        if (![preset.name hasPrefix: PRESET_NAME_PREFIX])
        {
            [self.data addObject: preset];
        }
    }
}

-(NSArray *)sortByNameProperty: (NSArray *)array
{
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES comparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 compare:(NSString *)obj2 options:NSCaseInsensitiveSearch];
    }];

    return [array sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
}

-(void)presetNotificatioReceieved: (NSNotification *)notification
{
    [self loadPresets];
    [self.tableView reloadData];
}

@end
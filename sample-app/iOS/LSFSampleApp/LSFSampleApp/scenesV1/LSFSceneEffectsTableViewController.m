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

#import "LSFSceneEffectsTableViewController.h"
#import "LSFNoEffectTableViewController.h"
#import "LSFTransitionEffectTableViewController.h"
#import "LSFPulseEffectTableViewController.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>

@interface LSFSceneEffectsTableViewController ()

@property (nonatomic, strong) NSIndexPath *selectedIndex;

-(void)leaderModelChangedNotificationReceived: (NSNotification *)notification;
-(void)sceneRemovedNotificationReceived: (NSNotification *)notification;
-(void)alertSceneDeleted: (LSFSDKScene *)scene;

@end

@implementation LSFSceneEffectsTableViewController

@synthesize selectedIndex = _selectedIndex;
@synthesize sceneModel = _sceneModel;
@synthesize sceneElement = _sceneElement;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];

    //Set notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneRemovedNotificationReceived:) name: @"LSFSceneRemovedNotification" object: nil];
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

-(void)sceneRemovedNotificationReceived:(NSNotification *)notification
{
    LSFSDKScene *scene = [notification.userInfo valueForKey: @"scene"];

    if ([self.sceneModel.theID isEqualToString: scene.theID])
    {
        [self alertSceneDeleted: scene];
    }
}

-(void)alertSceneDeleted: (LSFSDKScene *)scene
{
    [self dismissViewControllerAnimated: NO completion: nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Scene Not Found"
                                                        message: [NSString stringWithFormat: @"The scene \"%@\" no longer exists.", [scene name]]
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    });
}

/*
 * UITableViewDataSource Implementation
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"EffectCells" forIndexPath:indexPath];
    cell.textLabel.text = [[LSFUtilityFunctions getSupportedEffects] objectAtIndex: [indexPath row]];
    cell.imageView.image = [UIImage imageNamed: [[LSFUtilityFunctions getEffectImages] objectAtIndex: [indexPath row]]];

    if (indexPath.row == 0)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedIndex = indexPath;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

-(void)tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (![self.selectedIndex isEqual: indexPath])
    {
        UITableViewCell *previousSelectedCell = [tableView cellForRowAtIndexPath: self.selectedIndex];
        previousSelectedCell.accessoryType = UITableViewCellAccessoryNone;
        [self.tableView deselectRowAtIndexPath: self.selectedIndex animated: NO];
    }

    if ([self.selectedIndex isEqual: indexPath])
    {
        //self.selectedIndex = nil;
        [self.tableView deselectRowAtIndexPath: self.selectedIndex animated: NO];
    }
    else
    {
        UITableViewCell* cell = [tableView cellForRowAtIndexPath: indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.tableView deselectRowAtIndexPath: indexPath animated: NO];
        self.selectedIndex = indexPath;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat: @"Choose an optional effect for %@", [self buildSectionTitleString: self.sceneElement]];
}

-(NSString *)buildSectionTitleString: (LSFSceneElementDataModel *)sceneElement
{
    BOOL firstElementFound = NO;
    NSMutableString *titleString = [[NSMutableString alloc] initWithString: @""];

    for (int i = 0; !firstElementFound && i < sceneElement.members.lampGroups.count; i++)
    {
        NSString *lampGroupID = [sceneElement.members.lampGroups objectAtIndex: i];
        LSFSDKGroup *group = [[LSFSDKLightingDirector getLightingDirector] getGroupWithID: lampGroupID];

        if (group != nil)
        {
            [titleString appendFormat: @"\"%@\"", group.name];
            firstElementFound = YES;
        }
    }

    for (int i = 0; !firstElementFound && i < sceneElement.members.lamps.count; i++)
    {
        NSString *lampID = [sceneElement.members.lamps objectAtIndex: i];
        LSFSDKLamp *lamp = [[LSFSDKLightingDirector getLightingDirector] getLampWithID: lampID];

        if (lamp != nil)
        {
            [titleString appendFormat: @"\"%@\"", lamp.name];
            firstElementFound = YES;
        }
    }

    unsigned int remainingSceneMembers = (unsigned int)(sceneElement.members.lamps.count + sceneElement.members.lampGroups.count - 1);

    if (remainingSceneMembers > 0)
    {
        [titleString appendFormat: @" (and %u more)", remainingSceneMembers];
    }

    return [NSString stringWithString: titleString];
}

/*
 * Button event handler
 */
-(IBAction)nextButtonPressed: (id)sender
{
    switch (self.selectedIndex.row)
    {
        case 0:
            [self performSegueWithIdentifier: @"NoEffect" sender: self];
            break;
        case 1:
            [self performSegueWithIdentifier: @"TransitionEffect" sender: self];
            break;
        case 2:
            [self performSegueWithIdentifier: @"PulseEffect" sender: self];
            break;
    }
}

/*
 * Segue method
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"NoEffect"])
    {
        LSFNoEffectDataModel *nedm = [[LSFNoEffectDataModel alloc] init];
        nedm.members = self.sceneElement.members;
        nedm.capability = self.sceneElement.capability;
        nedm.colorTempMin = self.sceneElement.colorTempMin;
        nedm.colorTempMax = self.sceneElement.colorTempMax;

        LSFNoEffectTableViewController *netvc = [segue destinationViewController];
        netvc.sceneModel = self.sceneModel;
        netvc.nedm = nedm;
        netvc.shouldUpdateSceneAndDismiss = NO;
    }
    else if ([segue.identifier isEqualToString: @"TransitionEffect"])
    {
        LSFTransitionEffectDataModel *tedm = [[LSFTransitionEffectDataModel alloc] init];
        tedm.members = self.sceneElement.members;
        tedm.capability = self.sceneElement.capability;
        tedm.colorTempMin = self.sceneElement.colorTempMin;
        tedm.colorTempMax = self.sceneElement.colorTempMax;

        LSFTransitionEffectTableViewController *tetvc = [segue destinationViewController];
        tetvc.sceneModel = self.sceneModel;
        tetvc.tedm = tedm;
        tetvc.shouldUpdateSceneAndDismiss = NO;
    }
    else if ([segue.identifier isEqualToString: @"PulseEffect"])
    {
        LSFPulseEffectDataModel *pedm = [[LSFPulseEffectDataModel alloc] init];
        pedm.members = self.sceneElement.members;
        pedm.capability = self.sceneElement.capability;
        pedm.colorTempMin = self.sceneElement.colorTempMin;
        pedm.colorTempMax = self.sceneElement.colorTempMax;

        LSFPulseEffectTableViewController *petvc = [segue destinationViewController];
        petvc.sceneModel = self.sceneModel;
        petvc.pedm = pedm;
        petvc.shouldUpdateSceneAndDismiss = NO;
    }
}

@end
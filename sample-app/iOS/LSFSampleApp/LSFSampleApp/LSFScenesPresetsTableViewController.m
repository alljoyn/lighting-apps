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

#import "LSFScenesPresetsTableViewController.h"
#import "LSFScenesCreatePresetViewController.h"
#import "LSFNoEffectTableViewController.h"
#import "LSFTransitionEffectTableViewController.h"
#import "LSFPulseEffectTableViewController.h"
#import <LSFSDKLightingDirector.h>

@interface LSFScenesPresetsTableViewController ()

@property (nonatomic, strong) NSArray *presetData;
@property (nonatomic, strong) NSArray *presetDataSorted;

-(void)leaderModelChangedNotificationReceived: (NSNotification *)notification;
-(void)sceneRemovedNotificationReceived: (NSNotification *)notification;
-(void)alertSceneDeleted: (LSFSDKScene *)scene;
-(void)presetNotificationReceived: (NSNotification *)notification;

@end

@implementation LSFScenesPresetsTableViewController

@synthesize sceneID = _sceneID;
@synthesize myLampState = _myLampState;
@synthesize effectSender = _effectSender;
@synthesize endStateFlag = _endStateFlag;

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
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(presetNotificationReceived:) name: @"LSFPresetChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(presetNotificationReceived:) name: @"LSFPresetRemovedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneRemovedNotificationReceived:) name: @"LSFSceneRemovedNotification" object: nil];

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

-(void)sceneRemovedNotificationReceived:(NSNotification *)notification
{
    LSFSDKScene *scene = [notification.userInfo valueForKey: @"scene"];

    if ([self.sceneID isEqualToString: scene.theID])
    {
        [self alertSceneDeleted: scene];
    }
}

-(void)presetNotificationReceived: (NSNotification *)notification
{
    [self reloadPresets];
}

-(void)alertSceneDeleted: (LSFSDKScene *)scene
{
    [self dismissViewControllerAnimated: NO completion: nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Scene Not Found"
                                                        message: [NSString stringWithFormat: @"The scene \"%@\" no longer exists.", scene.name]
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    });
}

-(void)reloadPresets
{
    self.presetData = [[LSFSDKLightingDirector getLightingDirector] presets];
    [self sortPresetData];
    [self.tableView reloadData];
}

/*
 * UITableViewDataSource Implementation
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
        BOOL stateMatchesPreset = [self checkIfPreset: preset matchesPower: self.myLampState.power andColor: self.myLampState.color];

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"ScenePresetCell" forIndexPath:indexPath];
        cell.textLabel.text = preset.name;

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
        [self performSegueWithIdentifier: @"SaveScenePreset" sender: nil];
        return;
    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];

    if (cell != nil)
    {
        if (cell.accessoryType == UITableViewCellAccessoryNone)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;

            LSFSDKPreset *preset = [self.presetDataSorted objectAtIndex: [indexPath row]];
            LSFSDKColor *presetColor = [preset getColor];
            LSFLampState *lampState = [[LSFLampState alloc] initWithOnOff: preset.getPowerOn brightness: presetColor.brightness hue: presetColor.hue saturation: presetColor.saturation colorTemp: presetColor.colorTemp];

            if([self.effectSender isKindOfClass:[LSFNoEffectTableViewController class]])
            {
                ((LSFNoEffectTableViewController*)self.effectSender).nedm.state = lampState;
            }
            else if ([self.effectSender isKindOfClass:[LSFTransitionEffectTableViewController class]])
            {
                ((LSFTransitionEffectTableViewController*)self.effectSender).tedm.state = lampState;
            }
            else if ([self.effectSender isKindOfClass:[LSFPulseEffectTableViewController class]])
            {
                if (self.endStateFlag)
                {
                    ((LSFPulseEffectTableViewController*)self.effectSender).pedm.endState = lampState;
                }
                else
                {
                    ((LSFPulseEffectTableViewController*)self.effectSender).pedm.state = lampState;
                }
            }

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

/*
 * UITableViewDataSource Implementation
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return [[LSFSDKLightingDirector getLightingDirector] presetCount];
    }
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
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            LSFSDKPreset *preset = [self.presetDataSorted objectAtIndex: [indexPath row]];
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

-(BOOL)checkIfPreset: (LSFSDKPreset *)preset matchesPower: (Power)power andColor: (LSFSDKColor *) color
{
    BOOL returnValue = NO;

    LSFSDKColor *presetColor = [preset getColor];

    if (power == [preset getPower] && [color hue] == [presetColor hue] &&
        [color saturation] == [presetColor saturation] && [color brightness] == [presetColor brightness] &&
        [color colorTemp] == [presetColor colorTemp])
    {
        returnValue = YES;
    }

    return returnValue;
}

-(void)sortPresetData
{
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES comparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString *)obj1 compare:(NSString *)obj2 options:NSCaseInsensitiveSearch];
    }];
    self.presetDataSorted = [self.presetData sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDesc]];
}

/*
 * Segue Function
 */
- (void)prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender
{
    if ([segue.identifier isEqualToString: @"SaveScenePreset"])
    {
        LSFScenesCreatePresetViewController *scpvc = [segue destinationViewController];
        scpvc.lampState = self.myLampState;
        scpvc.sceneID = self.sceneID;
    }
}

@end

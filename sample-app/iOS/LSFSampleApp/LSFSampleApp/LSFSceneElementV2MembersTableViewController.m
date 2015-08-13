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

#import "LSFSceneElementV2MembersTableViewController.h"
#import "LSFEffectsV2TableViewController.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>

@interface LSFSceneElementV2MembersTableViewController ()

@end

@implementation LSFSceneElementV2MembersTableViewController

@synthesize pendingSceneElement = _pendingSceneElement;
@synthesize hasDoneButton = _hasDoneButton;
@synthesize hasNextButton = _hasNextButton;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];

    if (self.hasDoneButton)
    {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: @"Done" style: UIBarButtonItemStyleDone target: self action: @selector(doneButtonPressed)];

        self.navigationItem.rightBarButtonItem = doneButton;
    }

    if (self.hasNextButton)
    {
        UIBarButtonItem *nextButton = [[UIBarButtonItem alloc]
                                        initWithTitle: @"Next"
                                        style: UIBarButtonItemStylePlain
                                        target: self
                                        action: @selector(nextButtonPressed)];

        self.navigationItem.rightBarButtonItem = nextButton;
    }
}

-(void)buildTable
{
    [self.data addObjectsFromArray: [LSFUtilityFunctions sortLightingItemsByName: [[LSFSDKLightingDirector getLightingDirector] groups]]];
    [self.data addObjectsFromArray: [LSFUtilityFunctions sortLightingItemsByName: [[LSFSDKLightingDirector getLightingDirector] lamps]]];

    NSUInteger allLampsIndex = -1;
    for (int i = 0; i < self.data.count; i++)
    {
        LSFSDKGroupMember *member = [self.data objectAtIndex: i];

        if ([member isKindOfClass: [LSFSDKGroup class]])
        {
            if ([((LSFSDKGroup *)member) isAllLampsGroup])
            {
                allLampsIndex = i;
            }
        }
    }

    if (allLampsIndex != -1)
    {
        [self.data removeObjectAtIndex: allLampsIndex];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SceneElementMember" forIndexPath:indexPath];
    LSFSDKGroupMember *member = [self.data objectAtIndex: [indexPath row]];

    cell.textLabel.text = member.name;

    if ([member isKindOfClass: [LSFSDKLamp class]])
    {
        cell.imageView.image = [UIImage imageNamed: @"lamps_off_icon.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed: @"groups_off_icon.png"];
    }

    if ([self.pendingSceneElement.members containsObject: member])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedRows addObject: indexPath];
    }

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Select the Lamps in this Scene Element";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"SceneElementEffect"])
    {
        LSFEffectsV2TableViewController *etvc = [segue destinationViewController];
        etvc.pendingSceneElement = self.pendingSceneElement;
    }
}

-(void)doneButtonPressed
{
    if (self.pendingSceneElement.theID != nil)
    {
        if ([self processSelections])
        {
            LSFSDKSceneElement *element = [[LSFSDKLightingDirector getLightingDirector] getSceneElementWithID: self.pendingSceneElement.theID];
            [element modifyWithEffect: self.pendingSceneElement.effect groupMembers: self.pendingSceneElement.members];

            [self dismissViewControllerAnimated: YES completion: nil];
        }
    }
}

-(void)nextButtonPressed
{
    if ([self processSelections])
    {
        [self performSegueWithIdentifier: @"SceneElementEffect" sender: self];
    }
}

-(BOOL)processSelections
{
    if (self.selectedRows.count > 0)
    {
        self.pendingSceneElement.members = [[NSMutableArray alloc] init];
        self.pendingSceneElement.capability = [[LSFSDKCapabilityData alloc] init];
        for (NSIndexPath *indexPath in self.selectedRows)
        {
            LSFSDKGroupMember *member = [self.data objectAtIndex: indexPath.row];
            [self.pendingSceneElement.members addObject: member];
            [self.pendingSceneElement.capability includeData: [member getCapabilities]];

            if ([member isKindOfClass: [LSFSDKLamp class]])
            {
                self.pendingSceneElement.hasEffect = self.pendingSceneElement.hasEffect || ((LSFSDKLamp *)member).details.hasEffects;
            }
            else if ([member isKindOfClass: [LSFSDKGroup class]])
            {
                for (LSFSDKLamp *lamp in [((LSFSDKGroup *) member) getLamps])
                {
                    self.pendingSceneElement.hasEffect = self.pendingSceneElement.hasEffect || lamp.details.hasEffects;
                }
            }
        }

        return YES;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Scene Element Error"
                                                        message: [NSString stringWithFormat: @"Error you must select at least one lamp or group to be part of the Scene Element"]
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];

        return NO;
    }
}

@end

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

#import "LSFScenesV2Members.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>

@interface LSFScenesV2Members ()

@end

@implementation LSFScenesV2Members

@synthesize pendingScene = _pendingScene;

-(void)buildTable
{
    [self.data addObjectsFromArray: [LSFUtilityFunctions sortLightingItemsByName: [[LSFSDKLightingDirector getLightingDirector] sceneElements]]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"SceneMember" forIndexPath:indexPath];
    LSFSDKSceneElement *element = [self.data objectAtIndex: [indexPath row]];
    cell.textLabel.text = [element name];

    if ([self.pendingScene.membersSceneElements containsObject: element])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedRows addObject: indexPath];
    }

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Select the Scene Elements in this Scene";
}

-(IBAction)doneButtonPressed:(id)sender
{
    NSLog(@"Done button pressed");

    if ([self processSelections])
    {
        if (self.pendingScene.theID == nil)
        {
            [[LSFSDKLightingDirector getLightingDirector] createSceneWithSceneElements: self.pendingScene.membersSceneElements name: self.pendingScene.name];
        }
        else
        {
            LSFSDKScene *scene = [[LSFSDKLightingDirector getLightingDirector] getSceneWithID: self.pendingScene.theID];
            if ([scene isKindOfClass: [LSFSDKSceneV2 class]])
            {
                LSFSDKSceneV2 *sceneV2 = (LSFSDKSceneV2 *)scene;
                [sceneV2 modify: self.pendingScene.membersSceneElements];
            }
        }

        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

-(BOOL)processSelections
{
    if (self.selectedRows.count > 0)
    {
        self.pendingScene.membersSceneElements = [[NSMutableArray alloc] init];

        for (NSIndexPath *indexPath in self.selectedRows)
        {
            [self.pendingScene.membersSceneElements addObject: [self.data objectAtIndex: indexPath.row]];
        }

        return YES;
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Scene Error"
                                                        message: [NSString stringWithFormat: @"Error you must select at least one scene element to be part of the scene"]
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];

        return NO;
    }
}

@end

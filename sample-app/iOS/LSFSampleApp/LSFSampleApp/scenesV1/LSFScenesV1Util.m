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

#import "LSFScenesV1Util.h"
#import "LSFScenesEnterNameViewController.h"
#import <LSFSDKLightingDirector.h>

@implementation LSFScenesV1Util

+(NSString *)buildSceneDetailsString: (LSFSceneDataModel *)sceneModel
{
    NSMutableString *detailsString = [[NSMutableString alloc] init];

    for (LSFNoEffectDataModel *nedm in sceneModel.noEffects)
    {
        [self appendLampNames: nedm.members.lamps toString: detailsString];
        [self appendGroupNames: nedm.members.lampGroups toString: detailsString];
    }

    for (LSFTransitionEffectDataModel *tedm in sceneModel.transitionEffects)
    {
        [self appendLampNames: tedm.members.lamps toString: detailsString];
        [self appendGroupNames: tedm.members.lampGroups toString: detailsString];
    }

    for (LSFPulseEffectDataModel *pedm in sceneModel.pulseEffects)
    {
        [self appendLampNames: pedm.members.lamps toString: detailsString];
        [self appendGroupNames: pedm.members.lampGroups toString: detailsString];
    }

    NSString *finalString;
    if (detailsString.length > 0)
    {
        finalString = [detailsString substringToIndex: detailsString.length - 2];
    }

    return finalString;
}

+(void)appendLampNames: (NSArray *)lampIDs toString: (NSMutableString *)detailsString
{
    for (NSString *lampID in lampIDs)
    {
        LSFSDKLamp *lamp = [[LSFSDKLightingDirector getLightingDirector] getLampWithID: lampID];

        if (lamp != nil)
        {
            [detailsString appendString: [NSString stringWithFormat: @"%@, ", lamp.name]];
        }
    }
}

+(void)appendGroupNames: (NSArray *)groupIDs toString: (NSMutableString *)detailsString
{
    for (NSString *groupID in groupIDs)
    {
        LSFSDKGroup *group = [[LSFSDKLightingDirector getLightingDirector] getGroupWithID: groupID];

        if (group != nil)
        {
            [detailsString appendString: [NSString stringWithFormat: @"%@, ", group.name]];
        }
    }
}

+(void)doSegueCreateSceneV1: (UIStoryboardSegue *)segue
{
    // Set the top ViewController to the entry point for SceneV1 creation within separate Storyboard
    UINavigationController *nc = (UINavigationController *)[segue destinationViewController];

    UIStoryboard *scenesV1StoryBoard = [UIStoryboard storyboardWithName:@"ScenesV1Storyboard" bundle: nil];
    UIViewController *rootViewController = (UIViewController *)[scenesV1StoryBoard instantiateViewControllerWithIdentifier:@"CreateSceneV1"];
    [nc setViewControllers: [NSArray arrayWithObjects: rootViewController, nil] animated: YES];

    LSFScenesEnterNameViewController *senvc = (LSFScenesEnterNameViewController *)nc.topViewController;
    senvc.sceneModel = [[LSFSceneDataModel alloc] init];
}

@end
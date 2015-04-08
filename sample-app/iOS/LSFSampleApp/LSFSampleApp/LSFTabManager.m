/******************************************************************************
 * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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

#import "LSFTabManager.h"
#import "LSFAppDelegate.h"
#import "LSFLampModelContainer.h"
#import "LSFGroupModelContainer.h"
#import "LSFSceneModelContainer.h"
#import "LSFMasterSceneModelContainer.h"

@interface LSFTabManager()

@property (nonatomic, strong) UITabBarController *tabBarController;

-(void)updateLamps: (NSNotification *)notification;
-(void)updateGroups: (NSNotification *)notification;
-(void)updateScenes: (NSNotification *)notification;

@end

@implementation LSFTabManager

@synthesize tabBarController = _tabBarController;

+(id)getTabManager
{
    static LSFTabManager *tabManager = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        tabManager = [[self alloc] init];
    });

    return tabManager;
}

-(id)init
{
    self = [super init];

    if (self)
    {
        LSFAppDelegate *appDelegate = (LSFAppDelegate *)[[UIApplication sharedApplication] delegate];
        self.tabBarController = (UITabBarController *)appDelegate.window.rootViewController;

        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(updateLamps:) name: @"UpdateLamps" object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(updateGroups:) name: @"UpdateGroups" object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(updateScenes:) name: @"UpdateScenes" object: nil];

        [self updateLamps: nil];
        [self updateGroups: nil];
        [self updateScenes: nil];
    }

    return self;
}

-(void)updateLamps: (NSNotification *)notification
{
    [[self.tabBarController.tabBar.items objectAtIndex: 0] setTitle: [NSString stringWithFormat: @"Lamps (%i)", [[[LSFLampModelContainer getLampModelContainer] lampContainer] count]]];
}

-(void)updateGroups: (NSNotification *)notification
{
    [[self.tabBarController.tabBar.items objectAtIndex: 1] setTitle: [NSString stringWithFormat: @"Groups (%i)", [[[LSFGroupModelContainer getGroupModelContainer] groupContainer] count]]];
}

-(void)updateScenes: (NSNotification *)notification
{
    NSMutableDictionary *scenes = [[LSFSceneModelContainer getSceneModelContainer] sceneContainer];
    NSMutableDictionary *masterScenes = [[LSFMasterSceneModelContainer getMasterSceneModelContainer] masterScenesContainer];

    [[self.tabBarController.tabBar.items objectAtIndex: 2] setTitle: [NSString stringWithFormat: @"Scenes (%i)", (scenes.count + masterScenes.count)]];
}

@end
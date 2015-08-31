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

#import "LSFTabManager.h"
#import "LSFAppDelegate.h"
#include <LSFSDKLightingDirector.h>

@interface LSFTabManager()

@property (nonatomic, strong) UITabBarController *tabBarController;

-(void)lampNotificationReceived: (NSNotification *)notification;
-(void)groupNotificationRecieved: (NSNotification *)notification;
-(void)sceneNotificationReceived: (NSNotification *)notification;

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

        // register notifications
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(lampNotificationReceived:) name: @"LSFLampChangedNotification" object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(groupNotificationRecieved:) name: @"LSFGroupChangedNotification" object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneNotificationReceived:) name: @"LSFSceneChangedNotification" object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneNotificationReceived:) name: @"LSFMasterSceneChangedNotification" object: nil];

        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(lampNotificationReceived:) name: @"LSFLampRemovedNotification" object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(groupNotificationRecieved:) name: @"LSFGroupRemovedNotification" object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneNotificationReceived:) name: @"LSFSceneRemovedNotification" object: nil];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneNotificationReceived:) name: @"LSFMasterRemovedNotification" object: nil];

        [self lampNotificationReceived: nil];
        [self groupNotificationRecieved: nil];
        [self sceneNotificationReceived: nil];
    }

    return self;
}

-(void)lampNotificationReceived: (NSNotification *)notification
{
    [[self.tabBarController.tabBar.items objectAtIndex: 0] setTitle: [NSString stringWithFormat: @"Lamps (%lu)", (unsigned long)[[LSFSDKLightingDirector getLightingDirector] lampCount]]];
}

-(void)groupNotificationRecieved: (NSNotification *)notification
{
    [[self.tabBarController.tabBar.items objectAtIndex: 1] setTitle: [NSString stringWithFormat: @"Groups (%lu)", (unsigned long) [[LSFSDKLightingDirector getLightingDirector] groupCount]]];
}

-(void)sceneNotificationReceived: (NSNotification *)notification
{
    unsigned long totalScenes = ([[LSFSDKLightingDirector getLightingDirector] sceneCount]) + [[LSFSDKLightingDirector getLightingDirector] masterSceneCount];

    [[self.tabBarController.tabBar.items objectAtIndex: 2] setTitle: [NSString stringWithFormat: @"Scenes (%lu)", totalScenes]];
}

@end

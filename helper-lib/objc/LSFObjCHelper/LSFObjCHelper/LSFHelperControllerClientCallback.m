/******************************************************************************
 *  * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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

#import "LSFHelperControllerClientCallback.h"
#import "LSFAllJoynManager.h"
#import "LSFDispatchQueue.h"
#import "LSFControllerModel.h"
#import "LSFEnums.h"
#import "LSFLampModelContainer.h"
#import "LSFGroupModelContainer.h"
#import "LSFSceneModelContainer.h"
#import "LSFMasterSceneModelContainer.h"
#import "LSFPresetModelContainer.h"

@interface LSFHelperControllerClientCallback()

@property (nonatomic, strong) dispatch_queue_t queue;

-(void)postUpdateControllerID: (NSString *)controllerID controllerName: (NSString *)controllerName andIsConnected: (BOOL)connected;
-(void)postGetAllLampIDs;
-(void)postGetAllLampGroupIDs;
-(void)postGetAllPresetIDs;
-(void)postGetAllSceneIDs;
-(void)postGetAllMasterSceneIDs;
-(void)postSendControllerChanged;
-(void)clearModels;

@end

@implementation LSFHelperControllerClientCallback

@synthesize queue = _queue;

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.queue = ([LSFDispatchQueue getDispatchQueue]).queue;
    }
    
    return self;
}

/*
 * Implementation of LSFControllerClientCallbackDelegate
 */
-(void)connectedToControllerServiceWithID: (NSString *)controllerServiceID andName: (NSString *)controllerServiceName
{
    NSLog(@"Connected to Controller Service with name: %@ and ID: %@", controllerServiceName, controllerServiceID);

    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    ajManager.isConnectedToController = YES;

    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *controllerStatus = [[NSNumber alloc] initWithInt: Connected];
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: controllerStatus, nil] forKeys: [[NSArray alloc] initWithObjects: @"status", nil]];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"ControllerNotification" object: self userInfo: userInfoDict];
    });
    
    dispatch_async(self.queue, ^{
        [self postUpdateControllerID: controllerServiceID controllerName: controllerServiceName andIsConnected: YES];
        [self postGetAllLampIDs];
        [self postGetAllLampGroupIDs];
        [self postGetAllPresetIDs];
        [self postGetAllSceneIDs];
        [self postGetAllMasterSceneIDs];
    });
}

-(void)connectToControllerServiceFailedForID: (NSString *)controllerServiceID andName: (NSString *)controllerServiceName
{
    NSLog(@"Connect to Controller Service with name: %@ and ID: %@ failed", controllerServiceName, controllerServiceID);
    ([LSFAllJoynManager getAllJoynManager]).isConnectedToController = NO;

    dispatch_async(self.queue, ^{
        [self postUpdateControllerID: controllerServiceID controllerName: controllerServiceName andIsConnected: NO];
    });
}

-(void)disconnectedFromControllerServiceWithID: (NSString *)controllerServiceID andName: (NSString *)controllerServiceName
{
    NSLog(@"Disconnected from Controller Service with name: %@ and ID: %@", controllerServiceName, controllerServiceID);
    ([LSFAllJoynManager getAllJoynManager]).isConnectedToController = NO;

    dispatch_async(self.queue, ^{
        [self postUpdateControllerID: controllerServiceID controllerName: controllerServiceName andIsConnected: NO];
    });

    [self clearModels];

    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *controllerStatus = [[NSNumber alloc] initWithInt: Disconnected];
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: controllerStatus, nil] forKeys: [[NSArray alloc] initWithObjects: @"status", nil]];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"ControllerNotification" object: self userInfo: userInfoDict];
    });
}

-(void)controllerClientError: (NSArray *)ec
{
    NSLog(@"Controller client experienced the following errors: ");
    
    for (NSNumber *error in ec)
    {
        NSLog(@"%i", [error intValue]);
    }

    dispatch_async([[LSFDispatchQueue getDispatchQueue] queue], ^{
        [[[LSFLightingSystemManager getLightingSystemManager] getControllerManager] sendErrorEventWithName: @"controllerClientErrorCB" andErrorCodes: ec];
    });
}

/*
 * Private functions
 */
-(void)postUpdateControllerID: (NSString *)controllerID controllerName: (NSString *)controllerName andIsConnected: (BOOL)connected
{
    LSFControllerModel *controllerModel = [LSFControllerModel getControllerModel];

    if (connected || [controllerID isEqualToString: controllerModel.theID])
    {
        controllerModel.theID = controllerID;
        controllerModel.name = controllerName;
        controllerModel.connected = connected;
        controllerModel.timestamp = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
        
        [self postSendControllerChanged];
    }
}

-(void)postGetAllLampIDs
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), ([LSFDispatchQueue getDispatchQueue]).queue, ^{
        LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
        [ajManager.lsfLampManager getAllLampIDs];
    });
}

-(void)postGetAllLampGroupIDs
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC), ([LSFDispatchQueue getDispatchQueue]).queue, ^{
        LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
        [ajManager.lsfLampGroupManager getAllLampGroupIDs];
    });
}

-(void)postGetAllPresetIDs
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), ([LSFDispatchQueue getDispatchQueue]).queue, ^{
        LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
        [ajManager.lsfPresetManager getAllPresetIDs];
    });
}

-(void)postGetAllSceneIDs
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), ([LSFDispatchQueue getDispatchQueue]).queue, ^{
        LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
        [ajManager.lsfSceneManager getAllSceneIDs];
    });
}

-(void)postGetAllMasterSceneIDs
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), ([LSFDispatchQueue getDispatchQueue]).queue, ^{
        LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
        [ajManager.lsfMasterSceneManager getAllMasterSceneIDs];
    });
}

-(void)postSendControllerChanged
{
    dispatch_async([[LSFDispatchQueue getDispatchQueue] queue], ^{
        [[[LSFLightingSystemManager getLightingSystemManager] getControllerManager] sendLeaderStateChangedEvent];
    });
}

-(void)clearModels
{
    LSFLampModelContainer *lampContainer = [LSFLampModelContainer getLampModelContainer];
    LSFGroupModelContainer *groupContainer = [LSFGroupModelContainer getGroupModelContainer];
    LSFSceneModelContainer *sceneContainer = [LSFSceneModelContainer getSceneModelContainer];
    LSFMasterSceneModelContainer *masterSceneContainer = [LSFMasterSceneModelContainer getMasterSceneModelContainer];
    LSFPresetModelContainer *presetContainer = [LSFPresetModelContainer getPresetModelContainer];

    [lampContainer.lampContainer removeAllObjects];
    [groupContainer.groupContainer removeAllObjects];
    [sceneContainer.sceneContainer removeAllObjects];
    [masterSceneContainer.masterScenesContainer removeAllObjects];
    [presetContainer.presetContainer removeAllObjects];

    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateLamps" object: self userInfo: nil];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateGroups" object: self userInfo: nil];
        [[NSNotificationCenter defaultCenter] postNotificationName: @"UpdateScenes" object: self userInfo: nil];
    });
}

@end
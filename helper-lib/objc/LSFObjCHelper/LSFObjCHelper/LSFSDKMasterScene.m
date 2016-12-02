/******************************************************************************
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 ******************************************************************************/

#import "LSFSDKMasterScene.h"
#import "LSFSDKAllJoynManager.h"
#import "LSFSDKLightingItemUtil.h"
#import "LSFSDKLightingDirector.h"
#import "initializer/LSFSDKSceneV1+Init.h"

@implementation LSFSDKMasterScene

-(void)apply
{
    NSString *errorContext = @"LSFSDKMasterScene apply: error";

    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] applyMasterSceneWithID: masterSceneDataModel.theID]];
}

-(void)modify: (NSArray *)scenes
{
    NSString *errorContext = @"LSFSDKMasterScene modify: error";

    if ([self postInvalidArgIfNull: errorContext object: scenes])
    {
        NSMutableArray *sceneIDs = [[NSMutableArray alloc] init];

        for (LSFSDKScene *scene in scenes)
        {
            [sceneIDs addObject: [scene theID]];
        }

        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] updateMasterSceneWithID: masterSceneDataModel.theID andMasterScene: [LSFSDKLightingItemUtil createMasterSceneFromSceneID: sceneIDs]]];
    }
}

-(void)add: (LSFSDKScene *)scene
{
    NSString *errorContext = @"LSFSDKMasterScene add: error";
    if ([self postInvalidArgIfNull: errorContext object: scene])
    {
        NSMutableSet *sceneIDsSet = [[NSMutableSet alloc] initWithArray: masterSceneDataModel.masterScene.sceneIDs];

        if (![sceneIDsSet containsObject: scene.theID])
        {
            [sceneIDsSet addObject: scene.theID];
            [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] updateMasterSceneWithID: masterSceneDataModel.theID andMasterScene: [LSFSDKLightingItemUtil createMasterSceneFromSceneID: [sceneIDsSet allObjects]]]];
        }
    }
}

-(void)remove: (LSFSDKScene *)scene
{
    NSString *errorContext = @"LSFSDKMasterScene remove: error";

    if ([self postInvalidArgIfNull: errorContext object: scene])
    {
        NSMutableSet *sceneIDsSet = [[NSMutableSet alloc] initWithArray: masterSceneDataModel.masterScene.sceneIDs];

        if ([sceneIDsSet containsObject: scene.theID])
        {
            [sceneIDsSet removeObject: scene.theID];
            [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] updateMasterSceneWithID: masterSceneDataModel.theID andMasterScene: [LSFSDKLightingItemUtil createMasterSceneFromSceneID: [sceneIDsSet allObjects]]]];
        }
    }
}

-(void)deleteItem
{
    NSString *errorContext = @"LSFSDKMasterScene deleteMasterScene: error";
    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] deleteMasterSceneWithID: masterSceneDataModel.theID]];
}

-(NSArray *)getScenes
{
    NSMutableArray *scenes = [[NSMutableArray alloc] init];

    for (NSString* sceneID in [[masterSceneDataModel masterScene] sceneIDs])
    {
        LSFSDKScene *scene = [[LSFSDKLightingDirector getLightingDirector] getSceneWithID: sceneID];

        if (scene == nil)
        {
            // Missing child scene. This could be becase the scenes
            // have not yet full loaded, so we insert a placeholder
            scene = [[LSFSDKSceneV1 alloc] initWithSceneID: sceneID];
        }

        [scenes addObject: scene];
    }

    return scenes;
}

-(BOOL)hasScene: (LSFSDKScene *)scene
{
    NSString *errorContext = @"LSFSDKMasterScene hasScene: error";
    return ([self postInvalidArgIfNull: errorContext object: scene]) ? [self hasSceneWithID: scene.theID] : NO;
}

-(BOOL)hasSceneWithID: (NSString *)sceneID
{
    return [masterSceneDataModel containsSceneID: sceneID];
}

/*
 * Override base class functions
 */
-(void)rename:(NSString *)name
{
    NSString *errorContext = @"LSFSDKMasterScene rename: error";

    if ([self postInvalidArgIfNull: errorContext object: name])
    {
        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] setMasterSceneNameWithID: masterSceneDataModel.theID andMasterSceneName: name]];
    }
}

-(LSFModel *)getItemDataModel
{
    return [self getMasterSceneDataModel];
}

-(BOOL)hasComponent:(LSFSDKLightingItem *)item
{
    NSString *errorContext = @"LSFSDKMasterScene hasComponent: error";
    return ([self postInvalidArgIfNull: errorContext object: item]) ? [self hasSceneWithID: item.theID] : NO;
}

-(NSArray *)getComponentCollection
{
    return [self getScenes];
}

-(void)postError:(NSString *)name status:(LSFResponseCode)status
{
    dispatch_async([[[LSFSDKLightingDirector getLightingDirector] lightingManager] dispatchQueue], ^{
        [[[[LSFSDKLightingDirector getLightingDirector] lightingManager] masterSceneCollectionManager] sendErrorEvent: name statusCode: status itemID: masterSceneDataModel.theID];
    });
}

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFMasterSceneDataModel *)getMasterSceneDataModel
{
    return masterSceneDataModel;
}

@end
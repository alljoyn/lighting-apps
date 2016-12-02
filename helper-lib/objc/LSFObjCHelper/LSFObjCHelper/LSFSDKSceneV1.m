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

#import "LSFSDKSceneV1.h"
#import "LSFSDKLightingDirector.h"

@implementation LSFSDKSceneV1

-(BOOL)hasPreset: (LSFSDKPreset *)preset
{
    NSString *errorContext = @"LSFSDKSceneV1 hasPreset: error";
    return ([self postInvalidArgIfNull: errorContext object: preset]) ? [self hasPresetWithID: preset.theID] : NO;
}

-(BOOL)hasGroup: (LSFSDKGroup *)group;
{
    NSString *errorContext = @"LSFSDKSceneV1 hasGroup: error";
    return ([self postInvalidArgIfNull: errorContext object: group]) ? [self hasPresetWithID: group.theID] : NO;
}

-(BOOL)hasPresetWithID: (NSString *)presetID;
{
    return [sceneModel containsPreset: presetID];
}

-(BOOL)hasGroupWithID: (NSString *)groupID
{
    return [sceneModel containsGroup: groupID];
}

/*
 * Override base class functions
 */
-(LSFModel *)getItemDataModel
{
    return [self getSceneDataModel];
}

-(BOOL)hasComponent:(LSFSDKLightingItem *)item
{
    NSString *errorContext = @"LSFSDKSceneV1 hasComponent: error";
    return ([self postInvalidArgIfNull: errorContext object: item]) ? ([self hasPresetWithID: item.theID] || [self hasGroupWithID: item.theID]): NO;
}

-(void)postError:(NSString *)name status:(LSFResponseCode)status
{
    dispatch_async([[[LSFSDKLightingDirector getLightingDirector] lightingManager] dispatchQueue], ^{
        [[[[LSFSDKLightingDirector getLightingDirector] lightingManager] sceneCollectionManagerV1] sendErrorEvent: name statusCode: status itemID: sceneModel.theID];
    });
}

/*
 * Note: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.
 */
-(LSFSceneDataModel *)getSceneDataModel
{
    return sceneModel;
}

@end
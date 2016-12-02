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

#import "LSFSDKMasterSceneDelegateBase.h"

@implementation LSFSDKMasterSceneDelegateBase

-(void)onMasterSceneInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andMasterScene: (LSFSDKMasterScene *)masterScene
{
    //Intentionally left blank
}

-(void)onMasterSceneChanged: (LSFSDKMasterScene *)masterScene
{
    //Intentionally left blank
}

-(void)onMasterSceneRemoved: (LSFSDKMasterScene *)masterScene
{
    //Intentionally left blank
}

-(void)onMasterSceneError: (LSFSDKLightingItemErrorEvent *)error
{
    //Intentionally left blank
}

@end
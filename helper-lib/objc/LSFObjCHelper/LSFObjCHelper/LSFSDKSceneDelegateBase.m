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

#import "LSFSDKSceneDelegateBase.h"

@implementation LSFSDKSceneDelegateBase

-(void)onSceneInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andScene: (LSFSDKScene *)scene
{
    //Intentionally left blank
}

-(void)onSceneChanged: (LSFSDKScene *)scene
{
    //Intentionally left blank
}

-(void)onSceneRemoved: (LSFSDKScene *)scene
{
    //Intentionally left blank
}

-(void)onSceneError: (LSFSDKLightingItemErrorEvent *)error
{
    //Intentionally left blank
}

@end
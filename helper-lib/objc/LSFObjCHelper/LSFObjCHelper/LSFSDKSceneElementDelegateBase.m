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

#import "LSFSDKSceneElementDelegateBase.h"

@implementation LSFSDKSceneElementDelegateBase

-(void)onSceneElementInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andSceneElement: (LSFSDKSceneElement *)sceneElement
{
    //Intentionally left blank
}

-(void)onSceneElementChanged: (LSFSDKSceneElement *)sceneElement
{
    //Intentionally left blank
}

-(void)onSceneElementRemoved: (LSFSDKSceneElement *)sceneElement
{
    //Intentionally left blank
}

-(void)onSceneElementError: (LSFSDKLightingItemErrorEvent *)error
{
    //Intentionally left blank
}

@end
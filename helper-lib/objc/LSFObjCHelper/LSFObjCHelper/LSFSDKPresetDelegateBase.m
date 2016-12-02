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

#import "LSFSDKPresetDelegateBase.h"

@implementation LSFSDKPresetDelegateBase

-(void)onPresetInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andPreset: (LSFSDKPreset *)preset
{
    //Intentionally left blank
}

-(void)onPresetChanged: (LSFSDKPreset *)preset
{
    //Intentionally left blank
}

-(void)onPresetRemoved: (LSFSDKPreset *)preset
{
    //Intentionally left blank
}

-(void)onPresetError: (LSFSDKLightingItemErrorEvent *)error
{
    //Intentionally left blank
}

@end
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

#import <LSFSDKAllLightingItemDelegateBase.h>

@class LSFSDKLightingItemErrorEvent;

@interface LSFAnyCollectionDelegateBase : LSFSDKAllLightingItemDelegateBase

-(void)onAnyInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andLightingItem: (id)item;
-(void)onAnyChanged: (id)item;
-(void)onAnyRemoved: (id)item;
-(void)onAnyError: (LSFSDKLightingItemErrorEvent *)error;

@end
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

#import <Foundation/Foundation.h>
#import "listener/LSFSDKLightingDelegate.h"
#import "LSFSDKTrackingID.h"

@class LSFSDKGroup;
@class LSFSDKLightingItemErrorEvent;

/**
 * Provides an interface for developers to implement and receive all group related events in the
 * Lighting system. Developers will be notified when groups are added, modified, initialized, and
 * deleted from the lighting controller. Groups are considered initialized when all group data has
 * been received from the lighting controller.
 *
 * **Note:** Once implemented, the delegate must be registered with the LSFSDKLightingDirector in order
 * to receive Group callbacks. See [LSFSDKLightingDirector addGroupDelegate:] for more information.
 */
@protocol LSFSDKGroupDelegate <LSFSDKLightingDelegate>

/**
 * Triggered when all data has been received from the lighting controller for a
 * particular LSFSDKGroup.
 *
 * @warning This callback will fire only once for each LSFSDKGroup when all data has been received from
 * the lighting controller.
 *
 * @warning The tracking ID is only valid for groups created within your application.
 *
 * @param trackingID Reference to LSFSDKTrackingID
 * @param group Reference to LSFSDKGroup
 */
-(void)onGroupInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andGroup: (LSFSDKGroup *)group;

/**
 * Triggered every time new data is received from the lighting controller for a
 * particular LSFSDKGroup.
 *
 * @param group Reference to LSFSDKGroup
 */
-(void)onGroupChanged: (LSFSDKGroup *)group;

/**
 * Triggered when a particular LSFSDKGroup has been deleted from the lighting controller.
 *
 * @warning This callback will fire only once for each LSFSDKGroup when it is deleted from
 * the lighting controller.
 *
 * @param group Reference to LSFSDKGroup
 */
-(void)onGroupRemoved: (LSFSDKGroup *)group;

/**
 * Triggered when an error occurs on a LSFSDKGroup operation.
 *
 * @param error Reference to LSFSDKLightingItemErrorEvent
 */
-(void)onGroupError: (LSFSDKLightingItemErrorEvent *)error;

@end
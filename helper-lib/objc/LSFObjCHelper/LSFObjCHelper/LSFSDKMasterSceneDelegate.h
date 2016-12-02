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

@class LSFSDKMasterScene;
@class LSFSDKLightingItemErrorEvent;

/**
 * Provides an interface for developers to implement and receive all master scene related events in the
 * Lighting system. Developers will be notified when master scenes are added, modified, initialized, and
 * deleted from the lighting controller. Master scenes are considered initialized when all master scene
 * data has been received from the lighting controller.
 *
 * **Note:** Once implemented, the delegate must be registered with the LSFSDKLightingDirector in order
 * to receive MasterScene callbacks. See [LSFSDKLightingDirector addMasterSceneDelegate:] for more information.
 */
@protocol LSFSDKMasterSceneDelegate <LSFSDKLightingDelegate>

/**
 * Triggered when all data has been received from the lighting controller for a particular LSFSDKMasterScene.
 *
 * @warning This callback will fire only once for each LSFSDKMasterScene when all data has been received from
 * the lighting controller.
 *
 * @warning The tracking ID is only valid for master scenes created within your application.
 *
 * @param trackingID  Reference to LSFSDKTrackingID
 * @param masterScene  Reference to LSFSDKMasterScene
 */
-(void)onMasterSceneInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andMasterScene: (LSFSDKMasterScene *)masterScene;

/**
 * Triggered every time new data is received from the lighting controller for a particular LSFSDKMasterScene.
 *
 * @param masterScene  Reference to LSFSDKMasterScene
 */
-(void)onMasterSceneChanged: (LSFSDKMasterScene *)masterScene;

/**
 * Triggered when a particular LSFSDKMasterScene has been deleted from the lighting controller.
 *
 * @warning This callback will fire only once for each LSFSDKMasterScene when it is deleted from
 * the lighting controller.
 *
 * @param masterScene  Reference to LSFSDKMasterScene
 */
-(void)onMasterSceneRemoved: (LSFSDKMasterScene *)masterScene;

/**
 * Triggered when an error occurs on a LSFSDKMasterScene operation.
 *
 * @param error  Reference to LSFSDKLightingItemErrorEvent
 */
-(void)onMasterSceneError: (LSFSDKLightingItemErrorEvent *)error;

@end
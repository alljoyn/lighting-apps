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

@class LSFSDKSceneElement;
@class LSFSDKLightingItemErrorEvent;

/**
 * Provides an interface for developers to implement and receive all scene element related events in the
 * Lighting system. Developers will be notified when scene elements are added, modified, initialized, and
 * deleted from the lighting controller. Scene elements are considered initialized when all scene element data has
 * been received from the lighting controller.
 *
 * **Note:** Once implemented, the delegate must be registered with the LSFSDKLightingDirector in order
 * to receive SceneElement callbacks. See [LSFSDKLightingDirector addSceneElementDelegate:] for more information.
 */
@protocol LSFSDKSceneElementDelegate <LSFSDKLightingDelegate>

/**
 * Triggered when all data has been received from the lighting controller for a particular LSFSDKSceneElement.
 *
 * @warning This callback will fire only once for each LSFSDKSceneElement when all data has been received from
 * the lighting controller.
 *
 * @warning The tracking ID is only valid for scene elements created within your application.
 *
 * @param trackingID Reference to LSFSDKTrackingID
 * @param sceneElement Reference to LSFSDKSceneElement
 */
-(void)onSceneElementInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andSceneElement: (LSFSDKSceneElement *)sceneElement;

/**
 * Triggered every time new data is received from the lighting controller for a
 * particular LSFSDKSceneElement.
 *
 * @param sceneElement Reference to LSFSDKSceneElement
 */
-(void)onSceneElementChanged: (LSFSDKSceneElement *)sceneElement;

/**
 * Triggered when a particular LSFSDKSceneElement has been deleted from the lighting controller.
 *
 * @warning This callback will fire only once for each LSFSDKSceneElement when it is deleted from
 * the lighting controller.
 *
 * @param sceneElement Reference to LSFSDKSceneElement
 */
-(void)onSceneElementRemoved: (LSFSDKSceneElement *)sceneElement;

/**
 * Triggered when an error occurs on a LSFSDKSceneElement operation.
 *
 * @param error Reference to LSFSDKLightingItemErrorEvent
 */
-(void)onSceneElementError: (LSFSDKLightingItemErrorEvent *)error;

@end
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

@class LSFSDKLamp;
@class LSFSDKLightingItemErrorEvent;

/**
 * Provides an interface for developers to implement and receive all lamp related events in the
 * Lighting system. Developers will be notified when lamps are found, modified, initialized, and
 * lost from the lighting controller. Lamps are considered initialized when all lamp data has
 * been received from the lighting controller.
 *
 * **Note:** Once implemented, the delegate must be registered with the LSFSDKLightingDirector in order
 * to receive Lamp callbacks. See [LSFSDKLightingDirector addLampDelegate:] for more information.
 */
@protocol LSFSDKLampDelegate <LSFSDKLightingDelegate>

/**
 * Triggered when all data has been received from the lighting controller for a
 * particular LSFSDKLamp.
 *
 * @warning This callback will fire only once for each LSFSDKLamp when all data has been received from
 * the lighting controller.
 *
 * @param lamp Reference to LSFSDKLamp
 */
-(void)onLampInitialized: (LSFSDKLamp *)lamp;

/**
 * Triggered every time new data is received from the lighting controller for a
 * particular LSFSDKLamp.
 *
 * @param lamp Reference to LSFSDKLamp
 */
-(void)onLampChanged: (LSFSDKLamp *)lamp;

/**
 * Triggered when a particular LSFSDKLamp has been lost from the lighting controller.
 *
 * @warning This callback will fire only once for each LSFSDKLamp when it is lost from
 * the lighting controller.
 *
 * @param lamp Reference to LSFSDKLamp
 */
-(void)onLampRemoved: (LSFSDKLamp *)lamp;

/**
 * Triggered when an error occurs on a LSFSDKLamp operation.
 *
 * @param error Reference to LSFSDKLightingItemErrorEvent
 */
-(void)onLampError: (LSFSDKLightingItemErrorEvent *)error;

@end
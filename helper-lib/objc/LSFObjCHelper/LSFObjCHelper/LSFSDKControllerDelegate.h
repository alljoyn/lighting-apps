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
#import "LSFSDKController.h"
#import "model/LSFControllerModel.h"

@class LSFSDKControllerErrorEvent;

/**
 * Provides an interface for developers to implement and receive all controller related events in the
 * Lighting system. Developers will be notified when a new controller becomes the leader on the network
 * and when there are any controller related errors.
 *
 * **Note:** Once implemented, the delegate must be registered with the LSFSDKLightingDirector in order
 * to receive Controller callbacks. See [LSFSDKLightingDirector addControllerDelegate:] for more information.
 */
@protocol LSFSDKControllerDelegate <LSFSDKLightingDelegate>

/**
 * Triggered when a new controller becomes the leader in the Lighting system.
 *
 * @param leader Reference to new lead controller
 */
-(void)onLeaderChange: (LSFSDKController *)leader;

/**
 * Triggered when an error occurs on a controller operation.
 *
 * @param errorEvent Reference to LSFSDKControllerErrorEvent
 */
-(void)onControllerError: (LSFSDKControllerErrorEvent *)errorEvent;

@end
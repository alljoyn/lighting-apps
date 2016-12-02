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

/**
 * Provides an interface for developers to implement and receive a callback when a connection is
 * established with a LSFSDKLightingController.
 *
 * **Note:** Once implemented, the delegate must be registered with the LSFSDKLightingDirector in order
 * to receive a connection callback. See [LSFSDKLightingDirector postOnNextControllerConnectionWithDelay:delegate:]
 * for more information.
 */
@protocol LSFSDKNextControllerConnectionDelegate <NSObject>

/**
 * Triggered when a connection to a LSFSDKLightingController has been established.
 *
 * @warning This delegate will fire only once when a controller connection is established. This
 * delegate must be reregistered if the controller connection is lost.
 */
-(void)onNextControllerConnection;

@end
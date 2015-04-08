/******************************************************************************
 *  *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import "LSFNextControllerConnectionDelegate.h"
#import "AJNBusAttachment.h"

/**
 * LSFLightingDirector is the main class in the facade interface of the iOS Lighting SDK.
 * It provides access to instances of other facade classes that represent active
 * components in the Lighting system.
 *
 * *Note:* Please see the LSFTutorial project for an example of how to use the LSFLightingDirector
 * class.
 */
@interface LSFLightingDirector : NSObject

/** @name Class Properties */

/**
* Returns the version number of the interface provided by this class.
*
* @return The version number.
*/
@property (nonatomic, readonly) int version;

/**
 * Returns the AllJoyn BusAttachment object being used to connect.
 *
 * @warning *Note:* The BusAttachment will be nil until some time after the call start.
 *
 * @return The AllJoyn BusAttachment object.
 */
@property (nonatomic, readonly) AJNBusAttachment *busAttachment;

/** @name Creating LSFLightingDirector */

/**
 * Constructs an instance of the LSFLightingDirector class.
 *
 * @return Instance of LSFLightingDirector.
 *
 * @warning *Note:* The start method must be called at some point after construction when you're
 * ready to begin working with the Lighting system.
 */
-(id)init;

/** @name Starting/Stopping LSFLightingDirector */

/**
 * Causes the LightingDirector to start interacting with the Lighting system.
 */
-(void)start;

/**
 * Causes the LightingDirector to stop interacting with the Lighting system.
 */
-(void)stop;

/** @name Getters for active Lighting system components */

/**
 * Returns a snapshot of the active Lamps in the Lighting system.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new lamps
 * are discovered or existing lamps are determined to be offline. This array may be empty.
 *
 * @return Array of active Lamps.
 */
-(NSArray *)getLamps;

/**
 * Returns a snapshot of the active Group definitions in the Lighting system.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new groups
 * are created or existing groups are deleted. This array may be empty.
 *
 * @return Array of active Groups.
 */
-(NSArray *)getGroups;

/**
 * Returns a snapshot of the active Scene definitions in the Lighting system.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new scenes
 * are created or existing scenes are deleted. This array may be empty.
 *
 * @return Array of active Scenes.
 */
-(NSArray *)getScenes;

/**
 * Sets a delegate for the implementing class of the LSFNextControllerConnectionDelegate protocol.
 *
 * This LSFNextControllerConnectionDelegate will notify the receiving class when a connection has been established
 * with a Lighting controller.
 *
 * @param delegate Specifies instance of class that implements LSFNextControllerConnectionDelegate protocol.
 */
-(void)postOnNextControllerConnection: (id<LSFNextControllerConnectionDelegate>)delegate;

@end
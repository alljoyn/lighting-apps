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

#import "LSFSDKLightingItem.h"
#import "LSFSDKDeletableItem.h"

/**
 * Base class that represents generic Scene operations that can be performed. Generic scenes
 * can be applied, renamed, and deleted.
 */
@interface LSFSDKScene : LSFSDKLightingItem <LSFSDKDeletableItem>

/** @name Scene Operations */

/**
 * Applies the current LSFSDKScene in the Lighting system.
 */
-(void)apply;

/**
 * Permanently deletes the current LSFSDKScene from the lighting controller.
 *
 * @warning You cannot delete a scene that is used by a master scene. The dependency
 * must be deleted first.
 */
-(void)deleteItem;

@end
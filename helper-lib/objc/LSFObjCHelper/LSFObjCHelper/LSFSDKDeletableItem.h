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
#import "LSFSDKLightingItemProtocol.h"

/**
 * Base interface that is implemented by all Lighting items that support a
 * delete operation. When delete is called, the Lighting item will be permanently
 * deleted from the Lighting Controller.
 */
@protocol LSFSDKDeletableItem <LSFSDKLightingItemProtocol>

/**
 * Delete the current Lighting item from the Lighting Controller.
 */
-(void)deleteItem;

@end
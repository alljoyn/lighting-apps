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
#import "LSFSDKDeletableItem.h"

@class LSFSDKGroupMember;

/**
 * Base interface implemented by all Lighting items that are effects.
 */
@protocol LSFSDKEffect <LSFSDKLightingItemProtocol, LSFSDKDeletableItem>

/**
 * Applies the current effect to the provided Lighting item.
 *
 * @param member  Lighting item to apply the effect
 */
-(void)applyToGroupMember: (LSFSDKGroupMember *)member;

@end
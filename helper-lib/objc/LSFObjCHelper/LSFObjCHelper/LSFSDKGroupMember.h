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

#import "LSFSDKMutableColorItem.h"
#import "LSFSDKEffect.h"

@class LSFSDKPreset;

/**
 * Base class for Lighting items that can be included in a Lighting Group.
 *
 * @warning Client software should not instantiate the LSFSDKGroupMember directly.
 */
@interface LSFSDKGroupMember : LSFSDKMutableColorItem

/**
 * Applies the provided LSFSDKPreset to the current LSFSDKGroupMember.
 *
 * @param preset Preset to apply to the current LSFSDKGroupMember
 */
-(void)applyPreset: (LSFSDKPreset *)preset;

/**
 * Applies the provided LSFSDKEffect to the current LSFSDKGroupMember.
 *
 * @param effect Effect to apply to the current LSFSDKGroupMember
 */
-(void)applyEffect: (id<LSFSDKEffect>)effect;

@end
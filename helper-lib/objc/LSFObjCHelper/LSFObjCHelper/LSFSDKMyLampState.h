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
#import "LSFSDKLampState.h"
#import "LSFSDKPower.h"
#import "LSFSDKColor.h"
#import <internal/LSFLampState.h>

/**
 * Default implementation of the LSFSDKLampState interface and represents the power and
 * color state of a Lighting item.
 */
@interface LSFSDKMyLampState : NSObject <LSFSDKLampState>

/** @name Class Properties */

/**
 * The power state.
 */
@property (nonatomic) Power power;

/**
 * The color state.
 */
@property (nonatomic, strong) LSFSDKColor *color;

/** @name Initializing an LSFSDKMyLampState Object */

/**
 * Constructs a LSFSDKMyLampState object.
 *
 * @param state  An existing LSFLampState.
 *
 * @return An LSFSDKMyLampState object
 */
-(id)initWithLSFLampState: (LSFLampState *)state;

/**
 * Constructs a LSFSDKMyLampState object.
 *
 * @warning If the provided HSVT values are outside the expected range, they will be normalized to the
 * expected range.
 *
 * @param power  The Power state.
 * @param hue  The hue component of the Color (0-360)
 * @param sat  The saturation component of a Color (0-100)
 * @param brightness  The brightness component of a Color (0-100)
 * @param colorTemp  The color temperature component of a Color (1000-20000)
 *
 * @return An LSFSDKMyLampState object
 */
-(id)initWithPower: (Power)power hue: (unsigned int)hue saturation: (unsigned int)sat brightness: (unsigned int)brightness colorTemp: (unsigned int)colorTemp;

/**
 * Constructs a LSFSDKMyLampState object.
 *
 * @param power  The Power state
 * @param colorState  The Color state
 *
 * @return An LSFSDKMyLampState object
 */
-(id)initWithPower: (Power)power color: (LSFSDKColor *)colorState;

@end
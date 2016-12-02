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
 * This class encapsulates colors in the HSVT color space. Every color contains brightness,
 * hue, saturation, and colorTemp. The brightness must be between 0-100, hue must be
 * between 0-360, saturation must be between 0-100, and colorTemp must be between
 * 1000-20000.
 */
@interface LSFSDKColor : NSObject

/** @name Class Properties */

/**
 * The hue component of the LSFSDKColor object (0-360).
 *
 * @warning If the provided HSVT values are outside the expected range, they will be normalized to the
 * expected range.
 */
@property (nonatomic) unsigned int hue;

/**
 * The saturation component of the LSFSDKColor object (0-100).
 *
 * @warning If the provided HSVT values are outside the expected range, they will be normalized to the
 * expected range.
 */
@property (nonatomic) unsigned int saturation;

/**
 * The brightness component of the LSFSDKColor object (0-100).
 *
 * @warning If the provided HSVT values are outside the expected range, they will be normalized to the
 * expected range.
 */
@property (nonatomic) unsigned int brightness;

/**
 * The color temperature component of the LSFSDKColor object (1000-20000).
 *
 * @warning If the provided HSVT values are outside the expected range, they will be normalized to the
 * expected range.
 */
@property (nonatomic) unsigned int colorTemp;

/** @name Initializing an LSFSDKColor Object */

/**
 * Constructs an LSFSDKColor object using the provided HSVT values.
 *
 * @warning If the provided HSVT values are outside the expected range, they will be normalized to the
 * expected range.
 *
 * @param hsvt  Array of HSVT values
 */
-(id)initWithHsvt: (NSArray *)hsvt;

/**
 * Constructs an LSFSDKColor object using the provided HSVT values.
 *
 * @warning If the provided HSVT values are outside the expected range, they will be normalized to the
 * expected range.
 *
 * @param hueValue  The hue component of the color (0-360)
 * @param satValue  The saturation component of the color (0-100)
 * @param brightnessValue  The brightness component of the color (0-100)
 * @param colorTempValue  The colorTemp component of the color (1000-20000)
 */
-(id)initWithHue: (unsigned int)hueValue saturation: (unsigned int)satValue brightness: (unsigned int)brightnessValue colorTemp: (unsigned int)colorTempValue;

/**
 * Constructs an LSFSDKColor object using the provided LSFSDKColor object.
 *
 * @param color  The other Color object
 */
-(id)initWithColor: (LSFSDKColor *)color;

/** @name Constants */

/**
 * Specifies the color red.
 */
+(LSFSDKColor *)red;

/**
 * Specifies the color green.
 */
+(LSFSDKColor *)green;

/**
 * Specifies the color blue.
 */
+(LSFSDKColor *)blue;

/**
 * Specifies the color white.
 */
+(LSFSDKColor *)white;

@end
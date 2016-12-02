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
 * Provides an interface for developers to implement and create their own LSFSDKLampState object.
 */
@protocol LSFSDKLampState <NSObject>

/**
 * Returns the power state of the LSFSDKLampState object.
 *
 * @return Returns true if the power is on, false otherwise
 */
-(BOOL)getPowerOn;

/**
 * Sets the power state of the LSFSDKLampState object.
 *
 * @param powerOn Specifies the power state
 */
-(void)setPowerOn: (BOOL)powerOn;

/**
 * Returns the HSVT color of the LSFSDKLampState object
 *
 * @return Integer array containing the HSVT color
 */
-(NSArray *)getColorHsvt;

/**
 * Sets the color of the LSFSDKLampState object using the provided values.
 *
 * @warning If the provided HSVT values are outside the expected range, they will be normalized to the
 * expected range.
 *
 * @param hueDegrees  The hue component of the desired color (0-360)
 * @param saturationPercent  The saturation component of the desired color (0-100)
 * @param brightnessPercent  The brightness component of the desired color (0-100)
 * @param colorTempDegrees  The color temperature component of the desired color (1000-20000)
 */
-(void)setColorHsvtWithHue: (unsigned int)hueDegrees saturation: (unsigned int)saturationPercent brightness: (unsigned int)brightnessPercent colorTemp: (unsigned int)colorTempDegrees;

@end
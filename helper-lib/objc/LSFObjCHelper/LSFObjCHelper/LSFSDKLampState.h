/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
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
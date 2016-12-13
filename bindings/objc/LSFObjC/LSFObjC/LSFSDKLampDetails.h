/******************************************************************************
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
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

#import "internal/LSFObject.h"
#import <LampValues.h>

/**
 * This class encapsulates all of the details for lamps and illustrates the make/model of the lamp
 * as well as the capabilities of the lamp.
 */
@interface LSFSDKLampDetails : LSFObject

/** @name Class Properties */

/**
 * Specifies the make of the lamp.
 */
@property (nonatomic) LampMake lampMake;

/**
 * Specifies the model of the lamp.
 */
@property (nonatomic) LampModel lampModel;

/**
 * Specifies the device type of the lamp.
 */
@property (nonatomic) DeviceType deviceType;

/**
 * Specifies the base type of the lamp.
 */
@property (nonatomic) LampType lampType;

/**
 * Specifies the base type of the lamp.
 */
@property (nonatomic) BaseType baseType;

/**
 * Specifies the beam angle of the lamp.
 */
@property (nonatomic) unsigned int lampBeamAngle;

/**
 * Indicates whether or not the lamp is dimmable.
 */
@property (nonatomic) BOOL dimmable;

/**
 * Indicates whether or not the lamp supports color.
 */
@property (nonatomic) BOOL color;

/**
 * Indicates whether or not the lamp has a variable color temperature.
 */
@property (nonatomic) BOOL variableColorTemp;

/**
 * Indicates whether or not the lamp supports effects.
 */
@property (nonatomic) BOOL hasEffects;

/**
 * Specifies the maximum voltage of the lamp.
 */
@property (nonatomic) unsigned int maxVoltage;

/**
 * Specifies the minimum voltage of the lamp.
 */
@property (nonatomic) unsigned int minVoltage;

/**
 * Specifies the wattage of the lamp.
 */
@property (nonatomic) unsigned int wattage;

/**
 * Specifies the incandescent equivalent wattage of the lamp.
 */
@property (nonatomic) unsigned int incandescentEquivalent;

/**
 * Specifies the maximum lumens supported by the lamp.
 */
@property (nonatomic) unsigned int maxLumens;

/**
 * Specifies the minimum color temperature of the lamp.
 */
@property (nonatomic) unsigned int minTemperature;

/**
 * Specifies the maximum color temperature of the lamp.
 */
@property (nonatomic) unsigned int maxTemperature;

/**
 * Specifies the color rendering index of the lamp.
 */
@property (nonatomic) unsigned int colorRenderingIndex;

/**
 * Specifies the ID of the lamp.
 */
@property (nonatomic, strong) NSString *lampID;

/** @name Initializing an LSFSDKLampDetails Object */

/**
 * Constructs a LSFSDKLampDetails object.
 *
 * @warning This method is intended to be used internally. Client software should not instantiate
 * LSFSDKLampDetails directly, but should instead get them from the LSFSDKLamp using the [LSFSDKLamp details]
 * method.
 */
-(id)init;

@end
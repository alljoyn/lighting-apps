/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
#import "LSFColorItem.h"
#import "LSFGroupModel.h"

/**
 * An LSFGroup object represents a set of lamps in the lighting system, and can be used to send the
 * same command to all of them.
 *
 * Groups can contain lamps and nested groups.
 */
@interface LSFGroup : LSFColorItem

/** @name Creating LSFLamp */

/**
 * Constructs an instance of the LSFGroup class.
 *
 * @param groupID The ID of the Group.
 *
 * @return Instance of LSFGroup.
 *
 * @warning *Note:* This method is intended to be used internally. Client software should not instantiate
 * Groups directly, but should instead get them from the LSFLightingDirector using the [LSFLightingDirector getGroups]
 * method.
 */
-(id)initWithGroupID: (NSString *)groupID;

/**
 * Constructs an instance of the LSFGroup class.
 *
 * @param groupID The ID of the Group.
 * @param groupName The name of the Group
 *
 * @return Instance of LSFGroup.
 *
 * @warning *Note:* This method is intended to be used internally. Client software should not instantiate
 * Groups directly, but should instead get them from the LSFLightingDirector using the [LSFLightingDirector getGroups]
 * method.
 */
-(id)initWithGroupID: (NSString *)groupID andName: (NSString *)groupName;

/** @name LSFGroup Controls */

/**
 * Sends a command to turn all constituent lamps in the Group on or off.
 *
 * @param powerOn  Pass in true for on, false for off
 */
-(void)setPowerOn: (BOOL)powerOn;

/**
 * Sends a command to change the color of all constituent lamps in the Group.
 *
 * @param hueDegrees  The hue component of the desired color, in degrees (0-360)
 * @param saturationPercent  The saturation component of the desired color, in percent (0-100)
 * @param brightnessPercent  The brightness component of the desired color, in percent (0-100)
 * @param colorTempDegrees  The color temperature component of the desired color, in degrees Kelvin (2700-9000)
 */
-(void)setColorWithHue: (unsigned int)hueDegrees saturation: (unsigned int)saturationPercent brightness: (unsigned int)brightnessPercent andColorTemp: (unsigned int)colorTempDegrees;

/*
 * Note: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.
 */
-(LSFGroupModel *)getLampGroupDataModel;

@end
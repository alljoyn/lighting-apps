/******************************************************************************
 * Copyright (c) AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import "LSFColorItem.h"
#import "LSFLampModel.h"

/**
 * An LSFLamp object represents a lamp in the lighting system, and can be used to send commands
 * to it.
 */
@interface LSFLamp : LSFColorItem

/** @name Creating LSFLamp */

/**
 * Constructs an instance of the LSFLamp class.
 *
 * @param lampID The ID of the Lamp.
 *
 * @return Instance of LSFLamp.
 *
 * @warning *Note:* This method is intended to be used internally. Client software should not instantiate
 * Lamps directly, but should instead get them from the LSFLightingDirector using the [LSFLightingDirector getLamps]
 * method.
 */
-(id)initWithLampID: (NSString *)lampID;

/**
 * Constructs an instance of the LSFLamp class.
 *
 * @param lampID  The ID of the Lamp.
 * @param lampName  The name of the Lamp.
 *
 * @return Instance of LSFLamp.
 *
 * @warning *Note:* This method is intended to be used internally. Client software should not instantiate
 * Lamps directly, but should instead get them from the LSFLightingDirector using the [LSFLightingDirector getLamps] 
 * method.
 */
-(id)initWithLampID:(NSString *)lampID andName: (NSString *)lampName;

/** @name LSFLamp Controls */

/**
 * Sends a command to turn this Lamp on or off.
 *
 * @param powerOn  Pass in true for on, false for off
 */
-(void)setPowerOn: (BOOL)powerOn;

/**
 * Sends a command to change the color of this Lamp.
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
-(LSFLampModel *)getLampDataModel;

@end

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

#import "internal/LSFObject.h"

/**
 * This class encapsulates all of the parameters for lamps and illustrates the current energy usage and
 * brightness output of the lamp.
 */
@interface LSFSDKLampParameters : LSFObject

/** @name Class Properties */

/**
 * Specifies the current energy usage of the lamp, in milliwatts.
 */
@property (nonatomic) unsigned int energyUsageMilliwatts;

/**
 * Specifies the current brightness of the lamp, in lumens.
 */
@property (nonatomic) unsigned int lumens;

/** @name Initializing an LSFSDKLampParameters Object */

/**
 * Constructs a LSFSDKLampParameters object.
 *
 * @warning This method is intended to be used internally. Client software should not instantiate
 * LSFSDKLampParameters directly, but should instead get them from the LSFSDKLamp using the [LSFSDKLamp parameters]
 * method.
 */
-(id)init;

@end
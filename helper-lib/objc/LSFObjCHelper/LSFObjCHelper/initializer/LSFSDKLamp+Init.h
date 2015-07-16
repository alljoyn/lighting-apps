/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
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

#import "../LSFSDKLamp.h"

@interface LSFSDKLamp (Init)

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

@end

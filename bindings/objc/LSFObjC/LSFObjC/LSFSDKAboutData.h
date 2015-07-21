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
#import <alljoyn/AboutData.h>

/**
 * This class encapsulates all of the AllJoyn about data for the device running the controller service.
 * A pointer to this object will be passed to the developer in [LSFSDKLightingControllerConfiguration populateDefaultProperties:]
 * and the developer is responsible to populate this object with all relevant about data.
 *
 * See LSFSDKLightingControllerConfigurationBase for an example.
 */
@interface LSFSDKAboutData : LSFObject

/** @name Initializing an LSFSDKAboutData Object */

/**
 * Constructs a LSFSDKAboutData object.
 *
 * @warning This method is intended to be used internally. Client software should not instantiate
 * LSFSDKAboutData directly.
 *
 * @param aboutData  Pointer to AllJoyn AboutData object
 */
-(id)initWithAboutData: (ajn::AboutData *)aboutData;

/** @name Add About Data */

/**
 * Stores the provided string value using the provided about key.
 *
 * @param key  Specifies the AllJoyn About key
 * @param value  Specifies the value for the AllJoyn About key
 */
-(void)putKey: (NSString *)key withStringValue: (NSString *)value;

/**
 * Stores the provided string value using the provided about key.
 *
 * @param key  Specifies the AllJoyn About key
 * @param value  Specifies the value for the AllJoyn About key
 * @param language  Specifies the language tag of the AllJoyn About field
 */
-(void)putKey: (NSString *)key withStringValue: (NSString *)value andLanguage: (NSString *)language;

/**
 * Stores the provided array of values using the provided about key.
 *
 * @param key  Specifies the AllJoyn About key
 * @param value  Specifies the array of values for the AllJoyn About key
 */
-(void)putKey: (NSString *)key withStringArrayValue: (NSArray *)value;

/**
 * Stores the provided array of values using the provided about key.
 *
 * @param key  Specifies the AllJoyn About key
 * @param value  Specifies the array of values for the AllJoyn About key
 * @param language  Specifies the language tag of the AllJoyn About field
 */
-(void)putKey: (NSString *)key withStringArrayValue: (NSArray *)value andLanguage: (NSString *)language;

/**
 * Stores the provided byte data using the provided about key.
 *
 * @param key  Specifies the AllJoyn About key
 * @param value  Specifies the byte data for the AllJoyn About key
 */
-(void)putKey: (NSString *)key witDataValue: (NSData *)value;

/**
 * Stores the provided byte data using the provided about key.
 *
 * @param key  Specifies the AllJoyn About key
 * @param value  Specifies the byte data for the AllJoyn About key
 * @param language  Specifies the language tag of the AllJoyn About field
 */
-(void)putKey: (NSString *)key witDataValue: (NSData *)value andLanguage: (NSString *)language;

@end

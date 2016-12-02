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
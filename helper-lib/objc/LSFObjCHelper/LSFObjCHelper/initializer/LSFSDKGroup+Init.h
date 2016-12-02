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

#import "../LSFSDKGroup.h"

@interface LSFSDKGroup (Init)

/** @name Creating LSFSDKGroup */

/**
 * Constructs an instance of the LSFSDKGroup class.
 *
 * @param groupID The ID of the Group.
 *
 * @return Instance of LSFSDKGroup.
 *
 * @warning *Note:* This method is intended to be used internally. Client software should not instantiate
 * Groups directly, but should instead get them from the LSFSDKLightingDirector using the [[LSFSDKLightingDirector getLightingDirector] groups]
 * property.
 */
-(id)initWithGroupID: (NSString *)groupID;

/**
 * Constructs an instance of the LSFSDKGroup class.
 *
 * @param groupID The ID of the Group.
 * @param groupName The name of the Group
 *
 * @return Instance of LSFSDKGroup.
 *
 * @warning *Note:* This method is intended to be used internally. Client software should not instantiate
 * Groups directly, but should instead get them from the LSFSDKLightingDirector using the [[LSFSDKLightingDirector getLightingDirector] groups]
 * property.
 */
-(id)initWithGroupID: (NSString *)groupID andName: (NSString *)groupName;

@end
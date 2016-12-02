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
#import "LSFSDKGroupDelegate.h"

/**
 * Provides a base class for developers to extend and implement to receive all Group related events in the
 * Lighting system. Any method of the LSFSDKGroupDelegate interface that is not overridden in the subclass will
 * be treated as a no-op.
 *
 * **Note:** Once implemented, the subclass must be registered with the LSFSDKLightingDirector in order
 * to receive Group callbacks. See [LSFSDKLightingDirector addGroupDelegate:] for more information.
 */
@interface LSFSDKGroupDelegateBase : NSObject <LSFSDKGroupDelegate>

@end
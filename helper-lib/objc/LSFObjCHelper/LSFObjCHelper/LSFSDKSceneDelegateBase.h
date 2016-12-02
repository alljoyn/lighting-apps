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
#import "LSFSDKSceneDelegate.h"

/**
 * Provides a base class for developers to extend and implement to receive all Scene related events in the
 * Lighting system. Any method of the LSFSDKSceneDelegate interface that is not overridden in the subclass will
 * be treated as a no-op.
 *
 * **Note:** Once implemented, the delegate must be registered with the LSFSDKLightingDirector in order
 * to receive Scene callbacks. See [LSFSDKLightingDirector addSceneDelegate:] for more information.
 */
@interface LSFSDKSceneDelegateBase : NSObject <LSFSDKSceneDelegate>

@end
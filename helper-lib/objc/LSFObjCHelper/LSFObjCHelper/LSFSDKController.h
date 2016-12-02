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

#import "LSFSDKLightingItem.h"
#import "model/LSFControllerModel.h"

/**
 * This class provides an interface to retrieve information about a given controller
 * in the Lighting system.
 *
 * @warning Client software should not instantiate the LSFSDKController directly, but should
 * instead get it from the LSFSDKLightingDirector using the [LSFSDKLightingDirector leadController]
 * method.
 */
@interface LSFSDKController : LSFSDKLightingItem
{
    @protected LSFControllerModel *controllerModel;
}

/** @name Class Properties */

/**
 * Returns a boolean that indicates if it is the lead controller in the Lighting system.
 *
 * @return Return true if this is the lead controller, false otherwise
 */
@property (nonatomic, readonly) BOOL connected;

/**
 * Returns the version of the controller.
 *
 * @return Version of the controller.
 */
@property (nonatomic, readonly) unsigned int version;

/** @name Protected methods */

/**
 * @warning This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.
 */
-(LSFControllerModel *) getControllerDataModel;

@end
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

/**
 * Enum used to convey the status of a LSFSDKLightingController operation.
 */
typedef NS_ENUM(NSInteger, LightingControllerStatus) {
    /**
     * LSFSDKLightingController operation was successful.
     */
    OK,

    /**
     * An error occurred during the LSFSDKLightingController operation.
     */
    ERROR,

    /**
     * LSFSDKLightingController was already started when start was called.
     */
    ERROR_ALREADY_RUNNING,

    /**
     * Error occurred while initializing the LSFSDKLightingController.
     */
    ERROR_INIT
};
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

#import <LSFSDKResponseCodes.h>

/**
 * This class contains all pertinent information for errors that occur in the Lighting
 * controller. This class provides an interface to retrieve the following data: the name of
 * the error, the response code returned by the Lighting controller operation, and an array
 * of error codes.
 */
@interface LSFSDKControllerErrorEvent : NSObject

/**
 * The name of the error.
 */
@property (nonatomic, strong) NSString *name;

/**
 * Array of error codes.
 */
@property (nonatomic, strong) NSArray *errorCodes;

/**
 * The response code of the error.
 */
@property (nonatomic) lsf::LSFResponseCode responseCode;

/** @name Initializing an LSFSDKControllerErrorEvent Object */

/**
 * Constructs a LSFSDKControllerErrorEvent object.
 *
 * @param name The name of the error.
 * @param code The response code of the error.
 */
-(id)initWithName: (NSString *)name andResponseCode: (lsf::LSFResponseCode)code;

/**
 * Constructs a LSFSDKControllerErrorEvent object.
 *
 * @param name The name of the error.
 * @param errorCodes Array of ErrorCodes.
 */
-(id)initWithName: (NSString *)name andErrorCodes: (NSArray *)errorCodes;

@end
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

/**
 * Base interface that is implemented by all Lighting items and provides getters
 * for the item ID, name, as wells as child and parent Lighting items.
 */
@protocol LSFSDKLightingItemProtocol <NSObject>

/**
 * Returns the ID of the Lighting item.
 *
 * @return ID of the Lighting item
 */
@property (nonatomic, strong, readonly) NSString *theID;

/**
 * Returns the name of the Lighting item.
 *
 * @return Name of the Lighting item
 */
@property (nonatomic, strong, readonly) NSString *name;

/**
 * Returns the Lighting items parent containers.
 *
 * @return Array of Lighting item parent containers
 */
@property (nonatomic, strong, readonly) NSArray *dependents;

/**
 * Returns the Lighting items child components.
 *
 * @return Array of Lighting item child components
 */
@property (nonatomic, strong, readonly) NSArray *components;

@end
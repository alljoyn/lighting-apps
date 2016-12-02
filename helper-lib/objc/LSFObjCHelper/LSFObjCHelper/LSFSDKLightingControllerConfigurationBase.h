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

#import "LSFSDKLightingControllerConfiguration.h"

/**
 * Provides a base class for developers to extend or use directly to define the application and device
 * specific properties for the LSFSDKLightingController. This class can be instantiated and passed directly
 * to the LSFSDKLightingController without modification. Developers can override only the functions they wish
 * to change.
 *
 * An example usage of a LightingControllerConfigurationBase can be found in the LSFTutorial project.
 *
 * @warning All parameters are set using hard coded values EXCEPT the absolute save path which must be
 * passed in to the constructor.
 *
 * @warning Once implemented, the configuration must be registered with the LSFSDKLightingController
 * using the [LSFSDKLightingController initializeWithControllerConfiguration:] method.
 */
@interface LSFSDKLightingControllerConfigurationBase : NSObject <LSFSDKLightingControllerConfiguration>
{
    @private NSString *keystoreFilePath;
}

-(id)initWithKeystorePath: (NSString *)keystorePath;

@end
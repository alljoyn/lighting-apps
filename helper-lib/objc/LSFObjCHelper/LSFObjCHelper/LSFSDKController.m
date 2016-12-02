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

#import "LSFSDKController.h"
#import "LSFSDKLightingDirector.h"

@implementation LSFSDKController

@synthesize connected = _connected;
@synthesize version = _version;

-(id)init
{
    self = [super init];

    if (self)
    {
        controllerModel = [[LSFControllerModel alloc] init];
    }

    return self;
}

-(void)rename:(NSString *)name
{
    // This method is not yet implemented
    [self postError: [NSString stringWithUTF8String: __FUNCTION__] status: LSF_ERR_FAILURE];
}

-(BOOL)connected
{
    return [[self getControllerDataModel] connected];
}

-(unsigned int)version
{
    return [[self getControllerDataModel] controllerVersion];
}

-(LSFControllerModel *)getControllerDataModel
{
    return controllerModel;
}

-(LSFModel *)getItemDataModel
{
    return [self getControllerDataModel];
}

-(void)postError:(NSString *)name status:(LSFResponseCode)status
{
    dispatch_async([[[LSFSDKLightingDirector getLightingDirector] lightingManager] dispatchQueue], ^{
        [[[[LSFSDKLightingDirector getLightingDirector] lightingManager] controllerManager] sendErrorEventWithName: name andResonseCode: status];
    });
}

@end
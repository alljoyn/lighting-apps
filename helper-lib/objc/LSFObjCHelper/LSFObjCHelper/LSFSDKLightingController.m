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

#import "LSFSDKLightingController.h"

@implementation LSFSDKLightingController

+(LSFSDKLightingController *)getLightingController
{
    static LSFSDKLightingController *instance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}

-(id)init
{
    self = [super init];

    if (self)
    {
        controllerRunning = NO;
        controllerService = nil;
    }

    return self;
}

-(LightingControllerStatus)initializeWithControllerConfiguration: (id<LSFSDKLightingControllerConfiguration>)configuration
{
    if (controllerRunning || configuration == nil)
    {
        return ERROR_INIT;
    }

    controllerService = [[LSFSDKBasicControllerService alloc] initWithControllerConfiguration: configuration];
    return OK;
}

-(LightingControllerStatus)start
{
    if (controllerService != nil && controllerService.controllerConfiguration == nil)
    {
        return ERROR_INIT;
    }
    else if (controllerRunning)
    {
        return ERROR_ALREADY_RUNNING;
    }

    controllerRunning = YES;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [controllerService startControllerWithKeyStoreFilePath: [controllerService.controllerConfiguration getKeystorePath]];
    });

    return OK;
}

-(LightingControllerStatus)stop
{
    controllerRunning = NO;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [controllerService stopController];
    });

    return OK;
}

-(LightingControllerStatus)factoryReset
{
    [self stop];
    [controllerService factoryResetController];
    return OK;
}

-(LightingControllerStatus)lightingReset
{
    [self stop];
    [controllerService lightingResetController];
    return OK;
}

-(BOOL)isRunning
{
    return controllerRunning;
}

-(BOOL)isLeader
{
    return [controllerService isLeader];
}

-(NSString *)name
{
    return [controllerService name];
}

-(void)sendNetworkConnected
{
    if (controllerRunning)
    {
        [controllerService sendNetworkConnected];
    }
}

-(void)sendNetworkDisconnected
{
    if (controllerRunning)
    {
        [controllerService sendNetworkDisconnected];
    }
}

@end
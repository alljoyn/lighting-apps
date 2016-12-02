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

#import "LSFSDKControllerDelegateBase.h"
#import "LSFSDKLightingDirector.h"
#import "manager/LSFControllerManager.h"
#import "manager/LSFSDKLightingSystemManager.h"

@implementation LSFSDKControllerDelegateBase

@synthesize delegate = _delegate;

-(id)init
{
    self = [super init];

    if (self)
    {
        //Intentionally left blank
    }

    return self;
}

-(void)onLeaderChange: (LSFSDKController *)leader
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.delegate)
        {
            [self.delegate onNextControllerConnection];
        }
    });

    //Remove self as delegate
    LSFSDKLightingSystemManager *manager = [[LSFSDKLightingDirector getLightingDirector] lightingManager];
    [[manager controllerManager] removeDelegate: self];
}

-(void)onControllerError: (LSFSDKControllerErrorEvent *)errorEvent
{
    //Intentionally left blank
}

@end
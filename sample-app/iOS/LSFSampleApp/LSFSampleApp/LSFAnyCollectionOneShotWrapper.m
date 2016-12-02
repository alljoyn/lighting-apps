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

#import "LSFAnyCollectionOneShotWrapper.h"
#import <LSFSDKLightingDirector.h>

@implementation LSFAnyCollectionOneShotWrapper

@synthesize trackingID = _trackingID;
@synthesize trackingDelegate = _trackingDelegate;
@synthesize action = _action;
@synthesize errorAction = _errorAction;

-(id)initWithTrackingID: (LSFSDKTrackingID *)tid trackingIDDelegate: (id<LSFTrackingIDDelegate>)delegate
{
    return [self initWithTrackingID: tid trackingIDDelegate: delegate action: nil onError: nil];
}

-(id)initWithTrackingID: (LSFSDKTrackingID *)tid action: (void (^)(id item))actionOnFound
{
    return [self initWithTrackingID: tid action: actionOnFound onError: nil];
}

-(id)initWithTrackingID:(LSFSDKTrackingID *)tid action:(void (^)(id item))actionOnFound onError:(void (^)(id item))actionOnError
{
    return [self initWithTrackingID: tid trackingIDDelegate: nil action: actionOnFound onError: actionOnError];
}

-(id)initWithTrackingID: (LSFSDKTrackingID *)tid trackingIDDelegate: (id<LSFTrackingIDDelegate>)delegate action: (void (^)(id item))actionOnFound onError: (void (^)(id item))actionOnError
{
    self = [super init];

    if (self)
    {
        self.trackingID = tid;
        self.trackingDelegate = delegate;
        self.action = actionOnFound;
        self.errorAction = actionOnError;
    }

    return self;
}

-(void)dealloc
{
    self.trackingID = nil;
    self.trackingDelegate = nil;
}

-(void)onAnyInitializedWithTrackingID: (LSFSDKTrackingID *)tid andLightingItem: (id)item
{
    if (tid && (tid.value == self.trackingID.value))
    {
        [[LSFSDKLightingDirector getLightingDirector] removeDelegate: self];

        if (self.trackingDelegate)
        {
            [self.trackingDelegate onTrackingIDReceived: tid lightingItem: item];
        }

        if (self.action)
        {
            self.action(item);
        }
    }
}

-(void)onAnyError: (LSFSDKLightingItemErrorEvent *)error
{
    if (error.trackingID && (error.trackingID.value == self.trackingID.value))
    {
        [[LSFSDKLightingDirector getLightingDirector] removeDelegate: self];

        if (self.trackingDelegate)
        {
            [self.trackingDelegate onTrackingIDError: error];
        }

        if (self.errorAction)
        {
            self.errorAction(error);
        }
    }
}

@end
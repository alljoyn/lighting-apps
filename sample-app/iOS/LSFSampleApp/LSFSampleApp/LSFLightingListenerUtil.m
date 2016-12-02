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

#import "LSFLightingListenerUtil.h"
#import "LSFAnyCollectionOneShotWrapper.h"
#import <LSFSDKLightingDirector.h>

@implementation LSFLightingListenerUtil

+(void)listenForTrackingID: (LSFSDKTrackingID *)trackingID delegate: (id<LSFTrackingIDDelegate>)delegate
{
    LSFAnyCollectionOneShotWrapper *oneShotDelegate = [[LSFAnyCollectionOneShotWrapper alloc] initWithTrackingID: trackingID trackingIDDelegate: delegate];

    [[LSFSDKLightingDirector getLightingDirector] addDelegate: oneShotDelegate];
}

+(void)listenForTrackingID: (LSFSDKTrackingID *)trackingID perform: (void (^)(id item))performBlock
{
    LSFAnyCollectionOneShotWrapper *oneShotDelegate = [[LSFAnyCollectionOneShotWrapper alloc] initWithTrackingID: trackingID action: performBlock];
    [[LSFSDKLightingDirector getLightingDirector] addDelegate: oneShotDelegate];
}

+(void)listenForTrackingID: (LSFSDKTrackingID *)trackingID perform: (void (^)(id item))performBlock onError: (void (^)(id item))performError
{
    LSFAnyCollectionOneShotWrapper *oneShotDelegate = [[LSFAnyCollectionOneShotWrapper alloc] initWithTrackingID: trackingID action: performBlock onError: performError];
    [[LSFSDKLightingDirector getLightingDirector] addDelegate: oneShotDelegate];
}

@end
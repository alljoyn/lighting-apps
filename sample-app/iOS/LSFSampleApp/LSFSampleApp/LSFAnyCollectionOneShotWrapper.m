/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
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
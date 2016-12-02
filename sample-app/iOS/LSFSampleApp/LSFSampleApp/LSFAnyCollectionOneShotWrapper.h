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

#import "LSFAnyCollectionDelegateBase.h"
#import "LSFTrackingIDDelegate.h"

/*
 * AnyCollectionAdapter w/ one-shot trigger when objects are created. Wrapper
 * for TrackingIDDelegate.
 */
@interface LSFAnyCollectionOneShotWrapper : LSFAnyCollectionDelegateBase

@property (nonatomic, strong) LSFSDKTrackingID *trackingID;
@property (nonatomic, strong) id<LSFTrackingIDDelegate> trackingDelegate;
@property (nonatomic, strong) void (^action) (id item);
@property (nonatomic, strong) void (^errorAction) (id item);

-(id)initWithTrackingID: (LSFSDKTrackingID *)tid trackingIDDelegate: (id<LSFTrackingIDDelegate>)delegate;
-(id)initWithTrackingID: (LSFSDKTrackingID *)tid action: (void (^)(id item))actionOnFound;
-(id)initWithTrackingID: (LSFSDKTrackingID *)tid action: (void (^)(id item))actionOnFound onError: (void (^)(id item))actionOnError;

@end
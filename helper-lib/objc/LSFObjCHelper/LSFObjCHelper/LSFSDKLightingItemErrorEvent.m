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

#import "LSFSDKLightingItemErrorEvent.h"

@implementation LSFSDKLightingItemErrorEvent

@synthesize name = _name;
@synthesize responseCode = _responseCode;
@synthesize itemID = _itemID;
@synthesize trackingID = _trackingID;

-(id)initWithName: (NSString *)name responseCode: (lsf::LSFResponseCode)responseCode itemID: (NSString *)itemID andTrackingID: (LSFSDKTrackingID *)trackingID
{
    self = [super init];

    if (self)
    {
        self.name = name;
        self.responseCode = responseCode;
        self.itemID = itemID;
        self.trackingID = trackingID;
    }

    return self;
}

@end
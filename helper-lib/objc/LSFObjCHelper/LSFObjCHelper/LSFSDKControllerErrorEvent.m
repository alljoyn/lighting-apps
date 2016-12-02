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

#import "LSFSDKControllerErrorEvent.h"

@implementation LSFSDKControllerErrorEvent

@synthesize name = _name;
@synthesize errorCodes = _errorCodes;
@synthesize responseCode = _responseCode;

-(id)initWithName:(NSString *)name andResponseCode:(lsf::LSFResponseCode)code
{
    self = [super init];

    if (self)
    {
        self.name = name;
        self.responseCode = code;
        self.errorCodes = nil;
    }

    return self;
}

-(id)initWithName: (NSString *)name andErrorCodes: (NSArray *)errorCodes
{
    self = [super init];

    if (self)
    {
        self.name = name;
        self.errorCodes = errorCodes;
    }

    return self;
}

@end
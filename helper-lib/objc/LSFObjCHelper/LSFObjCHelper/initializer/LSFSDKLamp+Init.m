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

#import "LSFSDKLamp+Init.h"

@implementation LSFSDKLamp (Init)

-(id)initWithLampID: (NSString *)lampID
{
    self = [super init];

    if (self)
    {
        lampModel = [[LSFLampModel alloc] initWithLampID: lampID];
    }

    return self;
}

-(id)initWithLampID:(NSString *)lampID andName: (NSString *)lampName
{
    self = [super init];

    if (self)
    {
        lampModel = [[LSFLampModel alloc] initWithLampID: lampID andLampName: lampName];
    }

    return self;
}

@end
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

#import "LSFSDKPulseEffect+Init.h"

@implementation LSFSDKPulseEffect (Init)

-(id)initWithPulseEffectID: (NSString *)pulseEffectID
{
    return [self initWithPulseEffectID: pulseEffectID pulseEffectName: nil];
}

-(id)initWithPulseEffectID: (NSString *)pulseEffectID pulseEffectName: (NSString *)pulseEffectName
{
    self = [super init];

    if (self)
    {
        pulseEffectDataModel = [[LSFPulseEffectDataModelV2 alloc] initWithPulseEffectID: pulseEffectID andPulseEffectName: pulseEffectName];
    }

    return self;
}

@end
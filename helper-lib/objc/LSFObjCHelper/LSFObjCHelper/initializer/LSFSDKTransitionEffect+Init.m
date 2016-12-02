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

#import "LSFSDKTransitionEffect+Init.h"

@implementation LSFSDKTransitionEffect (Init)

-(id)initWithTransitionEffectID: (NSString *)transitionEffectID
{
    return [self initWithTransitionEffectID: transitionEffectID transitionEffectName: nil];
}

-(id)initWithTransitionEffectID: (NSString *)transitionEffectID transitionEffectName: (NSString *)transitionEffectName
{
    self = [super init];

    if (self)
    {
        transitionEffectDataModel = [[LSFTransitionEffectDataModelV2 alloc] initWithTransitionEffectID: transitionEffectID andTransitionEffectName: transitionEffectName];
    }

    return self;
}

@end
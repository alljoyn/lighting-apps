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

#import "LSFPendingEffect.h"
#import <LSFSDKLightingDirector.h>

@implementation LSFPendingEffect

@synthesize state = _state;
@synthesize endState = _endState;
@synthesize duration = _duration;
@synthesize period = _period;
@synthesize pulses = _pulses;

-(id)init
{
    self = [super init];

    if (self)
    {
        _state = nil;
        _endState = nil;
        _duration = 5000;
        _period = 1000;
        _pulses = 10;
    }

    return self;
}

-(id)initFromEffectID: (NSString *)effectID
{
    self = [self init];

    id<LSFSDKEffect> effect = [[LSFSDKLightingDirector getLightingDirector] getEffectWithID: effectID];

    if (effect)
    {
        self.theID = effect.theID;
        self.name = effect.name;

        if ([effect isKindOfClass: [LSFSDKPreset class]])
        {
            LSFSDKPreset *preset = (LSFSDKPreset *) effect;
            self.type = PRESET;
            self.state = [preset getState];
        }
        else if ([effect isKindOfClass: [LSFSDKTransitionEffect class]])
        {
            LSFSDKTransitionEffect *transitionEffect = (LSFSDKTransitionEffect *) effect;
            self.type = TRANSITION;
            self.state = [transitionEffect getState];
            self.duration = [transitionEffect duration];
        }
        else if ([effect isKindOfClass: [LSFSDKPulseEffect class]])
        {
            LSFSDKPulseEffect *pulseEffect = (LSFSDKPulseEffect *)effect;
            self.type = PULSE;
            self.state = [pulseEffect startState];
            self.endState = [pulseEffect endState];
            self.duration = [pulseEffect duration];
            self.period = [pulseEffect period];
            self.pulses = [pulseEffect count];
        }
    }
    else
    {
        NSLog(@"Effect not found in Lighting Director. Returning default pending object");
    }

    return self;
}

@end
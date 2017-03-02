/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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
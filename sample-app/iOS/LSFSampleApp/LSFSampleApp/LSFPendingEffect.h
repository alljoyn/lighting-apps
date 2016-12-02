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

#import "LSFPendingItem.h"
#import <LSFSDKMyLampState.h>

@interface LSFPendingEffect : LSFPendingItem

enum EffectV2Type {
    PRESET,
    TRANSITION,
    PULSE
};

enum EffectV2Property {
    STATE,
    DURATION,
    PERIOD,
    NUM_PULSES
};

@property (nonatomic, strong) LSFSDKMyLampState *state;
@property (nonatomic, strong) LSFSDKMyLampState *endState;
@property (nonatomic) int duration;
@property (nonatomic) int period;
@property (nonatomic) int pulses;
@property (nonatomic) EffectV2Type type;

-(id)initFromEffectID: (NSString *)effectID;

@end
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
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFDataModel.h"

@interface LSFDataModel()

@end

@implementation LSFDataModel

@synthesize state = _state;
@synthesize capability = _capability;
@synthesize uniformity = _uniformity;

-(id)initWithID: (NSString *)theID andName: (NSString *)name
{
    self = [super initWithID: theID andName: name];

    if (self)
    {
        self.state = [[LSFLampState alloc] init];
        self.capability = [[LSFCapabilityData alloc] init];
        self.uniformity = [[LSFLampStateUniformity alloc] init];
        stateInitialized = NO;
    }

    return self;
}

-(void)setState: (LSFLampState *)state
{
    _state = state;
    stateInitialized = YES;
}

-(BOOL)isInitialized
{
    return ([super isInitialized] && stateInitialized);
}

-(BOOL)isStateEqualToModelState: (LSFDataModel *)other
{
    return (other != nil) ? [self isStateEqualToLampState: other.state] : NO;
}

-(BOOL)isStateEqualToLampState: (LSFLampState *)otherState
{
    return otherState != nil ?
        [self isStateEqualToPowerOn: otherState.onOff hue: otherState.hue saturation: otherState.saturation brightness: otherState.brightness colorTemp: otherState.colorTemp] : NO;
}

-(BOOL)isStateEqualToPowerOn: (BOOL)onOff hue: (unsigned int)hue saturation:(unsigned int)saturation brightness:(unsigned int)brightness colorTemp:(unsigned int)colorTemp
{
    return
        [self.state hue]        == hue          &&
        [self.state saturation] == saturation   &&
        [self.state brightness] == brightness   &&
        [self.state colorTemp]  == colorTemp    &&
        [self.state onOff]      == onOff;
}

@end
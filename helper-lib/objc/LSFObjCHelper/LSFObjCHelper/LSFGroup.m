/******************************************************************************
 *  * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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

#import "LSFGroup.h"
#import "LSFGroupModel.h"
#import "LSFConstants.h"
#import "LSFAllJoynManager.h"

@interface LSFGroup()

@property (nonatomic, strong) LSFGroupModel *groupModel;

@end

@implementation LSFGroup

@synthesize groupModel = _groupModel;

-(id)initWithGroupID: (NSString *)groupID
{
    self = [super init];

    if (self)
    {
        self.groupModel = [[LSFGroupModel alloc] initWithGroupID: groupID];
    }

    return self;
}

-(id)initWithGroupID:(NSString *)groupID andName: (NSString *)groupName
{
    self = [super init];

    if (self)
    {
        self.groupModel = [[LSFGroupModel alloc] initWithGroupID: groupID andGroupName: groupName];
    }

    return self;
}

/*
 * Override base class functions
 */
-(void)setPowerOn: (BOOL)powerOn
{
    NSLog(@"LSFGroups - powerOn() executing");
    NSLog(@"Power is %@", powerOn ? @"On" : @"Off");

    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    [ajManager.lsfLampGroupManager transitionLampGroupID: self.groupModel.theID onOffField: powerOn];
}

-(void)setColorWithHue:(unsigned int)hueDegress saturation:(unsigned int)saturationPercent brightness:(unsigned int)brightnessPercent andColorTemp:(unsigned int)colorTempDegrees
{
    NSLog(@"LSFGroups - setColor() executing");
    NSLog(@"Hue = %u", hueDegress);
    NSLog(@"Saturation = %u", saturationPercent);
    NSLog(@"Brightness = %u", brightnessPercent);
    NSLog(@"ColorTemp = %u", colorTempDegrees);

    LSFConstants *constants = [LSFConstants getConstants];
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];

    unsigned int scaledBrightness = [constants scaleLampStateValue: brightnessPercent withMax: 100];
    unsigned int scaledHue = [constants scaleLampStateValue: hueDegress withMax: 360];
    unsigned int scaledSaturation = [constants scaleLampStateValue: saturationPercent withMax: 100];
    unsigned int scaledColorTemp = [constants scaleColorTemp: colorTempDegrees];

    LSFLampState *lampState = [[LSFLampState alloc] initWithOnOff: YES brightness: scaledBrightness hue: scaledHue saturation: scaledSaturation colorTemp: scaledColorTemp];
    [ajManager.lsfLampGroupManager transitionLampGroupID: self.groupModel.theID toState: lampState];
}

-(LSFDataModel *)getColorDataModel
{
    return [self getLampGroupDataModel];
}

-(LSFGroupModel *)getLampGroupDataModel
{
    return self.groupModel;
}

@end
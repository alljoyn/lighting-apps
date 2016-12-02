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

#import "LSFSDKMyLampState.h"
#import "model/LSFConstants.h"

@implementation LSFSDKMyLampState

static LSFSDKColor *DEFAULT_COLOR = [LSFSDKColor white];

@synthesize power = _power;
@synthesize color = _color;

-(id)initWithLSFLampState: (LSFLampState *)state
{
    LSFConstants *constants = [LSFConstants getConstants];
    unsigned int hue = [constants unscaleLampStateValue: state.hue withMax: 100];
    unsigned int saturation = [constants unscaleLampStateValue: state.saturation withMax: 100];
    unsigned int brightness = [constants unscaleLampStateValue: state.brightness withMax: 100];
    unsigned int colorTemp = [constants unscaleColorTemp: state.colorTemp];

    return [self initWithPower: (state.onOff ? ON : OFF) hue: hue saturation: saturation brightness: brightness colorTemp: colorTemp];

}

-(id)initWithPower: (Power)power hue: (unsigned int)hue saturation: (unsigned int)sat brightness: (unsigned int)brightness colorTemp: (unsigned int)colorTemp;
{
    return [self initWithPower: power color: [[LSFSDKColor alloc] initWithHue: hue saturation: sat brightness: brightness colorTemp: colorTemp]];
}

-(id)initWithPower: (Power)power color: (LSFSDKColor *)colorState
{
    self = [super init];

    if (self)
    {
        _power = power;
        _color = (colorState != nil) ? colorState : DEFAULT_COLOR;
    }

    return self;
}

/*
 * LSFLightingLampState implementation
 */
-(BOOL)getPowerOn
{
    return (self.power == ON);
}

-(void)setPowerOn: (BOOL)powerOn
{
    _power = (powerOn) ? ON : OFF;
}

-(NSArray *)getColorHsvt
{
    NSNumber *hue = [[NSNumber alloc] initWithUnsignedInt: self.color.hue];
    NSNumber *saturation = [[NSNumber alloc] initWithUnsignedInt: self.color.saturation];
    NSNumber *brightness = [[NSNumber alloc] initWithUnsignedInt: self.color.brightness];
    NSNumber *colorTemp = [[NSNumber alloc] initWithUnsignedInt: self.color.colorTemp];

    return [NSArray arrayWithObjects: hue, saturation, brightness, colorTemp, nil];
}

-(void)setColorHsvtWithHue: (unsigned int)hueDegrees saturation: (unsigned int)saturationPercent brightness: (unsigned int)brightnessPercent colorTemp: (unsigned int)colorTempDegrees
{
    _color.hue = hueDegrees;
    _color.saturation = saturationPercent;
    _color.brightness = brightnessPercent;
    _color.colorTemp = colorTempDegrees;
}

@end
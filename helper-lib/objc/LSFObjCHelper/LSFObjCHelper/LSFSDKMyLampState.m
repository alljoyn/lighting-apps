/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFSDKMyLampState.h"

@implementation LSFSDKMyLampState

@synthesize power = _power;
@synthesize color = _color;

-(id)initWithPower: (Power)power hue: (unsigned int)hue saturation: (unsigned int)sat brightness: (unsigned int)brightness colorTemp: (unsigned int)colorTemp;
{
    self = [super init];

    if (self)
    {
        _power = power;
        _color = [[LSFSDKColor alloc] initWithHue: hue saturation: sat brightness: brightness colorTemp: colorTemp];
    }

    return self;
}

-(id)initWithPower: (Power)power color: (LSFSDKColor *)colorState
{
    self = [super init];

    if (self)
    {
        _power = power;
        _color = [[LSFSDKColor alloc] initWithColor: colorState];
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
    //TODO - implement
}

-(NSArray *)getColorHsvt
{
    //TODO - implement
    return nil;
}

-(void)setColorHsvtWithHue: (unsigned int)hueDegrees saturation: (unsigned int)saturationPercent brightness: (unsigned int)brightnessPercent colorTemp: (unsigned int)colorTempDegrees
{
    //TODO - implement
}

@end

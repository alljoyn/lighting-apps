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

#import "LSFSDKColor.h"
#import "LSFConstants.h"

@implementation LSFSDKColor

@synthesize hue = _hue;
@synthesize saturation = _saturation;
@synthesize brightness = _brightness;
@synthesize colorTemp = _colorTemp;

-(id)initWithHsvt: (NSArray *)hsvt
{
    unsigned int hue = [(NSNumber *)[hsvt objectAtIndex: 0] unsignedIntValue];
    unsigned int saturation = [(NSNumber *)[hsvt objectAtIndex: 1] unsignedIntValue];
    unsigned int brightness = [(NSNumber *)[hsvt objectAtIndex: 2] unsignedIntValue];
    unsigned int colorTemp = [(NSNumber *)[hsvt objectAtIndex: 3] unsignedIntValue];

    return [self initWithHue: hue saturation: saturation brightness: brightness colorTemp: colorTemp];
}

-(id)initWithHue: (unsigned int)hueValue saturation: (unsigned int)satValue brightness: (unsigned int)brightnessValue colorTemp: (unsigned int)colorTempValue
{
    self = [super init];

    if (self)
    {
        self.hue = hueValue;
        self.saturation = satValue;
        self.brightness = brightnessValue;
        self.colorTemp = colorTempValue;
    }

    return self;
}

-(id)initWithColor: (LSFSDKColor *)color
{
    return [self initWithHue: color.hue saturation: color.saturation brightness: color.brightness colorTemp: color.colorTemp];
}

-(void)setHue: (unsigned int)hue
{
    LSFConstants *constants = [LSFConstants getConstants];
    _hue = MAX(MIN(hue, constants.MAX_HUE), constants.MIN_HUE);
}

-(void)setSaturation: (unsigned int)saturation
{
    LSFConstants *constants = [LSFConstants getConstants];
    _saturation = MAX(MIN(saturation, constants.MAX_SATURATION), constants.MIN_SATURATION);
}

-(void)setBrightness: (unsigned int)brightness
{
    LSFConstants *constants = [LSFConstants getConstants];
    _brightness = MAX(MIN(brightness, constants.MAX_BRIGHTNESS), constants.MIN_BRIGHTNESS);
}

-(void)setColorTemp: (unsigned int)colorTemp
{
    LSFConstants *constants = [LSFConstants getConstants];
    _colorTemp = MAX(MIN(colorTemp, constants.MAX_COLOR_TEMP), constants.MIN_COLOR_TEMP);
}

+(LSFSDKColor *)red
{
    static LSFSDKColor *red = nil;

    if (red == nil)
    {
        red = [[LSFSDKColor alloc] initWithHue: 0 saturation: 100 brightness: 100 colorTemp: 3500];
    }

    return red;
}

+(LSFSDKColor *)green
{
    static LSFSDKColor *green = nil;

    if (green == nil)
    {
        green = [[LSFSDKColor alloc] initWithHue: 120 saturation: 100 brightness: 50 colorTemp: 3500];
    }

    return green;
}

+(LSFSDKColor *)blue
{
    static LSFSDKColor *blue = nil;

    if (blue == nil)
    {
        blue = [[LSFSDKColor alloc] initWithHue: 240 saturation: 100 brightness: 100 colorTemp: 3500];
    }

    return blue;
}

+(LSFSDKColor *)white
{
    static LSFSDKColor *white = nil;

    if (white == nil)
    {
        white = [[LSFSDKColor alloc] initWithHue: 0 saturation: 0 brightness: 100 colorTemp: 3500];
    }

    return white;
}

@end

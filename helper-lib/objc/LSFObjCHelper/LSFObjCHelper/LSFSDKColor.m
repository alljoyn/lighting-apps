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

@implementation LSFSDKColor

@synthesize hue = _hue;
@synthesize saturation = _saturation;
@synthesize brightness = _brightness;
@synthesize colorTemp = _colorTemp;

-(id)initWithHsvt: (NSArray *)hsvt
{
    unsigned int hue = [(NSNumber *)[hsvt objectAtIndex: 0] unsignedIntegerValue];
    unsigned int saturation = [(NSNumber *)[hsvt objectAtIndex: 1] unsignedIntegerValue];
    unsigned int brightness = [(NSNumber *)[hsvt objectAtIndex: 2] unsignedIntegerValue];
    unsigned int colorTemp = [(NSNumber *)[hsvt objectAtIndex: 3] unsignedIntegerValue];

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
    //TODO - add bounds checking
    _hue = hue;
}

-(void)setSaturation: (unsigned int)saturation
{
    //TODO - add bounds checking
    _saturation = saturation;
}

-(void)setBrightness: (unsigned int)brightness
{
    //TODO - add bounds checking
    _brightness = brightness;
}

-(void)setColorTemp: (unsigned int)colorTemp
{
    //TODO - add bounds checking
    _colorTemp = colorTemp;
}

@end

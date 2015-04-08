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

#import "LSFSDKColorItem.h"

@implementation LSFSDKColorItem

-(void)turnOn
{
    NSLog(@"LSFColorItem - turnOn() executing");
    [self setPowerOn: YES];
}

-(void)turnOff
{
    NSLog(@"LSFColorItem - turnOff() executing");
    [self setPowerOn: NO];
}

-(void)setPower: (Power)power
{
    NSLog(@"LSFColorItem - setPower() executing");
    [self setPowerOn: (power == ON)];
}

-(Power)getPower
{
    NSLog(@"LSFColorItem - getPower() executing");
    return (([self getPowerOn]) ? ON : OFF);
}

-(void)setColorHsvt: (NSArray *)hsvt
{
    NSLog(@"LSFColorItem - setColorWithArray() executing");

    unsigned int hue = [(NSNumber *)[hsvt objectAtIndex: 0] unsignedIntegerValue];
    unsigned int saturation = [(NSNumber *)[hsvt objectAtIndex: 1] unsignedIntegerValue];
    unsigned int brightness = [(NSNumber *)[hsvt objectAtIndex: 2] unsignedIntegerValue];
    unsigned int colorTemp = [(NSNumber *)[hsvt objectAtIndex: 3] unsignedIntegerValue];

    [self setColorHsvtWithHue: hue saturation: saturation brightness: brightness colorTemp: colorTemp];
}

-(void)setColor: (LSFSDKColor *)color
{
    [self setColorHsvtWithHue: color.hue saturation: color.saturation brightness: color.brightness colorTemp: color.colorTemp];
}

-(LSFSDKColor *)getColor
{
    return [[LSFSDKColor alloc] initWithHsvt: [self getColorHsvt]];
}

-(LSFDataModel *)getColorDataModel;
{
    @throw [NSException exceptionWithName: NSInternalInconsistencyException reason: [NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo: nil];
}

//Override from base class
-(LSFModel *)getItemDataModel
{
    return [self getColorDataModel];
}

//LSFSDKLampState implementation
-(void)setPowerOn: (BOOL)powerOn
{
    @throw [NSException exceptionWithName: NSInternalInconsistencyException reason: [NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo: nil];
}

-(BOOL)getPowerOn
{
    NSLog(@"LSFColorItem - getPowerOn() executing");
    return [[[self getColorDataModel] state] onOff];
}

-(void)setColorHsvtWithHue: (unsigned int)hueDegress saturation: (unsigned int)saturationPercent brightness: (unsigned int)brightnessPercent colorTemp: (unsigned int)colorTempDegrees
{
    @throw [NSException exceptionWithName: NSInternalInconsistencyException reason: [NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo: nil];
}

-(NSArray *)getColorHsvt
{
    NSLog(@"LSFColorItem - getColorHsvt() executing");

    return [NSArray arrayWithObjects: [NSNumber numberWithUnsignedInt: [[[self getColorDataModel] state] hue]], [NSNumber numberWithUnsignedInt: [[[self getColorDataModel] state] saturation]], [NSNumber numberWithUnsignedInt: [[[self getColorDataModel] state] brightness]], [NSNumber numberWithUnsignedInt: [[[self getColorDataModel] state] colorTemp]], nil];
}

@end

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

#import "LSFSDKLamp.h"
#import "LSFConstants.h"
#import "LSFAllJoynManager.h"

@interface LSFSDKLamp()

@property (nonatomic, strong) LSFLampModel *lampModel;

@end

@implementation LSFSDKLamp

@synthesize lampModel = _lampModel;

-(id)initWithLampID: (NSString *)lampID
{
    self = [super init];

    if (self)
    {
        self.lampModel = [[LSFLampModel alloc] initWithLampID: lampID];
    }

    return self;
}

-(id)initWithLampID:(NSString *)lampID andName: (NSString *)lampName
{
    self = [super init];

    if (self)
    {
        self.lampModel = [[LSFLampModel alloc] initWithLampID: lampID andLampName: lampName];
    }

    return self;
}

/*
 * Override base class functions
 */
-(void)setPowerOn: (BOOL)powerOn
{
    NSLog(@"LSFLamps - powerOn() executing");
    NSLog(@"Power is %@", powerOn ? @"On" : @"Off");

    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    [ajManager.lsfLampManager transitionLampID: self.lampModel.theID onOffField: powerOn];
}

-(void)setColorHsvtWithHue:(unsigned int)hueDegrees saturation:(unsigned int)saturationPercent brightness:(unsigned int)brightnessPercent colorTemp:(unsigned int)colorTempDegrees
{
    NSLog(@"LSFLamps - setColor() executing");
    NSLog(@"Hue = %u", hueDegrees);
    NSLog(@"Saturation = %u", saturationPercent);
    NSLog(@"Brightness = %u", brightnessPercent);
    NSLog(@"ColorTemp = %u", colorTempDegrees);

    LSFConstants *constants = [LSFConstants getConstants];
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];

    unsigned int scaledBrightness = [constants scaleLampStateValue: brightnessPercent withMax: 100];
    unsigned int scaledHue = [constants scaleLampStateValue: hueDegrees withMax: 360];
    unsigned int scaledSaturation = [constants scaleLampStateValue: saturationPercent withMax: 100];
    unsigned int scaledColorTemp = [constants scaleColorTemp: colorTempDegrees];

    LSFLampState *lampState = [[LSFLampState alloc] initWithOnOff: YES brightness: scaledBrightness hue: scaledHue saturation: scaledSaturation colorTemp: scaledColorTemp];
    [ajManager.lsfLampManager transitionLampID: self.lampModel.theID toLampState: lampState];
}

-(void)rename: (NSString *)name
{
    //TODO - implement
}

-(void)applyPreset: (LSFSDKPreset *)preset
{
    //TODO - implement
}

-(void)applyEffect: (id<LSFSDKEffect>)effect
{
    //TODO - implement
}

-(LSFDataModel *)getColorDataModel
{
    return [self getLampDataModel];
}

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFLampModel *)getLampDataModel
{
    return self.lampModel;
}

@end

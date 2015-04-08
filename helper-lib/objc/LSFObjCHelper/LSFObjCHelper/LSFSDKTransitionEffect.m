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

#import "LSFSDKTransitionEffect.h"
#import "LSFSDKLamp.h"
#import "LSFSDKGroup.h"

@implementation LSFSDKTransitionEffect

-(id)initWithID: (NSString *)transitionEffectID
{
    //TODO - implement
    return nil;
}

-(id)initWithID: (NSString *)transitionEffectID name: (NSString *)name
{
    //TODO - implement
    return nil;
}

-(void)modify: (id<LSFSDKLampState>)state duration: (unsigned long)duration
{
    //TODO - implement
}

-(void)deleteTransitionEffect
{
    //TODO - implement
}

/*
 * LSFSDKEffect implementation
 */
-(void)applyToGroupMember: (LSFSDKGroupMember *)group
{
    //TODO - Implement
}

/*
 * Override base class functions
 */
-(void)setPowerOn:(BOOL)powerOn
{
    //TODO - implement
}

-(void)setColorHsvtWithHue:(unsigned int)hueDegrees saturation:(unsigned int)saturationPercent brightness:(unsigned int)brightnessPercent colorTemp:(unsigned int)colorTempDegrees
{
    //TODO - implement
}

-(void)rename:(NSString *)name
{
    //TODO - implement
}

-(LSFDataModel *)getColorDataModel
{
    return [self getTransitionEffectDataModel];
}

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFTransitionEffectDataModel *)getTransitionEffectDataModel
{
    //TODO - implement
    return nil;
}

@end

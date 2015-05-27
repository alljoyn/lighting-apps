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

#import "LSFSDKPulseEffect.h"
#import "LSFSDKLamp.h"
#import "LSFSDKGroup.h"
#import "LSFSDKAllJoynManager.h"
#import "LSFSDKLightingItemUtil.h"
#import "LSFSDKLightingDirector.h"

@implementation LSFSDKPulseEffect

-(id)initWithPulseEffectID: (NSString *)pulseEffectID
{
    return [self initWithPulseEffectID: pulseEffectID pulseEffectName: nil];
}

-(id)initWithPulseEffectID: (NSString *)pulseEffectID pulseEffectName: (NSString *)pulseEffectName
{
    self = [super init];

    if (self)
    {
        pulseEffectDataModel = [[LSFPulseEffectDataModelV2 alloc] initWithPulseEffectID: pulseEffectID andPulseEffectName: pulseEffectName];
    }

    return self;
}

-(void)modifyFromState: (id<LSFSDKLampState>)fromState toState: (id<LSFSDKLampState>)toState period: (unsigned int)period duration: (unsigned int)duration count: (unsigned int)count
{
    NSString *errorContext = @"LSFSDKPulseEffect modify: error";

    if ([self postInvalidArgIfNull: errorContext object: fromState] && [self postInvalidArgIfNull: errorContext object: toState])
    {
        if (([fromState isKindOfClass: [LSFSDKPreset class]]) && ([toState isKindOfClass: [LSFSDKPreset class]]))
        {
            [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getPulseEffectManager] updatePulseEffectWithID: pulseEffectDataModel.theID andPulseEffect: [LSFSDKLightingItemUtil createPulseeffectFromPreset: (LSFSDKPreset *)fromState toPreset: (LSFSDKPreset *)toState period: period duration: duration count: count]]];
        }
        else
        {
            [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getPulseEffectManager] updatePulseEffectWithID: pulseEffectDataModel.theID andPulseEffect: [LSFSDKLightingItemUtil createPulseEffectWithFromPowerOn: [fromState getPowerOn] fromColorHsvt: [fromState getColorHsvt] toPowerOn: [toState getPowerOn] toColorHsvt: [toState getColorHsvt] period: period duration: duration count: count]]];
        }
    }
}

-(void)deletePulseEffect
{
    NSString *errorContext = @"LSFSDKPulseEffect delete: error";

    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getPulseEffectManager] deletePulseEffectWithID: pulseEffectDataModel.theID]];
}

/*
 * LSFSDKEffect implementation
 */
-(void)applyToGroupMember: (LSFSDKGroupMember *)member
{
    NSString *errorContext = @"LSFSDKPulseEffect applyToGroupMember: error";

    if ([self postInvalidArgIfNull: errorContext object: member])
    {
        [member applyEffect: self];
    }
}

/*
 * Override base class functions
 */
-(void)rename:(NSString *)name
{
    NSString *errorContext = @"LSFSDKPulseEffect rename: error";

    if ([self postInvalidArgIfNull: errorContext object: name])
    {
        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getPulseEffectManager] setPulseEffectNameWithID: pulseEffectDataModel.theID pulseEffectName: name]];
    }
}

-(LSFDataModel *)getColorDataModel
{
    return [self getPulseEffectDataModel];
}

-(void)postError:(NSString *)name status:(LSFResponseCode)status
{
    dispatch_async([[[LSFSDKLightingDirector getLightingDirector] lightingManager] dispatchQueue], ^{
        [[[[LSFSDKLightingDirector getLightingDirector] lightingManager] pulseEffectCollectionManager] sendErrorEvent: name statusCode: status itemID: pulseEffectDataModel.theID];
    });
}

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFPulseEffectDataModelV2 *)getPulseEffectDataModel
{
    return pulseEffectDataModel;
}

@end

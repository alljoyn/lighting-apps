/******************************************************************************
 * Copyright (c) AllSeen Alliance. All rights reserved.
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

#import "LSFHelperPulseEffectManagerCallback.h"
#import "LSFDispatchQueue.h"
#import "LSFAllJoynManager.h"
#import "LSFPulseEffectCollectionManager.h"
#import "LSFSDKPulseEffect.h"
#import "LSFConstants.h"

@interface LSFHelperPulseEffectManagerCallback()

@property (nonatomic, strong) dispatch_queue_t queue;

-(void)postProcessPulseEffectID: (NSString *)pulseEffectID;
-(void)postUpdatePulseEffectID: (NSString *)pulseEffectID;
-(void)postUpdatePulseEffectID: (NSString *)pulseEffectID pulseEffectName: (NSString *)pulseEffectName;
-(void)postUpdatePulseEffectID: (NSString *)pulseEffectID pulseEffect: (LSFPulseEffectV2 *)pulseEffect;
-(void)postDeletePulseEffectIDs: (NSArray *)pulseEffectIDs;

@end

@implementation LSFHelperPulseEffectManagerCallback

@synthesize queue = _queue;

-(id)init
{
    self = [super init];

    if (self)
    {
        self.queue = [[LSFDispatchQueue getDispatchQueue] queue];
    }

    return self;
}

/*
 * Implementation of LSFPulseEffectManagerCallbackDelegate
 */
-(void)getPulseEffectReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andPulseEffect: (LSFPulseEffectV2 *)pulseEffect
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - getPulseEffectReply()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    dispatch_async(self.queue, ^{
        [self postUpdatePulseEffectID: pulseEffectID pulseEffect: pulseEffect];
    });
}

-(void)applyPulseEffectOnLampsReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andLampIDs: (NSArray *)lampIDs
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - applyPulseEffectOnLamps()");

    if (rc != LSF_OK)
    {
        NSLog(@"applyPulseEffectOnLamps() return error code %@", [NSString stringWithUTF8String: LSFResponseCodeText(rc)]);
    }

    //TODO - add implementation later, if needed
}

-(void)applyPulseEffectOnLampGroupsReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andLampGroupIDs: (NSArray *)lampGroupIDs
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - applyPulseEffectOnLampGroups()");

    if (rc != LSF_OK)
    {
        NSLog(@"applyPulseEffectOnLampGroups() return error code %@", [NSString stringWithUTF8String: LSFResponseCodeText(rc)]);
    }

    //TODO - add implementation later, if needed
}

-(void)getAllPulseEffectIDsReplyWithCode: (LSFResponseCode)rc pulseEffectIDs: (NSArray *)pulseEffectIDs
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - getAllPulseEffectIDs() Count = %lu", (unsigned long)pulseEffectIDs.count);

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    dispatch_async(self.queue, ^{
        for (NSString *pulseEffectID in pulseEffectIDs)
        {
            [self postProcessPulseEffectID: pulseEffectID];
        }
    });
}

-(void)getPulseEffectNameReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID language: (NSString *)language andPulseEffectName: (NSString *)pulseEffectName
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - getPulseEffectName()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    dispatch_async(self.queue, ^{
        [self postUpdatePulseEffectID: pulseEffectID pulseEffectName: pulseEffectName];
    });
}

-(void)getPulseEffectVersionReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andPulseEffectVersion: (unsigned int)pulseEffectVersion
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - getPulseEffectVersion()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    //TODO - implement
}

-(void)setPulseEffectNameReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andLanguage: (NSString *)language
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - setPulseEffectName()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    dispatch_async(self.queue, ^{
        [[[LSFAllJoynManager getAllJoynManager] lsfPulseEffectManager] getPulseEffectNameWithID: pulseEffectID];
    });
}

-(void)pulseEffectsNameChanged: (NSArray *)pulseEffectIDs
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - pulseEffectsNameChanged()");

    dispatch_async(self.queue, ^{
        BOOL containsNewIDs = NO;
        NSMutableDictionary *pulseEffects = [[LSFPulseEffectCollectionManager getPulseEffectCollectionManager] pulseEffectContainer];
        LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];

        for (NSString *pulseEffectID in pulseEffectIDs)
        {
            if ([pulseEffects valueForKey: pulseEffectID] != nil)
            {
                [ajManager.lsfPulseEffectManager getPulseEffectNameWithID: pulseEffectID];
            }
            else
            {
                containsNewIDs = YES;
            }
        }

        if (containsNewIDs)
        {
            [ajManager.lsfPulseEffectManager getAllPulseEffectIDs];
        }
    });
}

-(void)createPulseEffectReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andTrackingID: (unsigned int)trackingID
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - createPulseEffect()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }
}

-(void)pulseEffectsCreated: (NSArray *)pulseEffectIDs
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - pulseEffectsCreated()");

    dispatch_async(self.queue, ^{
        [[[LSFAllJoynManager getAllJoynManager] lsfPulseEffectManager] getAllPulseEffectIDs];
    });
}

-(void)updatePulseEffectReplyWithCode: (LSFResponseCode)rc andPulseEffectID: (NSString *)pulseEffectID
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - updatePulseEffect()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }
}

-(void)pulseEffectsUpdated: (NSArray *)pulseEffectIDs
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - pulseEffectsUpdated()");

    dispatch_async(self.queue, ^{
        for (NSString *pulseEffectID in pulseEffectIDs)
        {
            [[[LSFAllJoynManager getAllJoynManager] lsfPulseEffectManager] getPulseEffectWithID: pulseEffectID];
        }
    });
}

-(void)deletePulseEffectReplyWithCode: (LSFResponseCode)rc andPulseEffectID: (NSString *)pulseEffectID
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - deletePulseEffect()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }
}

-(void)pulseEffectsDeleted: (NSArray *)pulseEffectIDs
{
    NSLog(@"LSFHelperPulseEffectManagerCallback - pulseEffectsDeleted()");

    [self postDeletePulseEffectIDs: pulseEffectIDs];
}

/*
 * Private Functions
 */
-(void)postProcessPulseEffectID: (NSString *)pulseEffectID
{
    LSFSDKPulseEffect *pulseEffect = [[[LSFPulseEffectCollectionManager getPulseEffectCollectionManager] pulseEffectContainer] valueForKey: pulseEffectID];

    if (pulseEffect == nil)
    {
        NSLog(@"Calling get data set for pulse effect");
        [self postUpdatePulseEffectID: pulseEffectID];
        [[[LSFAllJoynManager getAllJoynManager] lsfPulseEffectManager] getPulseEffectDataSetWithID: pulseEffectID];
    }
}

-(void)postUpdatePulseEffectID: (NSString *)pulseEffectID
{
    NSLog(@"Adding pulse effect to container");
    LSFSDKPulseEffect *pulseEffect = [[LSFSDKPulseEffect alloc] initWithPulseEffectID: pulseEffectID];
    [[[LSFPulseEffectCollectionManager getPulseEffectCollectionManager] pulseEffectContainer] setValue: pulseEffect forKey: pulseEffectID];

    //TODO - add code to send the effect changed callback
}

-(void)postUpdatePulseEffectID: (NSString *)pulseEffectID pulseEffectName: (NSString *)pulseEffectName
{
    LSFPulseEffectDataModelV2 *pulseEffectDataModel = [[[[LSFPulseEffectCollectionManager getPulseEffectCollectionManager] pulseEffectContainer] valueForKey: pulseEffectID] getPulseEffectDataModel];

    if (pulseEffectDataModel != nil)
    {
        NSLog(@"Adding pulse effect name");
        pulseEffectDataModel.name = pulseEffectName;
    }

    //TODO - add code to send the effect changed callback
}

-(void)postUpdatePulseEffectID: (NSString *)pulseEffectID pulseEffect: (LSFPulseEffectV2 *)pulseEffect
{
    LSFPulseEffectDataModelV2 *pulseEffectDataModel = [[[[LSFPulseEffectCollectionManager getPulseEffectCollectionManager] pulseEffectContainer] valueForKey: pulseEffectID] getPulseEffectDataModel];

    LSFConstants *constants = [LSFConstants getConstants];

    if (pulseEffectDataModel != nil)
    {
        pulseEffectDataModel.state.onOff = pulseEffect.fromState.onOff;
        pulseEffectDataModel.state.brightness = [constants unscaleLampStateValue: pulseEffect.fromState.brightness withMax: 100];
        pulseEffectDataModel.state.hue = [constants unscaleLampStateValue: pulseEffect.fromState.hue withMax: 360];
        pulseEffectDataModel.state.saturation = [constants unscaleLampStateValue: pulseEffect.fromState.saturation withMax: 100];
        pulseEffectDataModel.state.colorTemp = [constants unscaleColorTemp: pulseEffect.fromState.colorTemp];

        pulseEffectDataModel.endState.onOff = pulseEffect.toState.onOff;
        pulseEffectDataModel.endState.brightness = [constants unscaleLampStateValue: pulseEffect.toState.brightness withMax: 100];
        pulseEffectDataModel.endState.hue = [constants unscaleLampStateValue: pulseEffect.toState.hue withMax: 360];
        pulseEffectDataModel.endState.saturation = [constants unscaleLampStateValue: pulseEffect.toState.saturation withMax: 100];
        pulseEffectDataModel.endState.colorTemp = [constants unscaleColorTemp: pulseEffect.toState.colorTemp];

        pulseEffectDataModel.startPresetID = pulseEffect.fromPreset;
        pulseEffectDataModel.endPresetID = pulseEffect.toPreset;

        pulseEffectDataModel.duration = pulseEffect.pulseDuration;
        pulseEffectDataModel.period = pulseEffect.pulsePeriod;
        pulseEffectDataModel.count = pulseEffect.numPulses;
    }

    //TODO - add code to send the effect changed callback
}

-(void)postDeletePulseEffectIDs: (NSArray *)pulseEffectIDs
{
    NSLog(@"Deleting pulse effect from container");
    NSMutableDictionary *pulseEffects = [[LSFPulseEffectCollectionManager getPulseEffectCollectionManager] pulseEffectContainer];

    for (NSString *pulseEffectID in pulseEffectIDs)
    {
        [pulseEffects removeObjectForKey: pulseEffectID];
    }
}

@end

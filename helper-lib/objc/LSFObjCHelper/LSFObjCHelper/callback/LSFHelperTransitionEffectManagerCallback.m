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

#import "LSFHelperTransitionEffectManagerCallback.h"
#import "LSFDispatchQueue.h"
#import "LSFAllJoynManager.h"
#import "LSFTransitionEffectCollectionManager.h"
#import "LSFSDKTransitionEffect.h"
#import "LSFConstants.h"

@interface LSFHelperTransitionEffectManagerCallback()

@property (nonatomic, strong) dispatch_queue_t queue;

-(void)postProcessTransitionEffectID: (NSString *)transitionEffectID;
-(void)postUpdateTransitionEffectID: (NSString *)transitionEffectID;
-(void)postUpdateTransitionEffectID: (NSString *)transitionEffectID transitionEffectName: (NSString *)transitionEffectName;
-(void)postUpdateTransitionEffectID: (NSString *)transitionEffectID transitionEffect: (LSFTransitionEffectV2 *)transitionEffect;
-(void)postDeleteTransitionEffectIDs: (NSArray *)transitionEffectIDs;
//Add fire event functions x2

@end

@implementation LSFHelperTransitionEffectManagerCallback

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
 * Implementation of LSFTransitionEffectManagerCallbackDelegate
 */
-(void)getTransitionEffectReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andTransitionEffect: (LSFTransitionEffectV2 *)transitionEffect
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - getTransitionEffectReply()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    dispatch_async(self.queue, ^{
        [self postUpdateTransitionEffectID: transitionEffectID transitionEffect: transitionEffect];
    });
}

-(void)applyTransitionEffectOnLampsReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andLampIDs: (NSArray *)lampIDs
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - applyTransitionEffectOnLamps()");

    if (rc != LSF_OK)
    {
        NSLog(@"applyTransitionEffectOnLamps() return error code %@", [NSString stringWithUTF8String: LSFResponseCodeText(rc)]);
    }

    //TODO - add implementation later, if needed
}

-(void)applyTransitionEffectOnLampGroupsReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andLampGroupIDs: (NSArray *)lampGroupIDs
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - applyTransitionEffectOnLampGroups()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    //TODO - add implementation later, if needed
}

-(void)getAllTransitionEffectIDsReplyWithCode: (LSFResponseCode)rc transitionEffectIDs: (NSArray *)transitionEffectIDs
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - getAllTransitionEffectIDs() Count = %lu", (unsigned long)transitionEffectIDs.count);

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    dispatch_async(self.queue, ^{
        for (NSString *transitionEffectID in transitionEffectIDs)
        {
            [self postProcessTransitionEffectID: transitionEffectID];
        }
    });
}

-(void)getTransitionEffectNameReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID language: (NSString *)language andTransitionEffectName: (NSString *)transitionEffectName
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - getTransitionEffectName()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    dispatch_async(self.queue, ^{
        [self postUpdateTransitionEffectID: transitionEffectID transitionEffectName: transitionEffectName];
    });
}

-(void)getTransitionEffectVersionReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andTransitionEffectVersion: (unsigned int)transitionEffectVersion
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - getTransitionEffectVersion()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    //TODO - implement
}

-(void)setTransitionEffectNameReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andLanguage: (NSString *)language
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - setTransitionEffectName()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }

    dispatch_async(self.queue, ^{
        [[[LSFAllJoynManager getAllJoynManager] lsfTransitionEffectManager] getTransitionEffectNameWithID: transitionEffectID];
    });
}

-(void)transitionEffectsNameChanged: (NSArray *)transitionEffectIDs
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - transitionEffectsNameChanged()");

    dispatch_async(self.queue, ^{
        BOOL containsNewIDs = NO;
        NSMutableDictionary *transitionEffects = [[LSFTransitionEffectCollectionManager getTranstionEffectCollectionManager] transitionEffectContainer];
        LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];

        for (NSString *transitionEffectID in transitionEffectIDs)
        {
            if ([transitionEffects valueForKey: transitionEffectID] != nil)
            {
                [ajManager.lsfTransitionEffectManager getTransitionEffectNameWithID: transitionEffectID];
            }
            else
            {
                containsNewIDs = YES;
            }
        }

        if (containsNewIDs)
        {
            [ajManager.lsfTransitionEffectManager getAllTransitionEffectIDs];
        }
    });
}

-(void)createTransitionEffectReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andTrackingID: (unsigned int)trackingID
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - createTransitionEffect()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }
}

-(void)transitionEffectsCreated: (NSArray *)transitionEffectIDs
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - transitionEffectsCreated()");

    dispatch_async(self.queue, ^{
        [[[LSFAllJoynManager getAllJoynManager] lsfTransitionEffectManager] getAllTransitionEffectIDs];
    });
}

-(void)updateTransitionEffectReplyWithCode: (LSFResponseCode)rc andTransitionEffectID: (NSString *)transitionEffectID
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - updateTransitionEffect()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }
}

-(void)transitionEffectsUpdated: (NSArray *)transitionEffectIDs
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - transitionEffectsUpdated()");

    dispatch_async(self.queue, ^{
        for (NSString *transitionEffectID in transitionEffectIDs)
        {
            [[[LSFAllJoynManager getAllJoynManager] lsfTransitionEffectManager] getTransitionEffectWithID: transitionEffectID];
        }
    });
}

-(void)deleteTransitionEffectReplyWithCode: (LSFResponseCode)rc andTransitionEffectID: (NSString *)transitionEffectID
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - deleteTransitionEffect()");

    if (rc != LSF_OK)
    {
        //TODO - trigger callback
    }
}

-(void)transitionEffectsDeleted: (NSArray *)transitionEffectIDs
{
    NSLog(@"LSFHelperTransitionEffectManagerCallback - transitionEffectsDeleted()");

    [self postDeleteTransitionEffectIDs: transitionEffectIDs];
}

/*
 * Private Functions
 */
-(void)postProcessTransitionEffectID: (NSString *)transitionEffectID
{
    LSFSDKTransitionEffect *transitionEffect = [[[LSFTransitionEffectCollectionManager getTranstionEffectCollectionManager] transitionEffectContainer] valueForKey: transitionEffectID];

    if (transitionEffect == nil)
    {
        NSLog(@"Calling get data set for transition effect");
        [self postUpdateTransitionEffectID: transitionEffectID];
        [[[LSFAllJoynManager getAllJoynManager] lsfTransitionEffectManager] getTransitionEffectDataSetWithID: transitionEffectID];
    }
}

-(void)postUpdateTransitionEffectID: (NSString *)transitionEffectID
{
    NSLog(@"Adding transition effect to container");
    LSFSDKTransitionEffect *transitionEffect = [[LSFSDKTransitionEffect alloc] initWithTransitionEffectID: transitionEffectID];
    [[[LSFTransitionEffectCollectionManager getTranstionEffectCollectionManager] transitionEffectContainer] setValue: transitionEffect forKey: transitionEffectID];

    //TODO - add code to send the effect changed callback
}

-(void)postUpdateTransitionEffectID: (NSString *)transitionEffectID transitionEffectName: (NSString *)transitionEffectName
{
    LSFTransitionEffectDataModelV2 *transitionEffectDataModel = [[[[LSFTransitionEffectCollectionManager getTranstionEffectCollectionManager] transitionEffectContainer] valueForKey: transitionEffectID] getTransitionEffectDataModel];

    if (transitionEffectDataModel != nil)
    {
        NSLog(@"Adding transition effect name");
        transitionEffectDataModel.name = transitionEffectName;
    }

    //TODO - add code to send the effect changed callback
}

-(void)postUpdateTransitionEffectID: (NSString *)transitionEffectID transitionEffect: (LSFTransitionEffectV2 *)transitionEffect
{
    LSFTransitionEffectDataModelV2 *transitionEffectDataModel = [[[[LSFTransitionEffectCollectionManager getTranstionEffectCollectionManager] transitionEffectContainer] valueForKey: transitionEffectID] getTransitionEffectDataModel];

    LSFConstants *constants = [LSFConstants getConstants];

    if (transitionEffectDataModel != nil)
    {
        NSLog(@"Updating transition effect data to model");

        //transitionEffectDataModel.state = transitionEffect.lampState;
        transitionEffectDataModel.state.onOff = transitionEffect.lampState.onOff;
        transitionEffectDataModel.state.brightness = [constants unscaleLampStateValue: transitionEffect.lampState.brightness withMax: 100];
        transitionEffectDataModel.state.hue = [constants unscaleLampStateValue: transitionEffect.lampState.hue withMax: 360];
        transitionEffectDataModel.state.saturation = [constants unscaleLampStateValue: transitionEffect.lampState.saturation withMax: 100];
        transitionEffectDataModel.state.colorTemp = [constants unscaleColorTemp: transitionEffect.lampState.colorTemp];

        transitionEffectDataModel.presetID = transitionEffect.presetID;
        transitionEffectDataModel.duration = transitionEffect.transitionPeriod;
    }

    //TODO - add code to send the effect changed callback
}

-(void)postDeleteTransitionEffectIDs: (NSArray *)transitionEffectIDs
{
    NSLog(@"Deleting transition effect from container");
    NSMutableDictionary *transitionEffects = [[LSFTransitionEffectCollectionManager getTranstionEffectCollectionManager] transitionEffectContainer];

    for (NSString *transitionEffectID in transitionEffectIDs)
    {
        [transitionEffects removeObjectForKey: transitionEffectID];
    }
}

@end

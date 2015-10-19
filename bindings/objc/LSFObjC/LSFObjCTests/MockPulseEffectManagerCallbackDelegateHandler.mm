/******************************************************************************
 * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "MockPulseEffectManagerCallbackDelegateHandler.h"

@interface MockPulseEffectManagerCallbackDelegateHandler()

@property (nonatomic) NSMutableArray *dataArray;

@end

@implementation MockPulseEffectManagerCallbackDelegateHandler

@synthesize dataArray = _dataArray;

-(id)init
{
    self = [super init];

    if (self)
    {
        self.dataArray = [[NSMutableArray alloc] init];
    }

    return self;
}

-(NSArray *)getCallbackData
{
    return self.dataArray;
}

//Delegate methods
-(void)getPulseEffectReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andPulseEffect: (LSFPulseEffectV2 *)pulseEffect
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithUnsignedInt: rc];
    NSNumber *period = [[NSNumber alloc] initWithUnsignedInt: pulseEffect.pulsePeriod];
    NSNumber *duration = [[NSNumber alloc] initWithUnsignedInt: pulseEffect.pulseDuration];
    NSNumber *numPulses = [[NSNumber alloc] initWithUnsignedInt: pulseEffect.numPulses];
    [self.dataArray addObject: @"getPulseEffect"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: pulseEffectID];
    [self.dataArray addObject: pulseEffect.fromPreset];
    [self.dataArray addObject: pulseEffect.toPreset];
    [self.dataArray addObject: period];
    [self.dataArray addObject: duration];
    [self.dataArray addObject: numPulses];
}

-(void)applyPulseEffectOnLampsReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andLampIDs: (NSArray *)lampIDs
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithUnsignedInt: rc];
    [self.dataArray addObject: @"applyPulseEffectOnLamps"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: pulseEffectID];
    [self.dataArray addObject: lampIDs];
}

-(void)applyPulseEffectOnLampGroupsReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andLampGroupIDs: (NSArray *)lampGroupIDs
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithUnsignedInt: rc];
    [self.dataArray addObject: @"applyPulseEffectOnLampGroups"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: pulseEffectID];
    [self.dataArray addObject: lampGroupIDs];
}

-(void)getAllPulseEffectIDsReplyWithCode: (LSFResponseCode)rc pulseEffectIDs: (NSArray *)pulseEffectIDs
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithUnsignedInt: rc];
    [self.dataArray addObject: @"getAllPulseEffectIDs"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: pulseEffectIDs];
}

-(void)getPulseEffectNameReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID language: (NSString *)language andPulseEffectName: (NSString *)pulseEffectName
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithUnsignedInt: rc];
    [self.dataArray addObject: @"getPulseEffectName"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: pulseEffectID];
    [self.dataArray addObject: language];
    [self.dataArray addObject: pulseEffectName];
}

-(void)setPulseEffectNameReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andLanguage: (NSString *)language
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithUnsignedInt: rc];
    [self.dataArray addObject: @"setPulseEffectName"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: pulseEffectID];
    [self.dataArray addObject: language];
}

-(void)pulseEffectsNameChanged: (NSArray *)pulseEffectIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"pulseEffectsNameChanged"];
    [self.dataArray addObject: pulseEffectIDs];
}

-(void)createPulseEffectReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andTrackingID: (unsigned int)trackingID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithUnsignedInt: rc];
    NSNumber *tid = [[NSNumber alloc] initWithUnsignedInt: trackingID];
    [self.dataArray addObject: @"createPulseEffect"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: pulseEffectID];
    [self.dataArray addObject: tid];
}

-(void)pulseEffectsCreated: (NSArray *)pulseEffectIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"pulseEffectsCreated"];
    [self.dataArray addObject: pulseEffectIDs];
}

-(void)updatePulseEffectReplyWithCode: (LSFResponseCode)rc andPulseEffectID: (NSString *)pulseEffectID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithUnsignedInt: rc];
    [self.dataArray addObject: @"updatePulseEffect"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: pulseEffectID];
}

-(void)pulseEffectsUpdated: (NSArray *)pulseEffectIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"pulseEffectsUpdated"];
    [self.dataArray addObject: pulseEffectIDs];
}

-(void)deletePulseEffectReplyWithCode: (LSFResponseCode)rc andPulseEffectID: (NSString *)pulseEffectID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithUnsignedInt: rc];
    [self.dataArray addObject: @"deletePulseEffect"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: pulseEffectID];
}

-(void)pulseEffectsDeleted: (NSArray *)pulseEffectIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"pulseEffectsDeleted"];
    [self.dataArray addObject: pulseEffectIDs];
}

@end
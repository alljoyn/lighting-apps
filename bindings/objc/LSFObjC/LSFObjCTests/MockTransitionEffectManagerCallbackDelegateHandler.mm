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

#import "MockTransitionEffectManagerCallbackDelegateHandler.h"

@interface MockTransitionEffectManagerCallbackDelegateHandler()

@property (nonatomic) NSMutableArray *dataArray;

@end

@implementation MockTransitionEffectManagerCallbackDelegateHandler

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
-(void)getTransitionEffectReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andTransitionEffect: (LSFTransitionEffectV2 *)transitionEffect
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    NSNumber *tp = [[NSNumber alloc] initWithUnsignedInt: transitionEffect.transitionPeriod];
    [self.dataArray addObject: @"getTransitionEffect"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: transitionEffectID];
    [self.dataArray addObject: transitionEffect.presetID];
    [self.dataArray addObject: tp];
}

-(void)applyTransitionEffectOnLampsReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andLampIDs: (NSArray *)lampIDs
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"applyTransitionEffectOnLamps"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: transitionEffectID];
    [self.dataArray addObject: lampIDs];
}

-(void)applyTransitionEffectOnLampGroupsReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andLampGroupIDs: (NSArray *)lampGroupIDs
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"applyTransitionEffectOnLampGroups"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: transitionEffectID];
    [self.dataArray addObject: lampGroupIDs];
}

-(void)getAllTransitionEffectIDsReplyWithCode: (LSFResponseCode)rc transitionEffectIDs: (NSArray *)transitionEffectIDs
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"getAllTransitionEffectIDs"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: transitionEffectIDs];
}

-(void)getTransitionEffectNameReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID language: (NSString *)language andTransitionEffectName: (NSString *)transitionEffectName
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"getTransitionEffectName"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: transitionEffectID];
    [self.dataArray addObject: language];
    [self.dataArray addObject: transitionEffectName];
}

-(void)setTransitionEffectNameReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andLanguage: (NSString *)language
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"setTransitionEffectName"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: transitionEffectID];
    [self.dataArray addObject: language];
}

-(void)transitionEffectsNameChanged: (NSArray *)transitionEffectIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"transitionEffectsNameChanged"];
    [self.dataArray addObject: transitionEffectIDs];
}

-(void)createTransitionEffectReplyWithCode: (LSFResponseCode)rc transitionEffectID: (NSString *)transitionEffectID andTrackingID: (unsigned int)trackingID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    NSNumber *tid = [[NSNumber alloc] initWithUnsignedInt: trackingID];
    [self.dataArray addObject: @"createTransitionEffect"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: transitionEffectID];
    [self.dataArray addObject: tid];
}

-(void)transitionEffectsCreated: (NSArray *)transitionEffectIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"transitionEffectsCreated"];
    [self.dataArray addObject: transitionEffectIDs];
}

-(void)updateTransitionEffectReplyWithCode: (LSFResponseCode)rc andTransitionEffectID: (NSString *)transitionEffectID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"updateTransitionEffect"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: transitionEffectID];
}

-(void)transitionEffectsUpdated: (NSArray *)transitionEffectIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"transitionEffectsUpdated"];
    [self.dataArray addObject: transitionEffectIDs];
}

-(void)deleteTransitionEffectReplyWithCode: (LSFResponseCode)rc andTransitionEffectID: (NSString *)transitionEffectID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"deleteTransitionEffect"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: transitionEffectID];
}

-(void)transitionEffectsDeleted: (NSArray *)transitionEffectIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"transitionEffectsDeleted"];
    [self.dataArray addObject: transitionEffectIDs];
}

@end
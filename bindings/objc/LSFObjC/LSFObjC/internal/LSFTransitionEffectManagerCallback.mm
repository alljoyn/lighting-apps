/******************************************************************************
 *  * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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

#import "LSFTransitionEffectManagerCallback.h"

LSFTransitionEffectManagerCallback::LSFTransitionEffectManagerCallback(id<LSFTransitionEffectManagerCallbackDelegate> delegate) : _temDelegate(delegate)
{
    //Empty Constructor
}

LSFTransitionEffectManagerCallback::~LSFTransitionEffectManagerCallback()
{
    _temDelegate = nil;
}

void LSFTransitionEffectManagerCallback::GetTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const TransitionEffect& transitionEffect)
{
    LSFLampState *lampState;

    if (transitionEffect.state.nullState)
    {
        lampState = [[LSFLampState alloc] init];
    }
    else
    {
        lampState = [[LSFLampState alloc] initWithOnOff: transitionEffect.state.onOff brightness: transitionEffect.state.brightness hue: transitionEffect.state.hue saturation: transitionEffect.state.saturation colorTemp:transitionEffect.state.colorTemp];
    }

    LSFTransitionEffectV2 *myTransitionEffect = [[LSFTransitionEffectV2 alloc] initWithLampState: lampState transitionPeriod: transitionEffect.transitionPeriod];
    myTransitionEffect.presetID = [NSString stringWithUTF8String: transitionEffect.presetID.c_str()];

    if (_temDelegate != nil)
    {
        [_temDelegate getTransitionEffectReplyWithCode: responseCode transitionEffectID: [NSString stringWithUTF8String: transitionEffectID.c_str()] andTransitionEffect: myTransitionEffect];
    }
}

void LSFTransitionEffectManagerCallback::ApplyTransitionEffectOnLampsReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFStringList& lampIDs)
{
    NSMutableArray *lampIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = lampIDs.begin(); iter != lampIDs.end(); ++iter)
    {
        [lampIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_temDelegate != nil)
    {
        [_temDelegate applyTransitionEffectOnLampsReplyWithCode: responseCode transitionEffectID: [NSString stringWithUTF8String: transitionEffectID.c_str()] andLampIDs: lampIDsArray];
    }
}

void LSFTransitionEffectManagerCallback::ApplyTransitionEffectOnLampGroupsReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFStringList& lampGroupIDs)
{
    NSMutableArray *groupIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = lampGroupIDs.begin(); iter != lampGroupIDs.end(); ++iter)
    {
        [groupIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_temDelegate != nil)
    {
        [_temDelegate applyTransitionEffectOnLampGroupsReplyWithCode: responseCode transitionEffectID: [NSString stringWithUTF8String: transitionEffectID.c_str()] andLampGroupIDs: groupIDsArray];
    }
}

void LSFTransitionEffectManagerCallback::GetAllTransitionEffectIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& transitionEffectIDs)
{
    NSMutableArray *transitionEffectIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = transitionEffectIDs.begin(); iter != transitionEffectIDs.end(); ++iter)
    {
        [transitionEffectIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_temDelegate != nil)
    {
        [_temDelegate getAllTransitionEffectIDsReplyWithCode: responseCode transitionEffectIDs: transitionEffectIDsArray];
    }
}

void LSFTransitionEffectManagerCallback::GetTransitionEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFString& language, const LSFString& transitionEffectName)
{
    if (_temDelegate != nil)
    {
        [_temDelegate getTransitionEffectNameReplyWithCode: responseCode transitionEffectID: [NSString stringWithUTF8String: transitionEffectID.c_str()] language: [NSString stringWithUTF8String: language.c_str()] andTransitionEffectName: [NSString stringWithUTF8String: transitionEffectName.c_str()]];
    }
}

void LSFTransitionEffectManagerCallback::SetTransitionEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFString& language)
{
    if (_temDelegate != nil)
    {
        [_temDelegate setTransitionEffectNameReplyWithCode: responseCode transitionEffectID: [NSString stringWithUTF8String: transitionEffectID.c_str()] andLanguage: [NSString stringWithUTF8String: language.c_str()]];
    }
}

void LSFTransitionEffectManagerCallback::TransitionEffectsNameChangedCB(const LSFStringList& transitionEffectIDs)
{
    NSMutableArray *transitionEffectIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = transitionEffectIDs.begin(); iter != transitionEffectIDs.end(); ++iter)
    {
        [transitionEffectIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_temDelegate != nil)
    {
        [_temDelegate transitionEffectsNameChanged: transitionEffectIDsArray];
    }
}

void LSFTransitionEffectManagerCallback::CreateTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const uint32_t& trackingID)
{
    if (_temDelegate != nil)
    {
        [_temDelegate createTransitionEffectReplyWithCode: responseCode transitionEffectID: [NSString stringWithUTF8String: transitionEffectID.c_str()] andTrackingID: trackingID];
    }
}

void LSFTransitionEffectManagerCallback::TransitionEffectsCreatedCB(const LSFStringList& transitionEffectIDs)
{
    NSMutableArray *transitionEffectIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = transitionEffectIDs.begin(); iter != transitionEffectIDs.end(); ++iter)
    {
        [transitionEffectIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_temDelegate != nil)
    {
        [_temDelegate transitionEffectsCreated: transitionEffectIDsArray];
    }
}

void LSFTransitionEffectManagerCallback::UpdateTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID)
{
    if (_temDelegate != nil)
    {
        [_temDelegate updateTransitionEffectReplyWithCode: responseCode andTransitionEffectID: [NSString stringWithUTF8String: transitionEffectID.c_str()]];
    }
}

void LSFTransitionEffectManagerCallback::TransitionEffectsUpdatedCB(const LSFStringList& transitionEffectIDs)
{
    NSMutableArray *transitionEffectIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = transitionEffectIDs.begin(); iter != transitionEffectIDs.end(); ++iter)
    {
        [transitionEffectIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_temDelegate != nil)
    {
        [_temDelegate transitionEffectsUpdated: transitionEffectIDsArray];
    }
}

void LSFTransitionEffectManagerCallback::DeleteTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID)
{
    if (_temDelegate != nil)
    {
        [_temDelegate deleteTransitionEffectReplyWithCode: responseCode andTransitionEffectID: [NSString stringWithUTF8String: transitionEffectID.c_str()]];
    }
}

void LSFTransitionEffectManagerCallback::TransitionEffectsDeletedCB(const LSFStringList& transitionEffectIDs)
{
    NSMutableArray *transitionEffectIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = transitionEffectIDs.begin(); iter != transitionEffectIDs.end(); ++iter)
    {
        [transitionEffectIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_temDelegate != nil)
    {
        [_temDelegate transitionEffectsDeleted: transitionEffectIDsArray];
    }
}
/******************************************************************************
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
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

#import "LSFSceneElementManagerCallback.h"
#import "LSFUtils.h"

LSFSceneElementManagerCallback::LSFSceneElementManagerCallback(id<LSFSceneElementManagerCallbackDelegate> delegate) : _semDelegate(delegate)
{
    //Empty Constructor
}

LSFSceneElementManagerCallback::~LSFSceneElementManagerCallback()
{
    _semDelegate = nil;
}

void LSFSceneElementManagerCallback::GetAllSceneElementIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& sceneElementIDs)
{
    NSMutableArray *sceneElementIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = sceneElementIDs.begin(); iter != sceneElementIDs.end(); ++iter)
    {
        [sceneElementIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_semDelegate != nil)
    {
        [_semDelegate getAllSceneElementIDsReplyWithCode: responseCode andSceneElementIDs: sceneElementIDsArray];
    }
}

void LSFSceneElementManagerCallback::GetSceneElementNameReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const LSFString& language, const LSFString& sceneElementName)
{
    if (_semDelegate != nil)
    {
        [_semDelegate getSceneElementNameReplyWithCode: responseCode sceneElementID: [NSString stringWithUTF8String: sceneElementID.c_str()] language: [NSString stringWithUTF8String: language.c_str()] andSceneElementName:[NSString stringWithUTF8String: sceneElementName.c_str()]];
    }
}

void LSFSceneElementManagerCallback::SetSceneElementNameReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const LSFString& language)
{
    if (_semDelegate != nil)
    {
        [_semDelegate setSceneElementNameReplyWithCode: responseCode sceneElementID: [NSString stringWithUTF8String: sceneElementID.c_str()] andLanguage: [NSString stringWithUTF8String: language.c_str()]];
    }
}

void LSFSceneElementManagerCallback::SceneElementsNameChangedCB(const LSFStringList& sceneElementIDs)
{
    NSMutableArray *sceneElementIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = sceneElementIDs.begin(); iter != sceneElementIDs.end(); ++iter)
    {
        [sceneElementIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_semDelegate != nil)
    {
        [_semDelegate sceneElementsNameChanged: sceneElementIDsArray];
    }
}

void LSFSceneElementManagerCallback::CreateSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const uint32_t& trackingID)
{
    if (_semDelegate != nil)
    {
        [_semDelegate createSceneElementReplyWithCode: responseCode sceneElementID: [NSString stringWithUTF8String: sceneElementID.c_str()] andTrackingID: trackingID];
    }
}

void LSFSceneElementManagerCallback::SceneElementsCreatedCB(const LSFStringList& sceneElementIDs)
{
    NSMutableArray *sceneElementIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = sceneElementIDs.begin(); iter != sceneElementIDs.end(); ++iter)
    {
        [sceneElementIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_semDelegate != nil)
    {
        [_semDelegate sceneElementsCreated: sceneElementIDsArray];
    }
}

void LSFSceneElementManagerCallback::UpdateSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID)
{
    if (_semDelegate != nil)
    {
        [_semDelegate updateSceneElementReplyWithCode: responseCode andSceneElementID: [NSString stringWithUTF8String: sceneElementID.c_str()]];
    }
}

void LSFSceneElementManagerCallback::SceneElementsUpdatedCB(const LSFStringList& sceneElementIDs)
{
    NSMutableArray *sceneElementIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = sceneElementIDs.begin(); iter != sceneElementIDs.end(); ++iter)
    {
        [sceneElementIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_semDelegate != nil)
    {
        [_semDelegate sceneElementsUpdated: sceneElementIDsArray];
    }
}

void LSFSceneElementManagerCallback::DeleteSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID)
{
    if (_semDelegate != nil)
    {
        [_semDelegate deleteSceneElementReplyWithCode: responseCode andSceneElementID: [NSString stringWithUTF8String: sceneElementID.c_str()]];
    }
}

void LSFSceneElementManagerCallback::SceneElementsDeletedCB(const LSFStringList& sceneElementIDs)
{
    NSMutableArray *sceneElementIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = sceneElementIDs.begin(); iter != sceneElementIDs.end(); ++iter)
    {
        [sceneElementIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_semDelegate != nil)
    {
        [_semDelegate sceneElementsDeleted: sceneElementIDsArray];
    }
}

void LSFSceneElementManagerCallback::GetSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const SceneElement& sceneElement)
{
    NSArray *lampIDs = [LSFUtils convertStringListToNSArray: sceneElement.lamps];
    NSArray *lampGroupIDs = [LSFUtils convertStringListToNSArray: sceneElement.lampGroups];
    LSFSceneElement *mySceneElement = [[LSFSceneElement alloc] initWithLampIDs: lampIDs lampGroupIDs: lampGroupIDs andEffectID: [NSString stringWithUTF8String: sceneElement.effectID.c_str()]];

    if (_semDelegate != nil)
    {
        [_semDelegate getSceneElementReplyWithCode: responseCode sceneElementID: [NSString stringWithUTF8String: sceneElementID.c_str()] andSceneElement: mySceneElement];
    }
}

void LSFSceneElementManagerCallback::ApplySceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID)
{
    if (_semDelegate != nil)
    {
        [_semDelegate applySceneElementReplyWithCode: responseCode andSceneElementID: [NSString stringWithUTF8String: sceneElementID.c_str()]];
    }
}

void LSFSceneElementManagerCallback::SceneElementsAppliedCB(const LSFStringList& sceneElementIDs)
{
    NSMutableArray *sceneElementIDsArray = [[NSMutableArray alloc] init];

    for (std::list<LSFString>::const_iterator iter = sceneElementIDs.begin(); iter != sceneElementIDs.end(); ++iter)
    {
        [sceneElementIDsArray addObject: [NSString stringWithUTF8String: (*iter).c_str()]];
    }

    if (_semDelegate != nil)
    {
        [_semDelegate sceneElementsApplied: sceneElementIDsArray];
    }
}
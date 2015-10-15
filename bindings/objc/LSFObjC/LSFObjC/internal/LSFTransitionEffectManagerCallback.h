/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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

#ifndef _LSF_TRANSITIONEFFECTMANAGER_CALLBACK_H
#define _LSF_TRANSITIONEFFECTMANAGER_CALLBACK_H

#import "LSFTransitionEffectManagerCallbackDelegate.h"
#import <TransitionEffectManager.h>

using namespace lsf;

class LSFTransitionEffectManagerCallback : public TransitionEffectManagerCallback {
public:
    LSFTransitionEffectManagerCallback(id<LSFTransitionEffectManagerCallbackDelegate> delegate);
    ~LSFTransitionEffectManagerCallback();
    void GetTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const TransitionEffect& transitionEffect);
    void ApplyTransitionEffectOnLampsReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFStringList& lampIDs);
    void ApplyTransitionEffectOnLampGroupsReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFStringList& lampGroupIDs);
    void GetAllTransitionEffectIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& transitionEffectIDs);
    void GetTransitionEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFString& language, const LSFString& transitionEffectName);
    void SetTransitionEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFString& language);
    void TransitionEffectsNameChangedCB(const LSFStringList& transitionEffectIDs);
    void CreateTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const uint32_t& trackingID);
    void TransitionEffectsCreatedCB(const LSFStringList& transitionEffectIDs);
    void UpdateTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID);
    void TransitionEffectsUpdatedCB(const LSFStringList& transitionEffectIDs);
    void DeleteTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID);
    void TransitionEffectsDeletedCB(const LSFStringList& transitionEffectIDs);

private:
    id<LSFTransitionEffectManagerCallbackDelegate> _temDelegate;
};

#endif /* defined(_LSF_TRANSITIONEFFECTMANAGER_CALLBACK_H) */
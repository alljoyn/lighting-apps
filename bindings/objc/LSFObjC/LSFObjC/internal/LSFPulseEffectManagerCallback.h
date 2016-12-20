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
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#ifndef _LSF_PULSEEFFECTMANAGER_CALLBACK_H
#define _LSF_PULSEEFFECTMANAGER_CALLBACK_H

#import "LSFPulseEffectManagerCallbackDelegate.h"
#import <PulseEffectManager.h>

using namespace lsf;

class LSFPulseEffectManagerCallback : public PulseEffectManagerCallback {
public:
    LSFPulseEffectManagerCallback(id<LSFPulseEffectManagerCallbackDelegate> delegate);
    ~LSFPulseEffectManagerCallback();
    void GetPulseEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const PulseEffect& pulseEffect);
    void ApplyPulseEffectOnLampsReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const LSFStringList& lampIDs);
    void ApplyPulseEffectOnLampGroupsReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const LSFStringList& lampGroupIDs);
    void GetAllPulseEffectIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& pulseEffectIDs);
    void GetPulseEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const LSFString& language, const LSFString& pulseEffectName);
    void SetPulseEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const LSFString& language);
    void PulseEffectsNameChangedCB(const LSFStringList& pulseEffectIDs);
    void CreatePulseEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const uint32_t& trackingID);
    void PulseEffectsCreatedCB(const LSFStringList& pulseEffectIDs);
    void UpdatePulseEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID);
    void PulseEffectsUpdatedCB(const LSFStringList& pulseEffectIDs);
    void DeletePulseEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID);
    void PulseEffectsDeletedCB(const LSFStringList& pulseEffectIDs);

private:
    id<LSFPulseEffectManagerCallbackDelegate> _pemDelegate;
};

#endif /* defined(_LSF_TRANSITIONEFFECTMANAGER_CALLBACK_H) */
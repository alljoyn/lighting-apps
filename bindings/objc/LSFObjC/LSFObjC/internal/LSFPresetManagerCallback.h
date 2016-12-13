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

#ifndef _LSF_PRESETMANAGER_CALLBACK_H
#define _LSF_PRESETMANAGER_CALLBACK_H

#import "LSFPresetManagerCallbackDelegate.h"
#import <PresetManager.h>

using namespace lsf;

class LSFPresetManagerCallback : public PresetManagerCallback {
public:
    LSFPresetManagerCallback(id<LSFPresetManagerCallbackDelegate> delegate);
    ~LSFPresetManagerCallback();
    void GetPresetReplyCB(const LSFResponseCode& responseCode, const LSFString& presetID, const LampState& preset);
    void GetAllPresetIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& presetIDs);
    void GetPresetNameReplyCB(const LSFResponseCode& responseCode, const LSFString& presetID, const LSFString& language, const LSFString& presetName);
    void SetPresetNameReplyCB(const LSFResponseCode& responseCode, const LSFString& presetID, const LSFString& language);
    void PresetsNameChangedCB(const LSFStringList& presetIDs);
    void CreatePresetReplyCB(const LSFResponseCode& responseCode, const LSFString& presetID);
    void CreatePresetWithTrackingReplyCB(const LSFResponseCode& responseCode, const LSFString& presetID, const uint32_t& trackingID);
    void PresetsCreatedCB(const LSFStringList& presetIDs);
    void UpdatePresetReplyCB(const LSFResponseCode& responseCode, const LSFString& presetID);
    void PresetsUpdatedCB(const LSFStringList& presetIDs);
    void DeletePresetReplyCB(const LSFResponseCode& responseCode, const LSFString& presetID);
    void PresetsDeletedCB(const LSFStringList& presetIDs);
    void GetDefaultLampStateReplyCB(const LSFResponseCode& responseCode, const LampState& defaultLampState);
    void SetDefaultLampStateReplyCB(const LSFResponseCode& responseCode);
    void DefaultLampStateChangedCB(void);
    
private:
    id<LSFPresetManagerCallbackDelegate> _pmDelegate;
};

#endif /* defined(_LSF_PRESETMANAGER_CALLBACK_H) */
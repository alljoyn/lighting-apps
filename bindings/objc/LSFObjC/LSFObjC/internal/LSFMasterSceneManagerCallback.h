/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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

#ifndef _LSF_MASTERSCENEMANAGER_CALLBACK_H
#define _LSF_MASTERSCENEMANAGER_CALLBACK_H

#import "LSFMasterSceneManagerCallbackDelegate.h"
#import <MasterSceneManager.h>

using namespace lsf;

class LSFMasterSceneManagerCallback : public MasterSceneManagerCallback {
public:
    LSFMasterSceneManagerCallback(id<LSFMasterSceneManagerCallbackDelegate> delegate);
    ~LSFMasterSceneManagerCallback();
    void GetAllMasterSceneIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& masterSceneList);
    void GetMasterSceneNameReplyCB(const LSFResponseCode& responseCode, const LSFString& masterSceneID, const LSFString& language, const LSFString& masterSceneName);
    void SetMasterSceneNameReplyCB(const LSFResponseCode& responseCode, const LSFString& masterSceneID, const LSFString& language);
    void MasterScenesNameChangedCB(const LSFStringList& masterSceneIDs);
    void CreateMasterSceneReplyCB(const LSFResponseCode& responseCode, const LSFString& masterSceneID);
    void CreateMasterSceneWithTrackingReplyCB(const LSFResponseCode& responseCode, const LSFString& masterSceneID, const uint32_t& trackingID);
    void MasterScenesCreatedCB(const LSFStringList& masterSceneIDs);
    void GetMasterSceneReplyCB(const LSFResponseCode& responseCode, const LSFString& masterSceneID, const MasterScene& masterScene);
    void DeleteMasterSceneReplyCB(const LSFResponseCode& responseCode, const LSFString& masterSceneID);
    void MasterScenesDeletedCB(const LSFStringList& masterSceneIDs);
    void UpdateMasterSceneReplyCB(const LSFResponseCode& responseCode, const LSFString& masterSceneID);
    void MasterScenesUpdatedCB(const LSFStringList& masterSceneIDs);
    void ApplyMasterSceneReplyCB(const LSFResponseCode& responseCode, const LSFString& masterSceneID);
    void MasterScenesAppliedCB(const LSFStringList& masterSceneIDs);
    
private:
    id<LSFMasterSceneManagerCallbackDelegate> _msmDelegate;
};

#endif /* defined(_LSF_MASTERSCENEMANAGER_CALLBACK_H) */
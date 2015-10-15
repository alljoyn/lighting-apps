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

#ifndef _LSF_SCENEELEMENTMANAGER_CALLBACK_H
#define _LSF_SCENEELEMENTMANAGER_CALLBACK_H

#import "LSFSceneElementManagerCallbackDelegate.h"
#import <SceneElementManager.h>

using namespace lsf;

class LSFSceneElementManagerCallback : public SceneElementManagerCallback {
public:
    LSFSceneElementManagerCallback(id<LSFSceneElementManagerCallbackDelegate> delegate);
    ~LSFSceneElementManagerCallback();
    void GetAllSceneElementIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& sceneElementIDs);
    void GetSceneElementNameReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const LSFString& language, const LSFString& sceneElementName);
    void SetSceneElementNameReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const LSFString& language);
    void SceneElementsNameChangedCB(const LSFStringList& sceneElementIDs);
    void CreateSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const uint32_t& trackingID);
    void SceneElementsCreatedCB(const LSFStringList& sceneElementIDs);
    void UpdateSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID);
    void SceneElementsUpdatedCB(const LSFStringList& sceneElementIDs);
    void DeleteSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID);
    void SceneElementsDeletedCB(const LSFStringList& sceneElementIDs);
    void GetSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const SceneElement& sceneElement);
    void ApplySceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID);
    void SceneElementsAppliedCB(const LSFStringList& sceneElementIDs);

private:
    id<LSFSceneElementManagerCallbackDelegate> _semDelegate;
};

#endif /* defined(_LSF_SCENEELEMENTMANAGER_CALLBACK_H) */
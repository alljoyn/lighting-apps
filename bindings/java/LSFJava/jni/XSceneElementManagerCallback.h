/******************************************************************************
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 *
 ******************************************************************************/

#ifndef LSF_JNI_XSCENEELEMENTMANAGERCALLBACK_H_
#define LSF_JNI_XSCENEELEMENTMANAGERCALLBACK_H_

#include <list>

#include <jni.h>

#include <SceneElementManager.h>   // lighting/service_framework

#include "NDefs.h"
#include "NUtil.h"
#include "NTypes.h"

namespace lsf {

class XSceneElementManagerCallback : public SceneElementManagerCallback {
  public:
    XSceneElementManagerCallback(jobject jobj);
    virtual ~XSceneElementManagerCallback();

    virtual void GetAllSceneElementIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& sceneElementIDs) LSF_OVERRIDE;
    virtual void GetSceneElementNameReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const LSFString& language, const LSFString& sceneElementName) LSF_OVERRIDE;
    virtual void SetSceneElementNameReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const LSFString& language) LSF_OVERRIDE;
    virtual void SceneElementsNameChangedCB(const LSFStringList& sceneElementIDs) LSF_OVERRIDE;
    virtual void CreateSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const uint32_t& trackingID) LSF_OVERRIDE;
    virtual void SceneElementsCreatedCB(const LSFStringList& sceneElementIDs) LSF_OVERRIDE;
    virtual void UpdateSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID) LSF_OVERRIDE;
    virtual void SceneElementsUpdatedCB(const LSFStringList& sceneElementIDs) LSF_OVERRIDE;
    virtual void DeleteSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID) LSF_OVERRIDE;
    virtual void SceneElementsDeletedCB(const LSFStringList& sceneElementIDs) LSF_OVERRIDE;
    virtual void GetSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const SceneElement& sceneElement) LSF_OVERRIDE;
    virtual void ApplySceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID) LSF_OVERRIDE;
    virtual void SceneElementsAppliedCB(const LSFStringList& sceneElementIDs) LSF_OVERRIDE;

  protected:
    jweak jdelegate;
};

} /* namespace lsf */
#endif /* LSF_JNI_XSCENEELEMENTMANAGERCALLBACK_H_ */
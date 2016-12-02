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

#ifndef LSF_JNI_XTRANSITIONEFFECTMANAGERCALLBACK_H_
#define LSF_JNI_XTRANSITIONEFFECTMANAGERCALLBACK_H_

#include <list>

#include <jni.h>

#include <TransitionEffectManager.h>   // lighting/service_framework

#include "NDefs.h"
#include "NUtil.h"
#include "NTypes.h"

namespace lsf {

class XTransitionEffectManagerCallback : public TransitionEffectManagerCallback {
  public:
    XTransitionEffectManagerCallback(jobject jobj);
    virtual ~XTransitionEffectManagerCallback();

    virtual void GetTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const TransitionEffect& transitionEffect) LSF_OVERRIDE;
    virtual void ApplyTransitionEffectOnLampsReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFStringList& lampIDs) LSF_OVERRIDE;
    virtual void ApplyTransitionEffectOnLampGroupsReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFStringList& lampGroupIDs) LSF_OVERRIDE;
    virtual void GetAllTransitionEffectIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& transitionEffectIDs) LSF_OVERRIDE;
    virtual void GetTransitionEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFString& language, const LSFString& transitionEffectName) LSF_OVERRIDE;
    virtual void SetTransitionEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const LSFString& language) LSF_OVERRIDE;
    virtual void TransitionEffectsNameChangedCB(const LSFStringList& transitionEffectIDs) LSF_OVERRIDE;
    virtual void CreateTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID, const uint32_t& trackingID) LSF_OVERRIDE;
    virtual void TransitionEffectsCreatedCB(const LSFStringList& transitionEffectIDs) LSF_OVERRIDE;
    virtual void UpdateTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID) LSF_OVERRIDE;
    virtual void TransitionEffectsUpdatedCB(const LSFStringList& transitionEffectIDs) LSF_OVERRIDE;
    virtual void DeleteTransitionEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& transitionEffectID) LSF_OVERRIDE;
    virtual void TransitionEffectsDeletedCB(const LSFStringList& transitionEffectIDs) LSF_OVERRIDE;

  protected:
    jweak jdelegate;
};

} /* namespace lsf */
#endif /* LSF_JNI_XTRANSITIONEFFECTMANAGERCALLBACK_H_ */
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

#ifndef LSF_JNI_XPULSEEFFECTMANAGERCALLBACK_H_
#define LSF_JNI_XPULSEEFFECTMANAGERCALLBACK_H_

#include <list>

#include <jni.h>

#include <PulseEffectManager.h>   // lighting/service_framework

#include "NDefs.h"
#include "NUtil.h"
#include "NTypes.h"

namespace lsf {

class XPulseEffectManagerCallback : public PulseEffectManagerCallback {
  public:
    XPulseEffectManagerCallback(jobject jobj);
    virtual ~XPulseEffectManagerCallback();

    virtual void GetPulseEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const PulseEffect& pulseEffect) LSF_OVERRIDE;
    virtual void ApplyPulseEffectOnLampsReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const LSFStringList& lampIDs) LSF_OVERRIDE;
    virtual void ApplyPulseEffectOnLampGroupsReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const LSFStringList& lampGroupIDs) LSF_OVERRIDE;
    virtual void GetAllPulseEffectIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& pulseEffectIDs) LSF_OVERRIDE;
    virtual void GetPulseEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const LSFString& language, const LSFString& pulseEffectName) LSF_OVERRIDE;
    virtual void SetPulseEffectNameReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const LSFString& language) LSF_OVERRIDE;
    virtual void PulseEffectsNameChangedCB(const LSFStringList& pulseEffectIDs) LSF_OVERRIDE;
    virtual void CreatePulseEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID, const uint32_t& trackingID) LSF_OVERRIDE;
    virtual void PulseEffectsCreatedCB(const LSFStringList& pulseEffectIDs) LSF_OVERRIDE;
    virtual void UpdatePulseEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID) LSF_OVERRIDE;
    virtual void PulseEffectsUpdatedCB(const LSFStringList& pulseEffectIDs) LSF_OVERRIDE;
    virtual void DeletePulseEffectReplyCB(const LSFResponseCode& responseCode, const LSFString& pulseEffectID) LSF_OVERRIDE;
    virtual void PulseEffectsDeletedCB(const LSFStringList& pulseEffectIDs) LSF_OVERRIDE;

  protected:
    jweak jdelegate;
};

} /* namespace lsf */
#endif /* LSF_JNI_XPULSEEFFECTMANAGERCALLBACK_H_ */
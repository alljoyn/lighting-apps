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

#ifndef LSF_JNI_JPULSEEFFECTMANAGER_H_
#define LSF_JNI_JPULSEEFFECTMANAGER_H_

#include <jni.h>

#include <PulseEffectManager.h>

#include "JControllerClient.h"
#include "XPulseEffectManagerCallback.h"

namespace lsf {

class XPulseEffectManager : public PulseEffectManager {
  public:
    XPulseEffectManager(jobject jobj, JControllerClient &xControllerClient, XPulseEffectManagerCallback &xPulseEffectManagerCallback);
    virtual ~XPulseEffectManager();
};

} /* namespace lsf */
#endif /* LSF_JNI_JPULSEEFFECTMANAGER_H_ */
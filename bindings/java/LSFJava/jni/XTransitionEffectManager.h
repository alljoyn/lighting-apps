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

#ifndef LSF_JNI_JTRANSITIONEFFECTMANAGER_H_
#define LSF_JNI_JTRANSITIONEFFECTMANAGER_H_

#include <jni.h>

#include <TransitionEffectManager.h>

#include "JControllerClient.h"
#include "XTransitionEffectManagerCallback.h"

namespace lsf {

class XTransitionEffectManager : public TransitionEffectManager {
  public:
    XTransitionEffectManager(jobject jobj, JControllerClient &xControllerClient, XTransitionEffectManagerCallback &xTransitionEffectManagerCallback);
    virtual ~XTransitionEffectManager();
};

} /* namespace lsf */
#endif /* LSF_JNI_JTRANSITIONEFFECTMANAGER_H_ */
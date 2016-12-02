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

#ifndef LSF_JNI_JSCENEELEMENTMANAGER_H_
#define LSF_JNI_JSCENEELEMENTMANAGER_H_

#include <jni.h>

#include <SceneElementManager.h>

#include "JControllerClient.h"
#include "XSceneElementManagerCallback.h"

namespace lsf {

class XSceneElementManager : public SceneElementManager {
  public:
    XSceneElementManager(jobject jobj, JControllerClient &xControllerClient, XSceneElementManagerCallback &xSceneElementManagerCallback);
    virtual ~XSceneElementManager();
};

} /* namespace lsf */
#endif /* LSF_JNI_JSCENEELEMENTMANAGER_H_ */
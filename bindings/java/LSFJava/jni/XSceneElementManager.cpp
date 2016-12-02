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

#include "XSceneElementManager.h"

namespace lsf {

XSceneElementManager::XSceneElementManager(jobject jobj, JControllerClient &xControllerClient, XSceneElementManagerCallback &xSceneElementManagerCallback) : SceneElementManager(xControllerClient, xSceneElementManagerCallback)
{
    // Currently nothing to do
}

XSceneElementManager::~XSceneElementManager()
{
    // Currently nothing to do
}

} /* namespace lsf */
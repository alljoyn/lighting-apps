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

#include "XTransitionEffectManagerCallback.h"

#include "NUtil.h"

#include "org_allseen_lsf_TransitionEffectManagerCallback.h"

using namespace lsf;

JNIEXPORT
void JNICALL Java_org_allseen_lsf_TransitionEffectManagerCallback_createNativeObject(JNIEnv *env, jobject thiz)
{
    CreateHandle<XTransitionEffectManagerCallback>(thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_TransitionEffectManagerCallback_destroyNativeObject(JNIEnv *env, jobject thiz)
{
    DestroyHandle<XTransitionEffectManagerCallback>(thiz);
}

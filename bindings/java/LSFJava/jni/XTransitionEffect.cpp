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

// This .cpp file is #include'd in the .h file because some templated
// methods must be defined there. The following #ifdef allows the
// templated code to be visible there.
#ifdef LSF_JNI_XTRANSITIONEFFECT_H_INCLUDE_TEMPLATE_METHODS

#include <qcc/Debug.h>

#include "NDefs.h"
#include "XTransitionEffect.h"

#define QCC_MODULE LSF_QCC_MODULE

namespace lsf {

template <typename T>
void XTransitionEffect::SetTransitionPeriod(JNIEnv *env, jobject thiz, jlong jTransitionPeriod)
{
    T *xDelegate = GetHandle<T*>(thiz);
    if (env->ExceptionCheck() || !xDelegate) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return;
    }

    xDelegate->transitionPeriod = (uint32_t)jTransitionPeriod;
}

template <typename T>
jlong XTransitionEffect::GetTransitionPeriod(JNIEnv *env, jobject thiz)
{
    T *xDelegate = GetHandle<T*>(thiz);
    if (env->ExceptionCheck() || !xDelegate) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return (jint)0;
    }

    return (jlong)xDelegate->transitionPeriod;
}

} /* namespace lsf */

#undef QCC_MODULE

#endif /* LSF_JNI_XTRANSITIONEFFECT_H_INCLUDE_TEMPLATE_METHODS */
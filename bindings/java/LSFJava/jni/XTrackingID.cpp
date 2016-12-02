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

#include <stddef.h>

#include <qcc/Debug.h>

#include "XTrackingID.h"
#include "NUtil.h"

#define QCC_MODULE "AJN-LSF-JNI"

namespace lsf {

jobject XTrackingID::NewTrackingID()
{
    JScopedEnv env;

    jmethodID jConstructor = env->GetMethodID(XClass::xTrackingID->classRef, "<init>", "()V");
    if (env->ExceptionCheck() || !jConstructor) {
        QCC_LogError(ER_FAIL, ("GetMethodID() failed"));
        return NULL;
    }

    jobject jTrackingID = env->NewObject(XClass::xTrackingID->classRef, jConstructor);
    if (env->ExceptionCheck() || !jTrackingID) {
        QCC_LogError(ER_FAIL, ("NewObject() failed"));
        return NULL;
    }

    return jTrackingID;
}

jobject XTrackingID::SetTrackingID(jobject jTrackingID, const uint32_t& cTrackingID)
{
    JScopedEnv env;

    jfieldID jFieldID = env->GetFieldID(XClass::xTrackingID->classRef, "value", "J");
    if (env->ExceptionCheck() || !jFieldID) {
        QCC_LogError(ER_FAIL, ("GetFieldID() failed"));
        return NULL;
    }

    env->SetLongField(jTrackingID, jFieldID, (jlong)cTrackingID);

    return jTrackingID;
}

} /* namespace lsf */

#undef QCC_MODULE
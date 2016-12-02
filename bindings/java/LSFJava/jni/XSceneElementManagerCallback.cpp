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

#include <qcc/Debug.h>

#include "JEnum.h"
#include "XJavaDelegator.h"
#include "XSceneElement.h"
#include "XSceneElementManagerCallback.h"

#define QCC_MODULE "AJN-LSF-JNI"

using namespace ajn;

namespace lsf {

XSceneElementManagerCallback::XSceneElementManagerCallback(jobject jobj)
{
    // Get the JNIEnv for the current native thread
    JScopedEnv env;

    /*
     * Be careful when using a weak global reference.  They can only be
     * passed to NewLocalRef, NewGlobalRef and DeleteWeakGlobalRef.
     */
    QCC_DbgPrintf(("Taking weak global reference to Java object %p", jobj));
    jdelegate = env->NewWeakGlobalRef(jobj);
    if (env->ExceptionCheck() || !jdelegate) {
        QCC_LogError(ER_FAIL, ("NewWeakGlobalRef() failed"));
        return;
    }
}

XSceneElementManagerCallback::~XSceneElementManagerCallback()
{
    // Get the JNIEnv for the current native thread
    JScopedEnv env;

    env->DeleteWeakGlobalRef(jdelegate);
    if (env->ExceptionCheck()) {
        QCC_LogError(ER_FAIL, ("DeleteWeakGlobalRef() failed"));
        return;
    }
}

void XSceneElementManagerCallback::GetAllSceneElementIDsReplyCB(const LSFResponseCode& responseCode, const LSFStringList& sceneElementIDs)
{
    XJavaDelegator::Call_Void_ResponseCode_StringList(jdelegate, __func__, responseCode, sceneElementIDs);
}

void XSceneElementManagerCallback::GetSceneElementNameReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const LSFString& language, const LSFString& sceneElementName)
{
    XJavaDelegator::Call_Void_ResponseCode_String_String_String(jdelegate, __func__, responseCode, sceneElementID, language, sceneElementName);
}

void XSceneElementManagerCallback::SetSceneElementNameReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const LSFString& language)
{
    XJavaDelegator::Call_Void_ResponseCode_String_String(jdelegate, __func__, responseCode, sceneElementID, language);
}

void XSceneElementManagerCallback::SceneElementsNameChangedCB(const LSFStringList& sceneElementIDs)
{
    XJavaDelegator::Call_Void_StringList(jdelegate, __func__, sceneElementIDs);
}

void XSceneElementManagerCallback::CreateSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const uint32_t& trackingID)
{
    XJavaDelegator::Call_Void_ResponseCode_String_UInt32(jdelegate, __func__, responseCode, sceneElementID, trackingID);
}

void XSceneElementManagerCallback::SceneElementsCreatedCB(const LSFStringList& sceneElementIDs)
{
    XJavaDelegator::Call_Void_StringList(jdelegate, __func__, sceneElementIDs);
}

void XSceneElementManagerCallback::UpdateSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID)
{
    XJavaDelegator::Call_Void_ResponseCode_String(jdelegate, __func__, responseCode, sceneElementID);
}

void XSceneElementManagerCallback::SceneElementsUpdatedCB(const LSFStringList& sceneElementIDs)
{
    XJavaDelegator::Call_Void_StringList(jdelegate, __func__, sceneElementIDs);
}

void XSceneElementManagerCallback::DeleteSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID)
{
    XJavaDelegator::Call_Void_ResponseCode_String(jdelegate, __func__, responseCode, sceneElementID);
}

void XSceneElementManagerCallback::SceneElementsDeletedCB(const LSFStringList& sceneElementIDs)
{
    XJavaDelegator::Call_Void_StringList(jdelegate, __func__, sceneElementIDs);
}

void XSceneElementManagerCallback::GetSceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID, const SceneElement& sceneElement)
{
    XJavaDelegator::Call_Void_ResponseCode_String_Object<SceneElement, XSceneElement>(jdelegate, __func__, XClass::xSceneElement, responseCode, sceneElementID, sceneElement);
}

void XSceneElementManagerCallback::ApplySceneElementReplyCB(const LSFResponseCode& responseCode, const LSFString& sceneElementID)
{
    XJavaDelegator::Call_Void_ResponseCode_String(jdelegate, __func__, responseCode, sceneElementID);
}

void XSceneElementManagerCallback::SceneElementsAppliedCB(const LSFStringList& sceneElementIDs)
{
    XJavaDelegator::Call_Void_StringList(jdelegate, __func__, sceneElementIDs);
}

} /* namespace lsf */
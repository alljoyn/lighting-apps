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

#include "NUtil.h"
#include "JEnum.h"
#include "JStringArray.h"
#include "XObject.h"
#include "XSceneWithSceneElements.h"

#include "org_allseen_lsf_SceneWithSceneElements.h"

#define QCC_MODULE "AJN-LSF-JNI"

using namespace ajn;
using namespace lsf;

JNIEXPORT
void JNICALL Java_org_allseen_lsf_SceneWithSceneElements_setSceneElements(JNIEnv *env, jobject thiz, jobjectArray jSceneElements)
{
    XSceneWithSceneElements *xSceneWithSceneElements = GetHandle<XSceneWithSceneElements*>(thiz);
    if (env->ExceptionCheck() || !xSceneWithSceneElements) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return;
    }

    JStringArray::CopyStringArray(jSceneElements, xSceneWithSceneElements->sceneElements);
}

JNIEXPORT
jobjectArray JNICALL Java_org_allseen_lsf_SceneWithSceneElements_getSceneElements(JNIEnv *env, jobject thiz)
{
    XSceneWithSceneElements *xSceneWithSceneElements = GetHandle<XSceneWithSceneElements*>(thiz);
    if (env->ExceptionCheck() || !xSceneWithSceneElements) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    jobjectArray jSceneElements = JStringArray::NewStringArray(xSceneWithSceneElements->sceneElements);
    if (env->ExceptionCheck() || !jSceneElements) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    return jSceneElements;
}

JNIEXPORT jobject JNICALL Java_org_allseen_lsf_SceneWithSceneElements_isDependentOnSceneElement(JNIEnv *env, jobject thiz, jstring jSceneElementID)
{
    XSceneWithSceneElements* xSceneWithSceneElements = GetHandle<XSceneWithSceneElements*>(thiz);
    if (env->ExceptionCheck() || !xSceneWithSceneElements) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    JString xSceneElementID(jSceneElementID);
    if (env->ExceptionCheck()) {
        QCC_LogError(ER_FAIL, ("JString failed"));
        return NULL;
    }

    if (!xSceneElementID.c_str()) {
        QCC_LogError(ER_FAIL, ("JString invalid"));
        return NULL;
    }

    LSFString cSceneElementID = xSceneElementID.c_str();

    jobject jResponseCode = JEnum::jResponseCodeEnum->getObject((int)(xSceneWithSceneElements->IsDependentOnSceneElement(cSceneElementID)));
    if (env->ExceptionCheck() || !jResponseCode) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    return jResponseCode;
}

JNIEXPORT
jstring JNICALL Java_org_allseen_lsf_SceneWithSceneElements_toString(JNIEnv *env, jobject thiz)
{
    return XObject::ToString<XSceneWithSceneElements>(env, thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_SceneWithSceneElements_createNativeObject(JNIEnv *env, jobject thiz)
{
    CreateHandle<XSceneWithSceneElements>(thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_SceneWithSceneElements_destroyNativeObject(JNIEnv *env, jobject thiz)
{
    DestroyHandle<XSceneWithSceneElements>(thiz);
}
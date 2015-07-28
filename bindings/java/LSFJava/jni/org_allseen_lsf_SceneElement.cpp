/******************************************************************************
 * Copyright (c) AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 ******************************************************************************/

#include <qcc/Debug.h>

#include "JLampState.h"
#include "NUtil.h"
#include "XSceneElement.h"
#include "XLampMemberList.h"
#include "XObject.h"

#include "org_allseen_lsf_SceneElement.h"

#define QCC_MODULE "AJN-LSF-JNI"

using namespace ajn;
using namespace lsf;

JNIEXPORT
void JNICALL Java_org_allseen_lsf_SceneElement_setLamps(JNIEnv *env, jobject thiz, jobjectArray jLampIDs)
{
    XLampMemberList::SetLamps<XSceneElement>(env, thiz, jLampIDs);
}

JNIEXPORT
jobjectArray JNICALL Java_org_allseen_lsf_SceneElement_getLamps(JNIEnv *env, jobject thiz)
{
    return XLampMemberList::GetLamps<XSceneElement>(env, thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_SceneElement_setLampGroups(JNIEnv *env, jobject thiz, jobjectArray jLampGroupIDs)
{
    XLampMemberList::SetLampGroups<XSceneElement>(env, thiz, jLampGroupIDs);
}

JNIEXPORT
jobjectArray JNICALL Java_org_allseen_lsf_SceneElement_getLampGroups(JNIEnv *env, jobject thiz)
{
    return XLampMemberList::GetLampGroups<XSceneElement>(env, thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_SceneElement_setEffectID(JNIEnv *env, jobject thiz, jstring jEffectID)
{
    XSceneElement *xSceneElement = GetHandle<XSceneElement*>(thiz);
    if (env->ExceptionCheck() || !xSceneElement) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return;
    }

    JString xEffectID(jEffectID);
    if (env->ExceptionCheck()) {
        QCC_LogError(ER_FAIL, ("JString failed"));
        return;
    }

    if (!xEffectID.c_str()) {
        QCC_LogError(ER_FAIL, ("JString invalid"));
        return;
    }

    xSceneElement->effectID = xEffectID.c_str();
}

JNIEXPORT
jstring JNICALL Java_org_allseen_lsf_SceneElement_getEffectID(JNIEnv *env, jobject thiz)
{
    XSceneElement *xSceneElement = GetHandle<XSceneElement*>(thiz);
    if (env->ExceptionCheck() || !xSceneElement) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    jstring jEffectID = env->NewStringUTF(xSceneElement->effectID.c_str());
    if (env->ExceptionCheck() || !jEffectID) {
        QCC_LogError(ER_FAIL, ("NewStringUTF() failed"));
        return NULL;
    }

    return jEffectID;
}

JNIEXPORT
jstring JNICALL Java_org_allseen_lsf_SceneElement_toString(JNIEnv *env, jobject thiz)
{
    return XObject::ToString<XSceneElement>(env, thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_SceneElement_createNativeObject(JNIEnv *env, jobject thiz)
{
    CreateHandle<XSceneElement>(thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_SceneElement_destroyNativeObject(JNIEnv *env, jobject thiz)
{
    DestroyHandle<XSceneElement>(thiz);
}
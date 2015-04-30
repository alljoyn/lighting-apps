/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
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
#include "XTransitionEffect.h"
#include "XTransitionEffectV10.h"

#include "org_allseen_lsf_TransitionEffect.h"

#define QCC_MODULE "AJN-LSF-JNI"

using namespace ajn;
using namespace lsf;

JNIEXPORT
void JNICALL Java_org_allseen_lsf_TransitionEffect_setLampState(JNIEnv *env, jobject thiz, jobject jLampState)
{
    XTransitionEffect *xTransitionEffect = GetHandle<XTransitionEffect*>(thiz);
    if (env->ExceptionCheck() || !xTransitionEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return;
    }

    JLampState::CopyLampState(jLampState, xTransitionEffect->state);
}

JNIEXPORT
jobject JNICALL Java_org_allseen_lsf_TransitionEffect_getLampState(JNIEnv *env, jobject thiz)
{
    XTransitionEffect *xTransitionEffect = GetHandle<XTransitionEffect*>(thiz);
    if (env->ExceptionCheck() || !xTransitionEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    return JLampState::NewLampState(xTransitionEffect->state);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_TransitionEffect_setPresetID(JNIEnv *env, jobject thiz, jstring jPresetID)
{
    XTransitionEffect *xTransitionEffect = GetHandle<XTransitionEffect*>(thiz);
    if (env->ExceptionCheck() || !xTransitionEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return;
    }

    JString xPresetID(jPresetID);
    if (env->ExceptionCheck()) {
        QCC_LogError(ER_FAIL, ("JString failed"));
        return;
    }

    if (!xPresetID.c_str()) {
        QCC_LogError(ER_FAIL, ("JString invalid"));
        return;
    }

    xTransitionEffect->presetID = xPresetID.c_str();
}

JNIEXPORT
jstring JNICALL Java_org_allseen_lsf_TransitionEffect_getPresetID(JNIEnv *env, jobject thiz)
{
    XTransitionEffect *xTransitionEffect = GetHandle<XTransitionEffect*>(thiz);
    if (env->ExceptionCheck() || !xTransitionEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    jstring jPresetID = env->NewStringUTF(xTransitionEffect->presetID.c_str());
    if (env->ExceptionCheck() || !jPresetID) {
        QCC_LogError(ER_FAIL, ("NewStringUTF() failed"));
        return NULL;
    }

    return jPresetID;
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_TransitionEffect_setTransitionPeriod(JNIEnv *env, jobject thiz, jlong jTransitionPeriod)
{
    XTransitionEffectV10::SetTransitionPeriod<XTransitionEffect>(env, thiz, jTransitionPeriod);
}

JNIEXPORT
jlong JNICALL Java_org_allseen_lsf_TransitionEffect_getTransitionPeriod(JNIEnv *env, jobject thiz)
{
    return XTransitionEffectV10::GetTransitionPeriod<XTransitionEffect>(env, thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_TransitionEffect_createNativeObject(JNIEnv *env, jobject thiz)
{
    CreateHandle<XTransitionEffect>(thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_TransitionEffect_destroyNativeObject(JNIEnv *env, jobject thiz)
{
    DestroyHandle<XTransitionEffect>(thiz);
}


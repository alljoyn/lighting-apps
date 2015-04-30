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
#include "XPulseEffect.h"
#include "XPulseEffectV10.h"

#include "org_allseen_lsf_PulseEffect.h"

#define QCC_MODULE "AJN-LSF-JNI"

using namespace ajn;
using namespace lsf;

JNIEXPORT
void JNICALL Java_org_allseen_lsf_PulseEffect_setToLampState(JNIEnv *env, jobject thiz, jobject jLampState)
{
    XPulseEffect *xPulseEffect = GetHandle<XPulseEffect*>(thiz);
    if (env->ExceptionCheck() || !xPulseEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return;
    }

    JLampState::CopyLampState(jLampState, xPulseEffect->toState);
}

JNIEXPORT
jobject JNICALL Java_org_allseen_lsf_PulseEffect_getToLampState(JNIEnv *env, jobject thiz)
{
    XPulseEffect *xPulseEffect = GetHandle<XPulseEffect*>(thiz);
    if (env->ExceptionCheck() || !xPulseEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    return JLampState::NewLampState(xPulseEffect->toState);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_PulseEffect_setFromLampState(JNIEnv *env, jobject thiz, jobject jLampState)
{
    XPulseEffect *xPulseEffect = GetHandle<XPulseEffect*>(thiz);
    if (env->ExceptionCheck() || !xPulseEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return;
    }

    JLampState::CopyLampState(jLampState, xPulseEffect->fromState);
}

JNIEXPORT
jobject JNICALL Java_org_allseen_lsf_PulseEffect_getFromLampState(JNIEnv *env, jobject thiz)
{
    XPulseEffect *xPulseEffect = GetHandle<XPulseEffect*>(thiz);
    if (env->ExceptionCheck() || !xPulseEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    return JLampState::NewLampState(xPulseEffect->fromState);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_PulseEffect_setToPresetID(JNIEnv *env, jobject thiz, jstring jPresetID)
{
    XPulseEffect *xPulseEffect = GetHandle<XPulseEffect*>(thiz);
    if (env->ExceptionCheck() || !xPulseEffect) {
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

    xPulseEffect->toPreset = xPresetID.c_str();
}

JNIEXPORT
jstring JNICALL Java_org_allseen_lsf_PulseEffect_getToPresetID(JNIEnv *env, jobject thiz)
{
    XPulseEffect *xPulseEffect = GetHandle<XPulseEffect*>(thiz);
    if (env->ExceptionCheck() || !xPulseEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    jstring jPresetID = env->NewStringUTF(xPulseEffect->toPreset.c_str());
    if (env->ExceptionCheck() || !jPresetID) {
        QCC_LogError(ER_FAIL, ("NewStringUTF() failed"));
        return NULL;
    }

    return jPresetID;
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_PulseEffect_setFromPresetID(JNIEnv *env, jobject thiz, jstring jPresetID)
{
    XPulseEffect *xPulseEffect = GetHandle<XPulseEffect*>(thiz);
    if (env->ExceptionCheck() || !xPulseEffect) {
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

    xPulseEffect->fromPreset = xPresetID.c_str();
}

JNIEXPORT
jstring JNICALL Java_org_allseen_lsf_PulseEffect_getFromPresetID(JNIEnv *env, jobject thiz)
{
    XPulseEffect *xPulseEffect = GetHandle<XPulseEffect*>(thiz);
    if (env->ExceptionCheck() || !xPulseEffect) {
        QCC_LogError(ER_FAIL, ("GetHandle() failed"));
        return NULL;
    }

    jstring jPresetID = env->NewStringUTF(xPulseEffect->fromPreset.c_str());
    if (env->ExceptionCheck() || !jPresetID) {
        QCC_LogError(ER_FAIL, ("NewStringUTF() failed"));
        return NULL;
    }

    return jPresetID;
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_PulseEffect_setPulsePeriod(JNIEnv *env, jobject thiz, jlong jPulsePeriod)
{
    XPulseEffectV10::SetPulsePeriod<XPulseEffect>(env, thiz, jPulsePeriod);
}

JNIEXPORT
jlong JNICALL Java_org_allseen_lsf_PulseEffect_getPulsePeriod(JNIEnv *env, jobject thiz)
{
    return XPulseEffectV10::GetPulsePeriod<XPulseEffect>(env, thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_PulseEffect_setPulseDuration(JNIEnv *env, jobject thiz, jlong jPulseDuration)
{
    XPulseEffectV10::SetPulseDuration<XPulseEffect>(env, thiz, jPulseDuration);
}

JNIEXPORT
jlong JNICALL Java_org_allseen_lsf_PulseEffect_getPulseDuration(JNIEnv *env, jobject thiz)
{
    return XPulseEffectV10::GetPulseDuration<XPulseEffect>(env, thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_PulseEffect_setNumPulses(JNIEnv *env, jobject thiz, jlong jPulseCount)
{
    XPulseEffectV10::SetPulseCount<XPulseEffect>(env, thiz, jPulseCount);
}

JNIEXPORT
jlong JNICALL Java_org_allseen_lsf_PulseEffect_getNumPulses(JNIEnv *env, jobject thiz)
{
    return XPulseEffectV10::GetPulseCount<XPulseEffect>(env, thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_PulseEffect_createNativeObject(JNIEnv *env, jobject thiz)
{
    CreateHandle<XPulseEffect>(thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_PulseEffect_destroyNativeObject(JNIEnv *env, jobject thiz)
{
    DestroyHandle<XPulseEffect>(thiz);
}

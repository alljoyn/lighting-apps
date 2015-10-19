/******************************************************************************
 *  *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 *
 ******************************************************************************/
/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class org_allseen_lsf_PresetPulseEffect */

#ifndef _Included_org_allseen_lsf_PresetPulseEffect
#define _Included_org_allseen_lsf_PresetPulseEffect
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    setLamps
 * Signature: ([Ljava/lang/String;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetPulseEffect_setLamps
  (JNIEnv *, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    getLamps
 * Signature: ()[Ljava/lang/String;
 */
JNIEXPORT jobjectArray JNICALL Java_org_allseen_lsf_PresetPulseEffect_getLamps
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    setLampGroups
 * Signature: ([Ljava/lang/String;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetPulseEffect_setLampGroups
  (JNIEnv *, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    getLampGroups
 * Signature: ()[Ljava/lang/String;
 */
JNIEXPORT jobjectArray JNICALL Java_org_allseen_lsf_PresetPulseEffect_getLampGroups
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    setPulsePeriod
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetPulseEffect_setPulsePeriod
  (JNIEnv *, jobject, jlong);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    getPulsePeriod
 * Signature: ()J
 */
JNIEXPORT jlong JNICALL Java_org_allseen_lsf_PresetPulseEffect_getPulsePeriod
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    setPulseDuration
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetPulseEffect_setPulseDuration
  (JNIEnv *, jobject, jlong);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    getPulseDuration
 * Signature: ()J
 */
JNIEXPORT jlong JNICALL Java_org_allseen_lsf_PresetPulseEffect_getPulseDuration
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    setPulseCount
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetPulseEffect_setPulseCount
  (JNIEnv *, jobject, jlong);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    getPulseCount
 * Signature: ()J
 */
JNIEXPORT jlong JNICALL Java_org_allseen_lsf_PresetPulseEffect_getPulseCount
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    setFromPreset
 * Signature: (Ljava/lang/String;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetPulseEffect_setFromPreset
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    getFromPreset
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_PresetPulseEffect_getFromPreset
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    setToPreset
 * Signature: (Ljava/lang/String;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetPulseEffect_setToPreset
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    getToPreset
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_PresetPulseEffect_getToPreset
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    toString
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_PresetPulseEffect_toString
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    createNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetPulseEffect_createNativeObject
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetPulseEffect
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetPulseEffect_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
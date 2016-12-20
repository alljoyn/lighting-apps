/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
 *
 ******************************************************************************/
/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class org_allseen_lsf_PulseEffectManager */

#ifndef _Included_org_allseen_lsf_PulseEffectManager
#define _Included_org_allseen_lsf_PulseEffectManager
#ifdef __cplusplus
extern "C" {
#endif
#undef org_allseen_lsf_PulseEffectManager_MAX_PULSE_EFFECTS
#define org_allseen_lsf_PulseEffectManager_MAX_PULSE_EFFECTS 100L
/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    getAllPulseEffectIDs
 * Signature: ()Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_getAllPulseEffectIDs
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    getPulseEffect
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_getPulseEffect
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    applyPulseEffectOnLamps
 * Signature: (Ljava/lang/String;[Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_applyPulseEffectOnLamps
  (JNIEnv *, jobject, jstring, jobjectArray);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    applyPulseEffectOnLampGroups
 * Signature: (Ljava/lang/String;[Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_applyPulseEffectOnLampGroups
  (JNIEnv *, jobject, jstring, jobjectArray);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    getPulseEffectName
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_getPulseEffectName
  (JNIEnv *, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    setPulseEffectName
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_setPulseEffectName
  (JNIEnv *, jobject, jstring, jstring, jstring);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    createPulseEffect
 * Signature: (Lorg/allseen/lsf/sdk/TrackingID;Lorg/allseen/lsf/PulseEffect;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_createPulseEffect
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    updatePulseEffect
 * Signature: (Ljava/lang/String;Lorg/allseen/lsf/PulseEffect;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_updatePulseEffect
  (JNIEnv *, jobject, jstring, jobject);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    deletePulseEffect
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_deletePulseEffect
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    getPulseEffectDataSet
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PulseEffectManager_getPulseEffectDataSet
  (JNIEnv *, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    createNativeObject
 * Signature: (Lorg/allseen/lsf/ControllerClient;Lorg/allseen/lsf/PulseEffectManagerCallback;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PulseEffectManager_createNativeObject
  (JNIEnv *, jobject, jobject, jobject);

/*
 * Class:     org_allseen_lsf_PulseEffectManager
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PulseEffectManager_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
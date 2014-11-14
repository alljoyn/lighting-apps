/*
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
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */
/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class org_allseen_lsf_LampState */

#ifndef _Included_org_allseen_lsf_LampState
#define _Included_org_allseen_lsf_LampState
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_LampState
 * Method:    setOnOff
 * Signature: (Z)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampState_setOnOff
  (JNIEnv *, jobject, jboolean);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    getOnOff
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_LampState_getOnOff
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    setHue
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampState_setHue
  (JNIEnv *, jobject, jlong);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    getHue
 * Signature: ()J
 */
JNIEXPORT jlong JNICALL Java_org_allseen_lsf_LampState_getHue
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    setSaturation
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampState_setSaturation
  (JNIEnv *, jobject, jlong);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    getSaturation
 * Signature: ()J
 */
JNIEXPORT jlong JNICALL Java_org_allseen_lsf_LampState_getSaturation
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    setColorTemp
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampState_setColorTemp
  (JNIEnv *, jobject, jlong);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    getColorTemp
 * Signature: ()J
 */
JNIEXPORT jlong JNICALL Java_org_allseen_lsf_LampState_getColorTemp
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    setBrightness
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampState_setBrightness
  (JNIEnv *, jobject, jlong);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    getBrightness
 * Signature: ()J
 */
JNIEXPORT jlong JNICALL Java_org_allseen_lsf_LampState_getBrightness
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    setNull
 * Signature: (Z)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampState_setNull
  (JNIEnv *, jobject, jboolean);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    isNull
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_LampState_isNull
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    createNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampState_createNativeObject
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampState
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampState_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
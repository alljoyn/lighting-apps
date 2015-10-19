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
/* Header for class org_allseen_lsf_test_PresetManagerCallbackTest */

#ifndef _Included_org_allseen_lsf_test_PresetManagerCallbackTest
#define _Included_org_allseen_lsf_test_PresetManagerCallbackTest
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    getAllPresetIDsReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_getAllPresetIDsReplyCB
  (JNIEnv *, jobject, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    getPresetReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Lorg/allseen/lsf/LampState;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_getPresetReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jobject);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    getPresetNameReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_getPresetNameReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    setPresetNameReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_setPresetNameReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    presetsNameChangedCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_presetsNameChangedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    createPresetReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_createPresetReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    presetsCreatedCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_presetsCreatedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    updatePresetReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_updatePresetReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    presetsUpdatedCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_presetsUpdatedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    deletePresetReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_deletePresetReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    presetsDeletedCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_presetsDeletedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    getDefaultLampStateReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;Lorg/allseen/lsf/LampState;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_getDefaultLampStateReplyCB
  (JNIEnv *, jobject, jobject, jobject, jobject);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    setDefaultLampStateReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_setDefaultLampStateReplyCB
  (JNIEnv *, jobject, jobject, jobject);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    defaultLampStateChangedCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_defaultLampStateChangedCB
  (JNIEnv *, jobject, jobject);

/*
 * Class:     org_allseen_lsf_test_PresetManagerCallbackTest
 * Method:    createPresetWithTrackingReplyCB
 * Signature: (Lorg/allseen/lsf/PresetManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;J)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PresetManagerCallbackTest_createPresetWithTrackingReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jlong);

#ifdef __cplusplus
}
#endif
#endif
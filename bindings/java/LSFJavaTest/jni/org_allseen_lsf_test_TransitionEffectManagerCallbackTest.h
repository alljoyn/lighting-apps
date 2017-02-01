/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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
/* Header for class org_allseen_lsf_test_TransitionEffectManagerCallbackTest */

#ifndef _Included_org_allseen_lsf_test_TransitionEffectManagerCallbackTest
#define _Included_org_allseen_lsf_test_TransitionEffectManagerCallbackTest
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    getTransitionEffectReplyCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Lorg/allseen/lsf/TransitionEffect;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_getTransitionEffectReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jobject);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    applyTransitionEffectOnLampsReplyCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_applyTransitionEffectOnLampsReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    applyTransitionEffectOnLampGroupsReplyCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_applyTransitionEffectOnLampGroupsReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    getAllTransitionEffectIDsReplyCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_getAllTransitionEffectIDsReplyCB
  (JNIEnv *, jobject, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    getTransitionEffectNameReplyCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_getTransitionEffectNameReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    setTransitionEffectNameReplyCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_setTransitionEffectNameReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    transitionEffectsNameChangedCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_transitionEffectsNameChangedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    createTransitionEffectReplyCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;J)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_createTransitionEffectReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jlong);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    transitionEffectsCreatedCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_transitionEffectsCreatedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    updateTransitionEffectReplyCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_updateTransitionEffectReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    transitionEffectsUpdatedCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_transitionEffectsUpdatedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    deleteTransitionEffectReplyCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_deleteTransitionEffectReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

/*
 * Class:     org_allseen_lsf_test_TransitionEffectManagerCallbackTest
 * Method:    transitionEffectsDeletedCB
 * Signature: (Lorg/allseen/lsf/TransitionEffectManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_TransitionEffectManagerCallbackTest_transitionEffectsDeletedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

#ifdef __cplusplus
}
#endif
#endif
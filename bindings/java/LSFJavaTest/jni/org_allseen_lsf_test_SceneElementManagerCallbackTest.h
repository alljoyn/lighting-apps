/******************************************************************************
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
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
/* Header for class org_allseen_lsf_test_SceneElementManagerCallbackTest */

#ifndef _Included_org_allseen_lsf_test_SceneElementManagerCallbackTest
#define _Included_org_allseen_lsf_test_SceneElementManagerCallbackTest
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    getAllSceneElementIDsReplyCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;Lorg/allseen/lsf/ResponseCode;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_getAllSceneElementIDsReplyCB
  (JNIEnv *, jobject, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    getSceneElementNameReplyCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_getSceneElementNameReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    setSceneElementNameReplyCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_setSceneElementNameReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    getSceneElementReplyCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Lorg/allseen/lsf/SceneElement;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_getSceneElementReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jobject);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    updateSceneElementReplyCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_updateSceneElementReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    deleteSceneElementReplyCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_deleteSceneElementReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    applySceneElementReplyCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_applySceneElementReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    sceneElementsNameChangedCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_sceneElementsNameChangedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    sceneElementsCreatedCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_sceneElementsCreatedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    sceneElementsUpdatedCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_sceneElementsUpdatedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    sceneElementsDeletedCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_sceneElementsDeletedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    sceneElementsAppliedCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_sceneElementsAppliedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_SceneElementManagerCallbackTest
 * Method:    createSceneElementReplyCB
 * Signature: (Lorg/allseen/lsf/SceneElementManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;J)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_SceneElementManagerCallbackTest_createSceneElementReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jlong);

#ifdef __cplusplus
}
#endif
#endif
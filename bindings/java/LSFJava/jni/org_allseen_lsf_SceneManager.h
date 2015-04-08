/*
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
 */
/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class org_allseen_lsf_SceneManager */

#ifndef _Included_org_allseen_lsf_SceneManager
#define _Included_org_allseen_lsf_SceneManager
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    getAllSceneIds
 * Signature: ()Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_SceneManager_getAllSceneIDs
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    getSceneName
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_SceneManager_getSceneName
  (JNIEnv *, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    setSceneName
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_SceneManager_setSceneName
  (JNIEnv *, jobject, jstring, jstring, jstring);

/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    createScene
 * Signature: (Lorg/allseen/lsf/Scene;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_SceneManager_createScene
  (JNIEnv *, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    updateScene
 * Signature: (Ljava/lang/String;Lorg/allseen/lsf/Scene;)Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_SceneManager_updateScene
  (JNIEnv *, jobject, jstring, jobject);

/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    deleteScene
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_SceneManager_deleteScene
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    getScene
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_SceneManager_getScene
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    applyScene
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_SceneManager_applyScene
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    createNativeObject
 * Signature: (Lorg/allseen/lsf/ControllerClient;Lorg/allseen/lsf/SceneManagerCallback;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_SceneManager_createNativeObject
  (JNIEnv *, jobject, jobject, jobject);

/*
 * Class:     org_allseen_lsf_SceneManager
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_SceneManager_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
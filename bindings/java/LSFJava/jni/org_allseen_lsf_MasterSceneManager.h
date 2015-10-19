/******************************************************************************
 *  * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
/* Header for class org_allseen_lsf_MasterSceneManager */

#ifndef _Included_org_allseen_lsf_MasterSceneManager
#define _Included_org_allseen_lsf_MasterSceneManager
#ifdef __cplusplus
extern "C" {
#endif
#undef org_allseen_lsf_MasterSceneManager_MAX_MASTER_SCENES
#define org_allseen_lsf_MasterSceneManager_MAX_MASTER_SCENES 100L
/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    getAllMasterSceneIDs
 * Signature: ()Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_getAllMasterSceneIDs
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    getMasterSceneName
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_getMasterSceneName
  (JNIEnv *, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    setMasterSceneName
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_setMasterSceneName
  (JNIEnv *, jobject, jstring, jstring, jstring);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    createMasterScene
 * Signature: (Lorg/allseen/lsf/MasterScene;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_createMasterScene
  (JNIEnv *, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    updateMasterScene
 * Signature: (Ljava/lang/String;Lorg/allseen/lsf/MasterScene;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_updateMasterScene
  (JNIEnv *, jobject, jstring, jobject);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    getMasterScene
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_getMasterScene
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    deleteMasterScene
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_deleteMasterScene
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    applyMasterScene
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_applyMasterScene
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    createMasterSceneWithTracking
 * Signature: (Lorg/allseen/lsf/sdk/TrackingID;Lorg/allseen/lsf/MasterScene;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_createMasterSceneWithTracking
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    getMasterSceneDataSet
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterSceneManager_getMasterSceneDataSet
  (JNIEnv *, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    createNativeObject
 * Signature: (Lorg/allseen/lsf/ControllerClient;Lorg/allseen/lsf/MasterSceneManagerCallback;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_MasterSceneManager_createNativeObject
  (JNIEnv *, jobject, jobject, jobject);

/*
 * Class:     org_allseen_lsf_MasterSceneManager
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_MasterSceneManager_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
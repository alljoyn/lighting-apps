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
/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class org_allseen_lsf_PresetManager */

#ifndef _Included_org_allseen_lsf_PresetManager
#define _Included_org_allseen_lsf_PresetManager
#ifdef __cplusplus
extern "C" {
#endif
#undef org_allseen_lsf_PresetManager_MAX_PRESETS
#define org_allseen_lsf_PresetManager_MAX_PRESETS 100L
/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    getAllPresetIDs
 * Signature: ()Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_getAllPresetIDs
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    getPreset
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_getPreset
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    getPresetName
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_getPresetName
  (JNIEnv *, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    setPresetName
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_setPresetName
  (JNIEnv *, jobject, jstring, jstring, jstring);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    createPreset
 * Signature: (Lorg/allseen/lsf/LampState;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_createPreset
  (JNIEnv *, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    updatePreset
 * Signature: (Ljava/lang/String;Lorg/allseen/lsf/LampState;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_updatePreset
  (JNIEnv *, jobject, jstring, jobject);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    deletePreset
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_deletePreset
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    getDefaultLampState
 * Signature: ()Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_getDefaultLampState
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    setDefaultLampState
 * Signature: (Lorg/allseen/lsf/LampState;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_setDefaultLampState
  (JNIEnv *, jobject, jobject);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    getPresetVersion
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_getPresetVersion
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    createPresetWithTracking
 * Signature: (Lorg/allseen/lsf/sdk/TrackingID;Lorg/allseen/lsf/LampState;Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_createPresetWithTracking
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    getPresetDataSet
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Lorg/allseen/lsf/sdk/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_PresetManager_getPresetDataSet
  (JNIEnv *, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    createNativeObject
 * Signature: (Lorg/allseen/lsf/ControllerClient;Lorg/allseen/lsf/PresetManagerCallback;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetManager_createNativeObject
  (JNIEnv *, jobject, jobject, jobject);

/*
 * Class:     org_allseen_lsf_PresetManager
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_PresetManager_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif

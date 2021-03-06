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
/* Header for class org_allseen_lsf_sdk_LampDetails */

#ifndef _Included_org_allseen_lsf_sdk_LampDetails
#define _Included_org_allseen_lsf_sdk_LampDetails
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getMake
 * Signature: ()Lorg/allseen/lsf/sdk/LampMake;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_sdk_LampDetails_getMake
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getModel
 * Signature: ()Lorg/allseen/lsf/sdk/LampModel;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_sdk_LampDetails_getModel
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getType
 * Signature: ()Lorg/allseen/lsf/sdk/DeviceType;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_sdk_LampDetails_getType
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getLampType
 * Signature: ()Lorg/allseen/lsf/sdk/LampType;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_sdk_LampDetails_getLampType
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getLampBaseType
 * Signature: ()Lorg/allseen/lsf/sdk/BaseType;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_sdk_LampDetails_getLampBaseType
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getLampBeamAngle
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_sdk_LampDetails_getLampBeamAngle
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    isDimmable
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_sdk_LampDetails_isDimmable
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    hasColor
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_sdk_LampDetails_hasColor
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    hasVariableColorTemp
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_sdk_LampDetails_hasVariableColorTemp
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    hasEffects
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_sdk_LampDetails_hasEffects
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getMinVoltage
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_sdk_LampDetails_getMinVoltage
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getMaxVoltage
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_sdk_LampDetails_getMaxVoltage
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getWattage
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_sdk_LampDetails_getWattage
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getWattageEquivalent
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_sdk_LampDetails_getIncandescentEquivalent
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getMaxOutput
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_sdk_LampDetails_getMaxLumens
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getMinTemperature
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_sdk_LampDetails_getMinTemperature
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getMaxTemperature
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_sdk_LampDetails_getMaxTemperature
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getColorRenderingIndex
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_sdk_LampDetails_getColorRenderingIndex
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    getLampID
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_sdk_LampDetails_getLampID
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    createNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_sdk_LampDetails_createNativeObject
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_sdk_LampDetails
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_sdk_LampDetails_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
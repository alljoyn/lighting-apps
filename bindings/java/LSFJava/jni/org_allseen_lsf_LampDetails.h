/******************************************************************************
 * Copyright (c) 2014, AllSeen Alliance. All rights reserved.
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
/* Header for class org_allseen_lsf_LampDetails */

#ifndef _Included_org_allseen_lsf_LampDetails
#define _Included_org_allseen_lsf_LampDetails
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getMake
 * Signature: ()Lorg/allseen/lsf/LampMake;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_LampDetails_getMake
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getModel
 * Signature: ()Lorg/allseen/lsf/LampModel;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_LampDetails_getModel
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getType
 * Signature: ()Lorg/allseen/lsf/DeviceType;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_LampDetails_getType
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getLampType
 * Signature: ()Lorg/allseen/lsf/LampType;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_LampDetails_getLampType
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getLampBaseType
 * Signature: ()Lorg/allseen/lsf/BaseType;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_LampDetails_getLampBaseType
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getLampBeamAngle
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_LampDetails_getLampBeamAngle
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    isDimmable
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_LampDetails_isDimmable
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    hasColor
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_LampDetails_hasColor
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    hasVariableColorTemp
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_LampDetails_hasVariableColorTemp
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    hasEffects
 * Signature: ()Z
 */
JNIEXPORT jboolean JNICALL Java_org_allseen_lsf_LampDetails_hasEffects
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getMinVoltage
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_LampDetails_getMinVoltage
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getMaxVoltage
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_LampDetails_getMaxVoltage
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getWattage
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_LampDetails_getWattage
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getWattageEquivalent
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_LampDetails_getIncandescentEquivalent
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getMaxOutput
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_LampDetails_getMaxLumens
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getMinTemperature
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_LampDetails_getMinTemperature
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getMaxTemperature
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_LampDetails_getMaxTemperature
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getColorRenderingIndex
 * Signature: ()I
 */
JNIEXPORT jint JNICALL Java_org_allseen_lsf_LampDetails_getColorRenderingIndex
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    getLampID
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_LampDetails_getLampID
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    createNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampDetails_createNativeObject
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_LampDetails
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_LampDetails_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
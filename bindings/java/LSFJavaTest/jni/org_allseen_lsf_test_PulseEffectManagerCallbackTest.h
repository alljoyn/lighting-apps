/******************************************************************************
 * Copyright (c), AllSeen Alliance. All rights reserved.
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
/* Header for class org_allseen_lsf_test_PulseEffectManagerCallbackTest */

#ifndef _Included_org_allseen_lsf_test_PulseEffectManagerCallbackTest
#define _Included_org_allseen_lsf_test_PulseEffectManagerCallbackTest
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    getPulseEffectReplyCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Lorg/allseen/lsf/PulseEffect;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_getPulseEffectReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jobject);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    applyPulseEffectOnLampsReplyCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_applyPulseEffectOnLampsReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    applyPulseEffectOnLampGroupsReplyCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_applyPulseEffectOnLampGroupsReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    getAllPulseEffectIDsReplyCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_getAllPulseEffectIDsReplyCB
  (JNIEnv *, jobject, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    getPulseEffectNameReplyCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_getPulseEffectNameReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    setPulseEffectNameReplyCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_setPulseEffectNameReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    createPulseEffectReplyCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;J)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_createPulseEffectReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring, jlong);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    pulseEffectsNameChangedCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_pulseEffectsNameChangedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    pulseEffectsCreatedCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_pulseEffectsCreatedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    pulseEffectsUpdatedCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_pulseEffectsUpdatedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    pulseEffectsDeletedCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;[Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_pulseEffectsDeletedCB
  (JNIEnv *, jobject, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    updatePulseEffectReplyCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_updatePulseEffectReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

/*
 * Class:     org_allseen_lsf_test_PulseEffectManagerCallbackTest
 * Method:    deletePulseEffectReplyCB
 * Signature: (Lorg/allseen/lsf/PulseEffectManagerCallback;Lorg/allseen/lsf/ResponseCode;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_PulseEffectManagerCallbackTest_deletePulseEffectReplyCB
  (JNIEnv *, jobject, jobject, jobject, jstring);

#ifdef __cplusplus
}
#endif
#endif

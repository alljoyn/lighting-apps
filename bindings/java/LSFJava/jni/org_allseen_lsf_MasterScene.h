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
/* Header for class org_allseen_lsf_MasterScene */

#ifndef _Included_org_allseen_lsf_MasterScene
#define _Included_org_allseen_lsf_MasterScene
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_MasterScene
 * Method:    setScenes
 * Signature: ([Ljava/lang/String;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_MasterScene_setScenes
  (JNIEnv *, jobject, jobjectArray);

/*
 * Class:     org_allseen_lsf_MasterScene
 * Method:    getScenes
 * Signature: ()[Ljava/lang/String;
 */
JNIEXPORT jobjectArray JNICALL Java_org_allseen_lsf_MasterScene_getScenes
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_MasterScene
 * Method:    isDependentOnScene
 * Signature: (Ljava/lang/String;)Lorg/allseen/lsf/sdk/ResponseCode;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_MasterScene_isDependentOnScene
  (JNIEnv *, jobject, jstring);

/*
 * Class:     org_allseen_lsf_MasterScene
 * Method:    toString
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_MasterScene_toString
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_MasterScene
 * Method:    createNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_MasterScene_createNativeObject
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_MasterScene
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_MasterScene_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif

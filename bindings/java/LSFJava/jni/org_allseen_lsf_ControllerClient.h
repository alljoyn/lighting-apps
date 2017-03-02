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
/* Header for class org_allseen_lsf_ControllerClient */

#ifndef _Included_org_allseen_lsf_ControllerClient
#define _Included_org_allseen_lsf_ControllerClient
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_ControllerClient
 * Method:    stringFromJNI
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_ControllerClient_stringFromJNI
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_ControllerClient
 * Method:    start
 * Signature: ()Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_ControllerClient_start
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_ControllerClient
 * Method:    stop
 * Signature: ()Lorg/allseen/lsf/ControllerClientStatus;
 */
JNIEXPORT jobject JNICALL Java_org_allseen_lsf_ControllerClient_stop
  (JNIEnv *, jobject);

/*
 * Class:     org_allseen_lsf_ControllerClient
 * Method:    createNativeObject
 * Signature: (Lorg/alljoyn/bus/BusAttachment;Lorg/allseen/lsf/ControllerClientCallback;)V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_ControllerClient_createNativeObject
  (JNIEnv *, jobject, jobject, jobject);

/*
 * Class:     org_allseen_lsf_ControllerClient
 * Method:    destroyNativeObject
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_allseen_lsf_ControllerClient_destroyNativeObject
  (JNIEnv *, jobject);

#ifdef __cplusplus
}
#endif
#endif
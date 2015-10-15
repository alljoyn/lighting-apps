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
/* Header for class org_allseen_lsf_test_ControllerClientCallbackTest */

#ifndef _Included_org_allseen_lsf_test_ControllerClientCallbackTest
#define _Included_org_allseen_lsf_test_ControllerClientCallbackTest
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     org_allseen_lsf_test_ControllerClientCallbackTest
 * Method:    connectedToControllerServiceCB
 * Signature: (Lorg/allseen/lsf/ControllerClientCallback;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_ControllerClientCallbackTest_connectedToControllerServiceCB
  (JNIEnv *, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_ControllerClientCallbackTest
 * Method:    connectToControllerServiceFailedCB
 * Signature: (Lorg/allseen/lsf/ControllerClientCallback;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_ControllerClientCallbackTest_connectToControllerServiceFailedCB
  (JNIEnv *, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_ControllerClientCallbackTest
 * Method:    disconnectedFromControllerServiceCB
 * Signature: (Lorg/allseen/lsf/ControllerClientCallback;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_ControllerClientCallbackTest_disconnectedFromControllerServiceCB
  (JNIEnv *, jobject, jobject, jstring, jstring);

/*
 * Class:     org_allseen_lsf_test_ControllerClientCallbackTest
 * Method:    controllerClientErrorCB
 * Signature: (Lorg/allseen/lsf/ControllerClientCallback;[Lorg/allseen/lsf/ErrorCode;)Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_org_allseen_lsf_test_ControllerClientCallbackTest_controllerClientErrorCB
  (JNIEnv *, jobject, jobject, jobjectArray);

#ifdef __cplusplus
}
#endif
#endif
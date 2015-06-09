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

#include <jni.h>

#include "NUtil.h"
#include "JControllerClientCallback.h"

#include "org_allseen_lsf_ControllerClientCallback.h"

using namespace lsf;

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT
void JNICALL Java_org_allseen_lsf_ControllerClientCallback_createNativeObject(JNIEnv *env, jobject thiz)
{
    CreateHandle<JControllerClientCallback>(thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_ControllerClientCallback_destroyNativeObject(JNIEnv *env, jobject thiz)
{
    DestroyHandle<JControllerClientCallback>(thiz);
}

#ifdef __cplusplus
}
#endif





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

#include <jni.h>

#include "NUtil.h"
#include "JLampGroupManagerCallback.h"

using namespace lsf;

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT
void JNICALL Java_org_allseen_lsf_LampGroupManagerCallback_createNativeObject(JNIEnv*env, jobject thiz)
{
    CreateHandle<JLampGroupManagerCallback>(thiz);
}

JNIEXPORT
void JNICALL Java_org_allseen_lsf_LampGroupManagerCallback_destroyNativeObject(JNIEnv*env, jobject thiz)
{
    DestroyHandle<JLampGroupManagerCallback>(thiz);
}

#ifdef __cplusplus
}
#endif




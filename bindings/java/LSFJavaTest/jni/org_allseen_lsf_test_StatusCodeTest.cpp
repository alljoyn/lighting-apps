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

#include "JEnum.h"

#include "org_allseen_lsf_test_StatusCodeTest.h"

using namespace lsf;

JNIEXPORT
jobject JNICALL Java_org_allseen_lsf_test_StatusCodeTest_convertIntToObj(JNIEnv *env, jobject thiz, jint sc)
{
    return JEnum::jStatusCodeEnum->getObject((int)sc);
}

JNIEXPORT
jint JNICALL Java_org_allseen_lsf_test_StatusCodeTest_convertObjToInt(JNIEnv *env, jobject thiz, jobject sc)
{
    return JEnum::jStatusCodeEnum->getValue(sc);
}
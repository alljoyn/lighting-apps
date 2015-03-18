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

#ifndef LSF_JNI_XPULSEEFFECT_H_
#define LSF_JNI_XPULSEEFFECT_H_

#include <jni.h>

namespace lsf {

class XPulseEffect {
private:
    XPulseEffect();

public:
    template <typename T> static void SetPulsePeriod(JNIEnv *env, jobject thiz, jlong jPulsePeriod);
    template <typename T> static jlong GetPulsePeriod(JNIEnv *env, jobject thiz);

    template <typename T> static void SetPulseDuration(JNIEnv *env, jobject thiz, jlong jPulseDuration);
    template <typename T> static jlong GetPulseDuration(JNIEnv *env, jobject thiz);

    template <typename T> static void SetPulseCount(JNIEnv *env, jobject thiz, jlong jPulseCount);
    template <typename T> static jlong GetPulseCount(JNIEnv *env, jobject thiz);
};

} /* namespace lsf */

// The .cpp file is #include'd in this .h file because some templated
// methods must be defined here. The following #define prevents the
// non-templated code from being visible here.
#define LSF_JNI_XPULSEEFFECT_H_INCLUDE_TEMPLATE_METHODS
#include "XPulseEffect.cpp"
#undef LSF_JNI_XPULSEEFFECT_H_INCLUDE_TEMPLATE_METHODS
#endif /* LSF_JNI_XPULSEEFFECT_H_ */
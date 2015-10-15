/******************************************************************************
 *  *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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

// The template definitions below are intended to be #include'd from
// the corresponding .h file, hence the #ifdef guard
#ifdef LSF_JNI_JENUMARRAY_H_

#define QCC_MODULE LSF_QCC_MODULE

namespace lsf {

template <typename T> jobjectArray JEnumArray::NewEnumArray(JEnum &jenum, const std::list<T> &cEnums)
{
    JScopedEnv env;

    typename std::list<T>::size_type count = cEnums.size();
    if (!count) {
        QCC_LogError(ER_FAIL, ("Empty list"));
        return NULL;
    }

    jobjectArray jarr = env->NewObjectArray(count, jenum.getClass(), NULL);
    if (env->ExceptionCheck() || !jarr) {
        QCC_LogError(ER_FAIL, ("NewObjectArray() failed"));
        return NULL;
    }

    typename std::list<T>::const_iterator it = cEnums.begin();
    for (int i = 0; i < count; i++, it++) {
        jobject jobj = jenum.getObject((int)*it);
        if (env->ExceptionCheck() || !jobj) {
            QCC_LogError(ER_FAIL, ("getObject() failed"));
            return NULL;
        }

        env->SetObjectArrayElement(jarr, i, jobj);
        if (env->ExceptionCheck()) {
            QCC_LogError(ER_FAIL, ("SetObjectArrayElement() failed"));
            return NULL;
        }

        env->DeleteLocalRef(jobj);
    }

    return jarr;
}

template <typename T> void JEnumArray::CopyEnumArray(jobjectArray jarr, JEnum &jenum, std::list<T> &cenums)
{
    JScopedEnv env;

    jsize count = env->GetArrayLength(jarr);
    if (env->ExceptionCheck() || !count) {
        QCC_LogError(ER_FAIL, ("GetArrayLength() invalid"));
        return;
    }

    cenums.empty();

    for (jsize i = 0; i < count; i++) {
        jobject jobj = env->GetObjectArrayElement(jarr, i);
        if (env->ExceptionCheck() || !jobj) {
            QCC_LogError(ER_FAIL, ("GetObjectArrayElement() failed"));
            return;
        }

        cenums.push_back((T)jenum.getValue(jobj));

        env->DeleteLocalRef(jobj);
    }
}

} /* namespace lsf */

#undef QCC_MODULE

#endif /* LSF_JNI_JENUMARRAY_H_ */
/******************************************************************************
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 *
 ******************************************************************************/

#ifndef LSF_JNI_XTRANSITIONEFFECT_H_
#define LSF_JNI_XTRANSITIONEFFECT_H_

#include <jni.h>

namespace lsf {

class XTransitionEffect {
private:
    XTransitionEffect();

public:
    template <typename T> static void SetTransitionPeriod(JNIEnv *env, jobject thiz, jlong jTransitionPeriod);
    template <typename T> static jlong GetTransitionPeriod(JNIEnv *env, jobject thiz);
};

} /* namespace lsf */

// The .cpp file is #include'd in this .h file because some templated
// methods must be defined here. The following #define prevents the
// non-templated code from being visible here.
#define LSF_JNI_XTRANSITIONEFFECT_H_INCLUDE_TEMPLATE_METHODS
#include "XTransitionEffect.cpp"
#undef LSF_JNI_XTRANSITIONEFFECT_H_INCLUDE_TEMPLATE_METHODS
#endif /* LSF_JNI_XTRANSITIONEFFECT_H_ */

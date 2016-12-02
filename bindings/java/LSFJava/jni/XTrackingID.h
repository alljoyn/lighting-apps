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

#ifndef LSF_JNI_XTRACKINGID_H_
#define LSF_JNI_XTRACKINGID_H_

#include <jni.h>

namespace lsf {

class XTrackingID {
  public:
    static jobject NewTrackingID();
    static jobject SetTrackingID(jobject jTrackingID, const uint32_t& cTrackingID);
};

} /* namespace lsf */
#endif /* LSF_JNI_XTRACKINGID_H_ */
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

#ifndef LSF_JNI_XCONTROLLERSERVICE_H_
#define LSF_JNI_XCONTROLLERSERVICE_H_

#include <jni.h>

#include "lsf/controllerservice/OEM_CS_Config.h"

using namespace lsf::controllerservice;

namespace lsf {

class XControllerService {
public:
    static XControllerService* getActive() { return cActive; }

    XControllerService(jobject jobj);
    virtual ~XControllerService();

    // Methods called from Java
    void Start(const LSFString &keyStorePath);
    void Stop();
    void LightingReset();
    void FactoryReset();

    void SendNetworkConnected();
    void SendNetworkDisconnected();
    jstring GetName();
    jboolean IsLeader();

    // Methods calling into Java
    void PopulateDefaultProperties(const AboutData *aboutData);
    LSFString GetMacAddress(const LSFString &defaultMacAddress);
    bool IsNetworkConnected(const bool &defaultIsNetworkConnected);
    OEM_CS_RankParam_Power GetRankPower(const OEM_CS_RankParam_Power &defaultRankPower);
    OEM_CS_RankParam_Mobility GetRankMobility(const OEM_CS_RankParam_Mobility &defaultRankMobility);
    OEM_CS_RankParam_Availability GetRankAvailability(const OEM_CS_RankParam_Availability &defaultRankAvailability);
    OEM_CS_RankParam_NodeType GetRankNodeType(const OEM_CS_RankParam_NodeType &defaultRankNodeType);

    OEM_CS_NetworkCallback* cNetworkCallback;
protected:
    static XControllerService* cActive;

    jweak jdelegate;
 };

} /* namespace lsf */
#endif /* LSF_JNI_XCONTROLLERSERVICE_H_ */

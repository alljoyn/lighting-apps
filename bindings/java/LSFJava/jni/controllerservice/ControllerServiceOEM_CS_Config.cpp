/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
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

#include <qcc/Debug.h>
#include <qcc/String.h>
#include <time.h>
#include "ControllerServiceJNI.h"
int64_t timestampOffset = 0;
uint64_t controllerRank = 0;
qcc::String controllerName = "English Name";

namespace lsf {
namespace controllerservice {

#define QCC_MODULE "AJN-LSF-JNI"

// OEMs should modify this default lamp state value as required
static const LampState OEM_CS_DefaultLampState = LampState(true, 0, 0, 0, 0);

uint64_t OEM_MacAddr = 0;

void OEM_CS_GetFactorySetDefaultLampState(LampState& defaultState)
{
    QCC_DbgPrintf(("%s", __func__));
    defaultState = OEM_CS_DefaultLampState;
}

void OEM_CS_GetSyncTimeStamp(uint64_t& timeStamp)
{
    // This is just a sample implementation and so it passes back a
    // random value. OEMs are supposed to integrate this
    // with their Time Sync module to return a valid time stamp
	QCC_DbgPrintf(("%s", __FUNCTION__));
	//timeStamp = 0x0000000000000000;
    // get timestamp, add offset
    struct timespec res;
    clock_gettime(CLOCK_REALTIME, &res);
    timeStamp = ((uint64_t) 1000 * res.tv_sec) + ((uint64_t) res.tv_nsec / 1e6) + timestampOffset;
	QCC_DbgPrintf(("the timestampOffset: %lld", timestampOffset));
	QCC_DbgPrintf(("the timeStamp: %lld", timeStamp));
}

bool OEM_CS_FirmwareStart(OEM_CS_NetworkCallback& networkCallback)
{
    // OEMs should add code here to initialize and start the firmware and
    // return true/false accordingly. The firmware should also save off the
    // reference to the OEM_CS_NetworkCallback object and invoke the
    // Connected() and Disconnected() functions defined in this callback
    // whenever the device connects to and disconnects from the network
    // accordingly

	//Save the reference in order to make calls to it in controller.cc
	networkCallbackReference = &networkCallback;
	//No initialization is needed when starting the controller, so only return true;
    return true;
}

bool OEM_CS_FirmwareStop(void)
{
    // OEMs should add code here to stop and cleanup the firmware and
    // return true/false accordingly
    return true;
}

uint64_t OEM_CS_GetMACAddress(void)
{
    // This is just a sample implementation and so it passes back a
    // random value. OEMs should add code here to return the MAC address
    // of the device as a 48-bit value
    while (OEM_MacAddr == 0) {
        OEM_MacAddr = getMacAddress();
        QCC_DbgPrintf(("%s: MAC Address = %llu", __func__, OEM_MacAddr));
    }
    QCC_DbgPrintf(("%s: MAC Address = %llu", __func__, OEM_MacAddr));
    return OEM_MacAddr;
}

bool OEM_CS_IsNetworkConnected(void)
{
    // OEMs should add code here to find out if the device is connected to a network and
    // return true/false accordingly
	bool connected = isNetworkConnected();//in controller.cc
    return connected;
}

OEM_CS_RankParam_Power OEM_CS_GetRankParam_Power(void)
{
    // OEMs should add code here to return the appropriate enum value from
    // OEM_CS_RankParam_Power depending on the type of the device on which
    // the Controller Service is being run
    return getRankPower();
}

OEM_CS_RankParam_Mobility OEM_CS_GetRankParam_Mobility(void)
{
    // OEMs should add code here to return the appropriate enum value from
    // OEM_CS_RankParam_Mobility depending on the type of the device on which
    // the Controller Service is being run
    return getRankMobility();
}

OEM_CS_RankParam_Availability OEM_CS_GetRankParam_Availability(void)
{
    // OEMs should add code here to return the appropriate enum value from
    // OEM_CS_RankParam_Availability depending on the type of the device on which
    // the Controller Service is being run
    return getRankAvailability();
}

OEM_CS_RankParam_NodeType OEM_CS_GetRankParam_NodeType(void)
{
    // OEMs should add code here to return the appropriate enum value from
    // OEM_CS_RankParam_NodeType depending on network configuration of the device on which
    // the Controller Service is being run
    return getRankNodeType();
}

// NOTE: this function will only be called if no Factory Configuration ini file is found.
// This file is specified on the command line and defaults to OEMConfig.ini in the current
// working directory.
void OEM_CS_PopulateDefaultProperties(AboutData* aboutData)
{
    QCC_DbgTrace(("%s", __func__));

    aboutData->SetDateOfManufacture("10/1/2199");
    aboutData->SetDefaultLanguage("en");
    aboutData->SetHardwareVersion("355.499. b");
    aboutData->SetModelNumber("100");
    aboutData->SetSoftwareVersion("1");
    aboutData->SetSupportUrl("http://www.company_a.com");
    aboutData->SetSupportedLanguage("en");
    aboutData->SetSupportedLanguage("de-AT");
    aboutData->SetAppName("LightingControllerService", "en");
    aboutData->SetAppName("LightingControllerService", "de-AT");
    aboutData->SetDescription("Controller Service", "en");
    aboutData->SetDescription("Controller Service", "de-AT");
    aboutData->SetDeviceName(controllerName.c_str(), "en");
    aboutData->SetDeviceName(controllerName.c_str(), "de-AT");
    aboutData->SetManufacturer("Company A (EN)", "en");
    aboutData->SetManufacturer("Firma A (DE-AT)", "de-AT");

    //Generate a new app id as hex string
    qcc::String app_id = qcc::RandHexString(16);
    QCC_DbgTrace(("%s random app_id: %s ", __func__, app_id.c_str()));
    //get from Java the persisted app id (if any) or the new app id we just created.
    qcc::String* retAppId = getControllerDefaultAppId(app_id.c_str());

    if (retAppId) {
		QCC_DbgTrace(("%s app_id after returned from java: %s ", __func__, (*retAppId).c_str()));
		aboutData->SetAppId(retAppId->c_str());
    } else {
		QCC_DbgTrace(("%s app_id after returned from java is invalid. Using randomly generated appId: %s", __func__, app_id.c_str()));
		aboutData->SetAppId(app_id.c_str());
    }

    delete retAppId;
}

}
}

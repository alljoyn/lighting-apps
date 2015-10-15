/******************************************************************************
 * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
 ******************************************************************************/

#include <qcc/Debug.h>
#include <qcc/String.h>
#include <sys/time.h>
#include <mach/mach_time.h>
#include <mach/clock.h>
#include <mach/mach.h>
#include <lsf/controllerservice/OEM_CS_Config.h>
#include "Controller.h"

int64_t timestampOffset = 0;
uint64_t controllerRank = 0;
qcc::String controllerName = "iOS Lighting Controller";

#define QCC_MODULE "OEM_CS_CONFIG"

namespace lsf {

    OPTIONAL_NAMESPACE_CONTROLLER_SERVICE

        // OEMs should modify this default lamp state value as required
        static const LampState OEM_CS_DefaultLampState = LampState(true, 0, 0, 0, 0);

        uint64_t OEM_MacAddr = 0;

        void OEM_CS_GetFactorySetDefaultLampState(LampState& defaultState)
        {
            printf("LSFObjCOEM_CS_Config - OEM_CS_GetFactorySetDefaultLampState() executing\n");
            defaultState = OEM_CS_DefaultLampState;
        }

        void OEM_CS_GetSyncTimeStamp(uint64_t& timeStamp)
        {
            printf("LSFObjCOEM_CS_Config - OEM_CS_GetSyncTimeStamp() executing\n");

            // This is just a sample implementation and so it passes back a
            // random value. OEMs are supposed to integrate this
            // with their Time Sync module to return a valid time stamp
            QCC_DbgPrintf(("%s", __FUNCTION__));
            //timeStamp = 0x0000000000000000;
            // get timestamp, add offset
            struct timespec res;
            clock_serv_t cclock;
            mach_timespec_t mts;
            host_get_clock_service(mach_host_self(), CALENDAR_CLOCK, &cclock);
            clock_get_time(cclock, &mts);
            mach_port_deallocate(mach_task_self(), cclock);
            res.tv_sec = 0;//mts.tv_sec;
            res.tv_nsec = 0;//mts.tv_nsec;
            timeStamp = ((uint64_t) 1000 * res.tv_sec) + ((uint64_t) res.tv_nsec / 1e6) + timestampOffset;

            printf("the timestampOffset: %lld\n", timestampOffset);
            printf("the timeStamp: %lld\n", timeStamp);
        }

        bool OEM_CS_FirmwareStart(OEM_CS_NetworkCallback& networkCallback)
        {
            printf("LSFObjCOEM_CS_Config - OEM_CS_FirmwareStart() executing\n");

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
            printf("LSFObjCOEM_CS_Config - OEM_CS_FirmwareStop() executing\n");

            // OEMs should add code here to stop and cleanup the firmware and
            // return true/false accordingly
            return true;
        }

        uint64_t OEM_CS_GetMACAddress(void)
        {
            printf("LSFObjCOEM_CS_Config - OEM_CS_GetMacAddress() executing\n");

            // This is just a sample implementation and so it passes back a
            // random value. OEMs should add code here to return the MAC address
            // of the device as a 48-bit value
            while (OEM_MacAddr == 0) {
                OEM_MacAddr = getMacAddress();
                QCC_DbgPrintf(("%s: MAC Address = %llu\n", __func__, OEM_MacAddr));
            }
            QCC_DbgPrintf(("%s: MAC Address = %llu\n", __func__, OEM_MacAddr));
            return OEM_MacAddr;
        }

        bool OEM_CS_IsNetworkConnected(void)
        {
            printf("LSFObjCOEM_CS_Config - OEM_CS_IsNetworkConnected() executing\n");

            // OEMs should add code here to find out if the device is connected to a network and
            // return true/false accordingly
            bool connected = isNetworkConnected();//in controller.cc
            return connected;
        }

        OEM_CS_RankParam_Power OEM_CS_GetRankParam_Power(void)
        {
            printf("LSFObjCOEM_CS_Config - OEM_CS_GetRankParam_Power() executing\n");

            // OEMs should add code here to return the appropriate enum value from
            // OEM_CS_RankParam_Power depending on the type of the device on which
            // the Controller Service is being run
            return getRankPower();
        }

        OEM_CS_RankParam_Mobility OEM_CS_GetRankParam_Mobility(void)
        {
            printf("LSFObjCOEM_CS_Config - OEM_CS_GetRankParam_Mobility() executing\n");

            // OEMs should add code here to return the appropriate enum value from
            // OEM_CS_RankParam_Mobility depending on the type of the device on which
            // the Controller Service is being run
            return getRankMobility();
        }

        OEM_CS_RankParam_Availability OEM_CS_GetRankParam_Availability(void)
        {
            printf("LSFObjCOEM_CS_Config - OEM_CS_GetRankParam_Availability() executing\n");

            // OEMs should add code here to return the appropriate enum value from
            // OEM_CS_RankParam_Availability depending on the type of the device on which
            // the Controller Service is being run
            return getRankAvailability();
        }

        OEM_CS_RankParam_NodeType OEM_CS_GetRankParam_NodeType(void)
        {
            printf("LSFObjCOEM_CS_Config - OEM_CS_GetRankParam_NodeType() executing\n");

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
            printf("LSFObjCOEM_CS_Config - OEM_CS_PopulateDefaultProperties() executing\n");
            QCC_DbgTrace(("%s", __func__));

            populateDefaultProperties(aboutData);
        }

    OPTIONAL_NAMESPACE_CLOSE
}
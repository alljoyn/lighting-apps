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
 ******************************************************************************/

#include "Controller.h"

using namespace ajn;
using namespace lsf;
using namespace qcc;

#ifdef LSF_BINDINGS
using namespace controllerservice;
#endif

id<LSFControllerServiceDelegate> controllerServiceDelegate = NULL;
OEM_CS_NetworkCallback* networkCallbackReference = NULL;

void LuminaireSleep(uint32_t msec)
{
    usleep(1000 * msec);
}

//For now, not in use
long getNTPOffset()
{
    printf("Controller.cc - getNTPOffset() executing\n");
    return 0;
}

//For now, not in use
uint64_t getNTPTimeFromJava()
{
    printf("Controller.cc - getNTPTimeFromJava() executing\n");
    return 0;
}

const char* getControllerDefaultDeviceId()
{
    printf("Controller.cc - getControllerDefaultDeviceId() executing\n");

    qcc::String rdd = qcc::RandHexString(16);
    NSString *randomDeviceID = [NSString stringWithUTF8String: rdd.c_str()];
    const char *deviceID = [[controllerServiceDelegate getControllerDefaultDeviceID: randomDeviceID] UTF8String];

    return deviceID;
}

qcc::String* getControllerDefaultAppId(const char* str)
{
    printf("Controller.cc - getControllerDefaultAppId() executing\n");

    NSString *randomAppID = [NSString stringWithUTF8String: str];
    const char *appID = [[controllerServiceDelegate getControllerDefaultAppID: randomAppID] UTF8String];
    qcc::String *stringAppID = new qcc::String(appID);

    return stringAppID;
}

uint64_t getMacAddress()
{
    printf("Controller.cc - getMacAddress() executing\n");
    return [controllerServiceDelegate getMacAddress];
}

bool isNetworkConnected()
{
    printf("Controller.cc - isNetworkConnected() executing\n");
    return true;
}

OEM_CS_RankParam_Power getRankPower()
{
    printf("Controller.cc - getRankPower() executing\n");
    return BATTERY_POWERED_CHARGABLE;
}

OEM_CS_RankParam_Mobility getRankMobility()
{
    printf("Controller.cc - getRankMobility() executing\n");
    return HIGH_MOBILITY;
}

OEM_CS_RankParam_Availability getRankAvailability()
{
    printf("Controller.cc - getRankAvailability() executing\n");
    return SIX_TO_NINE_HOURS;
}

OEM_CS_RankParam_NodeType getRankNodeType()
{
    printf("Controller.cc - getRankNodeType() executing\n");
    return WIRELESS;
}

Controller::Controller(id<LSFControllerServiceDelegate> delegate)
{
    printf("Controller.cc - Controller() constructor executing\n");

    controllerServiceDelegate = delegate;
}

void Controller::StartController(const char *keyStoreFilePath)
{
    printf("controller.cc :: startControllerService\n");
    printf("keyStore: %s\n", keyStoreFilePath);
    int argc = 5;
    char* argv[argc];
    argv[0] = const_cast <char*>("controllerService");
    argv[1] = const_cast <char*>("-f");
    argv[2] = const_cast <char*>("-l");
    argv[3] = const_cast <char*>("-k");
    argv[4] = const_cast <char*>(keyStoreFilePath);
    g_running = true;

    runMain(argc, argv);
}

void Controller::StopController()
{
    printf("stopping ControllerService. g_running=%d\n", g_running);

    if(g_running == 0)
    {
        //if it is not running, do nothing, otherwise, stop the controller.
        printf("controller g_running is already false. do nothing\n");
    }
    else
    {
        printf("controller g_running=true. convert it to false\n");
        g_running = false;

        while (true)
        {
            LuminaireSleep(1000);
            if(isRunning == 0)
            {
                //means the controller has fully stopped.
                printf("controller has fully stopped\n");
                break;
            }
            else
            {
                printf("controller is in process of stopping\n");
            }
        }
    }
}

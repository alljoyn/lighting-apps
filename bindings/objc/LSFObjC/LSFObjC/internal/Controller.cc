/******************************************************************************
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
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

#include "Controller.h"

using namespace ajn;
using namespace lsf;
using namespace qcc;

#ifdef LSF_BINDINGS
using namespace controllerservice;
#endif

id<LSFControllerServiceDelegate> controllerServiceDelegate = NULL;
OEM_CS_NetworkCallback* networkCallbackReference = NULL;

void ControllerServiceSleep(uint32_t msec)
{
    usleep(1000 * msec);
}

const char* getControllerDefaultDeviceId()
{
    printf("Controller.cc - getControllerDefaultDeviceId() executing\n");

    qcc::String rdd = qcc::RandHexString(16);
    NSString *randomDeviceID = [NSString stringWithUTF8String: rdd.c_str()];
    const char *deviceID = [[controllerServiceDelegate getControllerDefaultDeviceID: randomDeviceID] UTF8String];

    return deviceID;
}

uint64_t getMacAddress()
{
    printf("Controller.cc - getMacAddress() executing\n");

    qcc::String mac = qcc::RandHexString(12);
    NSString *generatedMacAddress = [NSString stringWithUTF8String: mac.c_str()];
    return [controllerServiceDelegate getMacAddressAsDecimal: generatedMacAddress];
}

bool isNetworkConnected()
{
    printf("Controller.cc - isNetworkConnected() executing\n");
    return [controllerServiceDelegate isNetworkConnected];
}

OEM_CS_RankParam_Power getRankPower()
{
    printf("Controller.cc - getRankPower() executing\n");
    return [controllerServiceDelegate getControllerRankPower];
}

OEM_CS_RankParam_Mobility getRankMobility()
{
    printf("Controller.cc - getRankMobility() executing\n");
    return [controllerServiceDelegate getControllerRankMobility];
}

OEM_CS_RankParam_Availability getRankAvailability()
{
    printf("Controller.cc - getRankAvailability() executing\n");
    return [controllerServiceDelegate getControllerRankAvailability];
}

OEM_CS_RankParam_NodeType getRankNodeType()
{
    printf("Controller.cc - getRankNodeType() executing\n");
    return [controllerServiceDelegate getControllerRankNodeType];
}

void populateDefaultProperties(ajn::AboutData* aboutData)
{
    printf("Controller.cc - populateDefaultProperties() executing\n");
    LSFSDKAboutData *myAboutData = [[LSFSDKAboutData alloc] initWithAboutData: aboutData];
    return [controllerServiceDelegate populateDefaultProperties: myAboutData];
}

Controller::Controller()
{
    printf("Controller.cc - Controller() constructor executing\n");
}

void Controller::SetControllerCallback(id<LSFControllerServiceDelegate> delegate)
{
    controllerServiceDelegate = delegate;
}

void Controller::StartController(const char *keyStoreFilePath)
{
    printf("controller.cc :: startControllerService keyStore: %s\n", keyStoreFilePath);
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

    g_running = false;

    while (g_running && isRunning)
    {
        ControllerServiceSleep(1000);
        printf("Controller is in process of stopping\n");
    }

    printf("Controller has fully stopped\n");
}

void Controller::FactoryResetController()
{
    printf("resetting the controller service");

    if (controllerSvcManagerPtrForLuminaire != NULL)
    {
        controllerSvcManagerPtrForLuminaire->GetControllerServicePtr()->FactoryResetAPI();
    }
}

void Controller::LightingResetController()
{
    printf("factory resetting the controller service");

    if (controllerSvcManagerPtrForLuminaire != NULL)
    {
        controllerSvcManagerPtrForLuminaire->GetControllerServicePtr()->LightingResetAPI();
    }
}

void Controller::SendNetworkConnected()
{
    if (networkCallbackReference)
    {
        networkCallbackReference->Connected();
    }
}

void Controller::SendNetworkDisconnected()
{
    if (networkCallbackReference)
    {
        networkCallbackReference->Disconnected();
    }
}

qcc::String Controller::GetControllerName()
{
    if (controllerSvcManagerPtrForLuminaire != NULL)
    {
        LSFAboutDataStore dataStore = controllerSvcManagerPtrForLuminaire->GetControllerServicePtr()->GetAboutDataStore();

        char* controllerName = NULL;
        dataStore.GetDeviceName(&controllerName);
        return qcc::String(controllerName);
    }

    return qcc::String();
}

bool Controller::IsControllerLeader()
{
    return (controllerSvcManagerPtrForLuminaire) ? controllerSvcManagerPtrForLuminaire->GetControllerServicePtr()->IsLeader() : false;
}
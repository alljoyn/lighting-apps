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

#ifndef LSFController_Controller_h
#define LSFController_Controller_h

#include "LSFTypes.h"
#include <algorithm>
#include <alljoyn/BusAttachment.h>
#include <alljoyn/Status.h>
#include <alljoyn/version.h>
#include <climits>
#include <lsf/controllerservice/ControllerService.h>
#include <fstream>
#include <inttypes.h>
#include <iostream>
#include <lsf/controllerservice/LSFAboutDataStore.h>
#include <qcc/Debug.h>
#include <qcc/StringUtil.h>
#include <signal.h>
#include <sstream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>
#import "LSFControllerServiceDelegate.h"

using namespace ajn;

extern lsf::controllerservice::ControllerServiceManager* controllerSvcManagerPtrForLuminaire;
extern int runMain(int argc, char** argv);
extern volatile sig_atomic_t g_running;
extern volatile sig_atomic_t isRunning;
extern bool g_IsLeader;
extern lsf::controllerservice::LSFAboutDataStore* luminaireDS;
extern qcc::String controllerName;
//Not in use functions
extern long getNTPOffset();
extern uint64_t getNTPTimeFromJava();
extern const char* getControllerDefaultDeviceId();
extern qcc::String* getControllerDefaultAppId(const char* str);
extern uint64_t getMacAddress();
extern bool isNetworkConnected();
extern lsf::controllerservice::OEM_CS_NetworkCallback* networkCallbackReference;
extern lsf::controllerservice::OEM_CS_RankParam_Power getRankPower();
extern lsf::controllerservice::OEM_CS_RankParam_Mobility getRankMobility();
extern lsf::controllerservice::OEM_CS_RankParam_Availability getRankAvailability();
extern lsf::controllerservice::OEM_CS_RankParam_NodeType getRankNodeType();

class Controller {
    public:
        Controller(id<LSFControllerServiceDelegate> delegate);
        void StartController(const char *keyStoreFilePath);
        void StopController();
};

#endif

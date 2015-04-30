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

#include "ControllerServiceJNI.h"

#define __STDC_FORMAT_MACROS

#define QCC_MODULE "AJN-LSF-JNI"

using namespace ajn;
using namespace lsf;
using namespace controllerservice;
using namespace qcc;

jobject jglobalObj;
extern JNIEnv* GetEnv(jint*);

OEM_CS_NetworkCallback* networkCallbackReference = NULL;

void ControllerServiceSleep(uint32_t msec)
{
    usleep(1000 * msec);
}

extern "C" JNIEXPORT void JNICALL Java_org_allseen_lsf_ControllerService_stop(JNIEnv* env, jobject jobj)
{
    g_running = false;

    while (g_running && isRunning) {
        ControllerServiceSleep(1000);
    }
}

extern "C" JNIEXPORT void JNICALL Java_org_allseen_lsf_ControllerService_start(JNIEnv* env, jobject jobj, jstring keyStoreFileLocation)
{
    const char* constKeyStore = (env)->GetStringUTFChars(keyStoreFileLocation, NULL);

    int argc = 5;
    char* argv[argc];
    argv[0] = const_cast<char*>("controllerService");
    argv[1] = const_cast<char*>("-f");
    argv[2] = const_cast<char*>("-l");
    argv[3] = const_cast<char*>("-k");
    argv[4] = const_cast<char*>(constKeyStore);

    g_running = true;
    jglobalObj = (env)->NewGlobalRef(jobj);

    ControllerServiceMain(argc, argv);
}

const char* getControllerDefaultDeviceId()
{
    qcc::String dev_id = qcc::RandHexString(32);
    jint* result = 0;
    JNIEnv* globalEnv = GetEnv(result);
    jclass cls = (globalEnv)->GetObjectClass(jglobalObj);
    jmethodID mid = (globalEnv)->GetMethodID(cls, "getControllerDefaultDeviceId", "(Ljava/lang/String;)Ljava/lang/String;");
    if (mid == 0) {
        return "";
    }
    jstring javaStr = (globalEnv)->NewStringUTF(dev_id.c_str());
    jstring n = (jstring) (globalEnv)->CallObjectMethod(jglobalObj, mid, javaStr);
    (globalEnv)->DeleteLocalRef(cls);
    const char* name = (globalEnv)->GetStringUTFChars(n, NULL);
    return name;
}

qcc::String* getControllerDefaultAppId(const char* str)
{
    jint* result = 0;
    JNIEnv* globalEnv = GetEnv(result);
    jclass cls = (globalEnv)->GetObjectClass(jglobalObj);
    jmethodID mid = (globalEnv)->GetMethodID(cls, "getControllerDefaultAppId", "(Ljava/lang/String;)Ljava/lang/String;"); //[I  Ljava/lang/String;
    if (mid == 0) {
        return NULL;
    }
    jstring javaStr = (globalEnv)->NewStringUTF(str);
    jstring javaAppId = (jstring) (globalEnv)->CallObjectMethod(jglobalObj, mid, javaStr);
    const char* appId = (globalEnv)->GetStringUTFChars(javaAppId, NULL);
    (globalEnv)->DeleteLocalRef(cls);
    qcc::String* stringAppId = new qcc::String(appId);
    return stringAppId;
}

uint64_t getMacAddress()
{
    qcc::String mac = qcc::RandHexString(12);
    uint64_t res = 0;
    jint* result = 0;
    JNIEnv* globalEnv = GetEnv(result);
    jclass cls = (globalEnv)->GetObjectClass(jglobalObj);
    jmethodID mid = (globalEnv)->GetMethodID(cls, "getMacAddressAsDecimal", "(Ljava/lang/String;)J");
    if (mid == 0) {
        return res;
    }
    long n = (globalEnv)->CallLongMethod(jglobalObj, mid);
    (globalEnv)->DeleteLocalRef(cls);
    res = n;
    return res;
}

bool isNetworkConnected()
{
    jint* result = 0;
    JNIEnv* globalEnv = GetEnv(result);
    jclass cls = (globalEnv)->GetObjectClass(jglobalObj);
    jmethodID mid = (globalEnv)->GetMethodID(cls, "isNetworkConnected", "()Z");
    if (mid == 0) {
        return false;
    }
    bool b = (globalEnv)->CallBooleanMethod(jglobalObj, mid);
    (globalEnv)->DeleteLocalRef(cls);
    return b;
}

OEM_CS_RankParam_Power getRankPower()
{
    // TODO: request through JNI so the value can provided at the app level
    return BATTERY_POWERED_CHARGABLE;
}

OEM_CS_RankParam_Mobility getRankMobility()
{
    // TODO: request through JNI so the value can provided at the app level
    return HIGH_MOBILITY;
}

OEM_CS_RankParam_Availability getRankAvailability()
{
    // TODO: request through JNI so the value can provided at the app level
    return SIX_TO_NINE_HOURS;
}

OEM_CS_RankParam_NodeType getRankNodeType()
{
    // TODO: request through JNI so the value can provided at the app level
    return WIRELESS;
}


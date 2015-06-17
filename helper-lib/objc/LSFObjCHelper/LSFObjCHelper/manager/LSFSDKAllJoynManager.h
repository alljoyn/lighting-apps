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

#import "LSFSDKHelperControllerClientCallback.h"
#import "LSFSDKHelperControllerServiceManagerCallback.h"
#import "LSFSDKHelperGroupManagerCallback.h"
#import "LSFSDKHelperLampManagerCallback.h"
#import "LSFSDKHelperPresetManagerCallback.h"
#import "LSFSDKHelperTransitionEffectManagerCallback.h"
#import "LSFSDKHelperPulseEffectManagerCallback.h"
#import "LSFSDKHelperSceneElementManagerCallback.h"
#import "LSFSDKHelperSceneManagerCallback.h"
#import "LSFSDKHelperMasterSceneManagerCallback.h"
#import "BusAttachment.h"
#import "LSFLampAnnouncementData.h"
#import "LSFControllerClient.h"
#import "LSFControllerServiceManager.h"
#import "LSFLampManager.h"
#import "LSFPresetManager.h"
#import "BusAttachment.h"
#import "LSFLampGroupManager.h"
#import "LSFSceneElementManager.h"
#import "LSFSceneManager.h"
#import "LSFMasterSceneManager.h"
#import "LSFTransitionEffectManager.h"
#import "LSFPulseEffectManager.h"

@interface LSFSDKAllJoynManager : NSObject

+(void)initializeWithApplicationName: (NSString *)applicationName controllerClientCallback: (LSFSDKHelperControllerClientCallback *)ccc controllerServiceManagerCallback: (LSFSDKHelperControllerServiceManagerCallback *)csmc lampManagerCallback: (LSFSDKHelperLampManagerCallback *)lmc groupManagerCallback: (LSFSDKHelperGroupManagerCallback *)gmc presetManagerCallback: (LSFSDKHelperPresetManagerCallback *)pmc transitionEffectManagerCallback: (LSFSDKHelperTransitionEffectManagerCallback *)temc pulseEffectManagerCallback: (LSFSDKHelperPulseEffectManagerCallback *)pemc sceneElementManagerCallback: (LSFSDKHelperSceneElementManagerCallback *)semc sceneManagerCallback: (LSFSDKHelperSceneManagerCallback *)smc masterSceneManagerCallback: (LSFSDKHelperMasterSceneManagerCallback *)msmc;
+(void)initializeWithBusAttachment: (ajn::BusAttachment *)busAttachment controllerClientCallback: (LSFSDKHelperControllerClientCallback *)ccc controllerServiceManagerCallback: (LSFSDKHelperControllerServiceManagerCallback *)csmc lampManagerCallback: (LSFSDKHelperLampManagerCallback *)lmc groupManagerCallback: (LSFSDKHelperGroupManagerCallback *)gmc presetManagerCallback: (LSFSDKHelperPresetManagerCallback *)pmc transitionEffectManagerCallback: (LSFSDKHelperTransitionEffectManagerCallback *)temc pulseEffectManagerCallback: (LSFSDKHelperPulseEffectManagerCallback *)pemc sceneElementManagerCallback: (LSFSDKHelperSceneElementManagerCallback *)semc sceneManagerCallback: (LSFSDKHelperSceneManagerCallback *)smc masterSceneManagerCallback: (LSFSDKHelperMasterSceneManagerCallback *)msmc;
+(void)startWithQueue: (dispatch_queue_t)queue;
+(void)stop;
+(void)addNewLamp: (NSString*)lampID lampAnnouncementData:(LSFLampAnnouncementData *)lampAnnData;
+(void)getAboutDataForLampID: (NSString*)lampID;
+(void)setControllerConnected: (BOOL)isConnected;
+(BOOL)getControllerConnected;
+(LSFControllerClient *)getControllerClient;
+(LSFControllerServiceManager *)getControllerServiceManager;
+(LSFLampManager *)getLampManager;
+(LSFLampGroupManager *)getGroupManager;
+(LSFPresetManager *)getPresetManager;
+(LSFSceneElementManager *)getSceneElementManager;
+(LSFSceneManager *)getSceneManager;
+(LSFMasterSceneManager *)getMasterSceneManager;
+(LSFTransitionEffectManager *)getTransitionEffectManager;
+(LSFPulseEffectManager *)getPulseEffectManager;
+(LSFSDKHelperControllerClientCallback *)getControllerClientCallback;
+(LSFSDKHelperControllerServiceManagerCallback *)getControllerServiceManagerCallback;
+(LSFSDKHelperLampManagerCallback *)getLampManagerCallback;
+(LSFSDKHelperGroupManagerCallback *)getGroupManagerCallback;
+(LSFSDKHelperPresetManagerCallback *)getPresetManagerCallback;
+(LSFSDKHelperSceneElementManagerCallback *)getSceneElementManagerCallback;
+(LSFSDKHelperSceneManagerCallback *)getSceneManagerCallback;
+(LSFSDKHelperMasterSceneManagerCallback *)getMasterSceneManagerCallback;
+(LSFSDKHelperTransitionEffectManagerCallback *)getTransitionEffectManagerCallback;
+(LSFSDKHelperPulseEffectManagerCallback *)getPulseEffectManagerCallback;
+(ajn::BusAttachment *)getBusAttachment;

@end

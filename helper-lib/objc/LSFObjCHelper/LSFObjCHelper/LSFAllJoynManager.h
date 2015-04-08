/******************************************************************************
 * Copyright (c) 2014, AllSeen Alliance. All rights reserved.
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

#import <Foundation/Foundation.h>
#import "LSFControllerClient.h"
#import "LSFControllerServiceManager.h"
#import "LSFLampManager.h"
#import "LSFPresetManager.h"
#import "BusAttachment.h"
#import "LSFLampGroupManager.h"
#import "LSFSceneManager.h"
#import "LSFMasterSceneManager.h"
#import "LSFHelperControllerClientCallback.h"
#import "LSFHelperControllerServiceManagerCallback.h"
#import "LSFHelperLampManagerCallback.h"
#import "LSFHelperLampGroupManagerCallback.h"
#import "LSFHelperPresetManagerCallback.h"
#import "LSFHelperSceneManagerCallback.h"
#import "LSFHelperMasterSceneManagerCallback.h"
#import "LSFLampAnnouncementData.h"
#import "LSFAboutManager.h"
#import "LSFLightingSystemManager.h"

/**
 * @warning *Note:* This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK.
 */
@interface LSFAllJoynManager : NSObject

@property (nonatomic, strong) LSFLightingSystemManager *director;
@property (nonatomic, readonly) ajn::BusAttachment *bus;
@property (nonatomic, strong) LSFControllerClient *lsfControllerClient;
@property (nonatomic, strong) LSFControllerServiceManager *lsfControllerServiceManager;
@property (nonatomic, strong) LSFLampManager *lsfLampManager;
@property (nonatomic, strong) LSFLampGroupManager *lsfLampGroupManager;
@property (nonatomic, strong) LSFPresetManager *lsfPresetManager;
@property (nonatomic, strong) LSFSceneManager *lsfSceneManager;
@property (nonatomic, strong) LSFMasterSceneManager *lsfMasterSceneManager;
@property (nonatomic, strong) LSFHelperControllerClientCallback *sccc;
@property (nonatomic, strong) LSFHelperControllerServiceManagerCallback *scsmc;
@property (nonatomic, strong) LSFHelperLampManagerCallback *slmc;
@property (nonatomic, strong) LSFHelperLampGroupManagerCallback *slgmc;
@property (nonatomic, strong) LSFHelperPresetManagerCallback *spmc;
@property (nonatomic, strong) LSFHelperSceneManagerCallback *ssmc;
@property (nonatomic, strong) LSFHelperMasterSceneManagerCallback *smsmc;
@property (nonatomic, strong) LSFAboutManager *aboutManager;
@property (nonatomic) BOOL isConnectedToController;

+(LSFAllJoynManager *)getAllJoynManager;
-(void)start;
-(void)stop;
-(void)addNewLamp: (NSString*)lampID lampAnnouncementData:(LSFLampAnnouncementData*)lampAnnData;
-(void)getAboutDataForLampID: (NSString*)lampID;

@end

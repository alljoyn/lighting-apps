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

#import "LSFObject.h"
#import "LSFControllerClient.h"
#import "LSFMasterSceneManagerCallbackDelegate.h"
#import "LSFMasterScene.h"
#import <MasterSceneManager.h>

@interface LSFMasterSceneManager : LSFObject

-(id)initWithControllerClient: (LSFControllerClient *)controllerClient andMasterSceneManagerCallbackDelegate: (id<LSFMasterSceneManagerCallbackDelegate>)msmDelegate;
-(ControllerClientStatus)getAllMasterSceneIDs;
-(ControllerClientStatus)getMasterSceneNameWithID: (NSString *)masterSceneID;
-(ControllerClientStatus)getMasterSceneNameWithID: (NSString *)masterSceneID andLanguage: (NSString *)language;
-(ControllerClientStatus)setMasterSceneNameWithID: (NSString *)masterSceneID andMasterSceneName: (NSString *)masterSceneName;
-(ControllerClientStatus)setMasterSceneNameWithID: (NSString *)masterSceneID masterSceneName: (NSString *)masterSceneName andLanguage: (NSString *)language;
-(ControllerClientStatus)createMasterScene: (LSFMasterScene *)masterScene withName: (NSString *)masterSceneName;
-(ControllerClientStatus)createMasterScene: (LSFMasterScene *)masterScene withName: (NSString *)masterSceneName andLanguage: (NSString *)language;
-(ControllerClientStatus)createMasterSceneWithTracking: (uint32_t *)trackingID masterScene: (LSFMasterScene *)masterScene withName: (NSString *)masterSceneName;
-(ControllerClientStatus)createMasterSceneWithTracking: (uint32_t *)trackingID masterScene: (LSFMasterScene *)masterScene withName: (NSString *)masterSceneName andLanguage: (NSString *)language;
-(ControllerClientStatus)updateMasterSceneWithID: (NSString *)masterSceneID andMasterScene: (LSFMasterScene *)masterScene;
-(ControllerClientStatus)getMasterSceneWithID: (NSString *)masterSceneID;
-(ControllerClientStatus)deleteMasterSceneWithID: (NSString *)masterSceneID;
-(ControllerClientStatus)applyMasterSceneWithID: (NSString *)masterSceneID;
-(ControllerClientStatus)getMasterSceneDataWithID: (NSString *)masterSceneID;
-(ControllerClientStatus)getMasterSceneDataWithID: (NSString *)masterSceneID andLanguage: (NSString *)language;

@end
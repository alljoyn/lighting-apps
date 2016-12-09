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

#import "LSFSceneElementManager.h"
#import "LSFSceneElementManagerCallback.h"

@interface LSFSceneElementManager()

@property (nonatomic, readonly) lsf::SceneElementManager *sceneElementManager;
@property (nonatomic, assign) LSFSceneElementManagerCallback *sceneElementManagerCallback;

@end

@implementation LSFSceneElementManager

@synthesize sceneElementManager = _sceneElementManager;
@synthesize sceneElementManagerCallback = _sceneElementManagerCallback;

-(id)initWithControllerClient: (LSFControllerClient *)controllerClient andSceneElementManagerCallbackDelegate: (id<LSFSceneElementManagerCallbackDelegate>)semDelegate
{
    self = [super init];

    if (self)
    {
        self.sceneElementManagerCallback = new LSFSceneElementManagerCallback(semDelegate);
        self.handle = new lsf::SceneElementManager(*(static_cast<lsf::ControllerClient*>(controllerClient.handle)), *(self.sceneElementManagerCallback));
    }

    return self;
}

-(ControllerClientStatus)getAllSceneElementIDs
{
    return self.sceneElementManager->GetAllSceneElementIDs();
}

-(ControllerClientStatus)getSceneElementNameWithID: (NSString *)sceneElementID
{
    std::string seid([sceneElementID UTF8String]);
    return self.sceneElementManager->GetSceneElementName(seid);
}

-(ControllerClientStatus)getSceneElementNameWithID: (NSString *)sceneElementID andLanguage: (NSString *)language
{
    std::string seid([sceneElementID UTF8String]);
    std::string lang([language UTF8String]);
    return self.sceneElementManager->GetSceneElementName(seid, lang);
}

-(ControllerClientStatus)setSceneElementNameWithID: (NSString *)sceneElementID andSceneElementName: (NSString *)sceneElementName
{
    std::string seid([sceneElementID UTF8String]);
    std::string name([sceneElementName UTF8String]);
    return self.sceneElementManager->SetSceneElementName(seid, name);
}

-(ControllerClientStatus)setSceneElementNameWithID: (NSString *)sceneElementID sceneElementName: (NSString *)sceneElementName andLanguage: (NSString *)language
{
    std::string seid([sceneElementID UTF8String]);
    std::string name([sceneElementName UTF8String]);
    std::string lang([language UTF8String]);
    return self.sceneElementManager->SetSceneElementName(seid, name, lang);
}

-(ControllerClientStatus)createSceneElementWithTracking: (uint32_t *)trackingID sceneElement: (LSFSceneElement *)sceneElement andSceneElementName: (NSString *)sceneElementName
{
    std::string name([sceneElementName UTF8String]);
    return self.sceneElementManager->CreateSceneElement(*trackingID, *(static_cast<lsf::SceneElement*>(sceneElement.handle)), name);
}

-(ControllerClientStatus)createSceneElementWithTracking: (uint32_t *)trackingID sceneElement: (LSFSceneElement *)sceneElement sceneElementName: (NSString *)sceneElementName andLanguage: (NSString *)language
{
    std::string name([sceneElementName UTF8String]);
    std::string lang([language UTF8String]);
    return self.sceneElementManager->CreateSceneElement(*trackingID, *(static_cast<lsf::SceneElement*>(sceneElement.handle)), name, lang);
}

-(ControllerClientStatus)updateSceneElementWithID: (NSString *)sceneElementID withSceneElement: (LSFSceneElement *)sceneElement
{
    std::string seid([sceneElementID UTF8String]);
    return self.sceneElementManager->UpdateSceneElement(seid, *(static_cast<lsf::SceneElement*>(sceneElement.handle)));
}

-(ControllerClientStatus)deleteSceneElementWithID: (NSString *)sceneElementID
{
    std::string seid([sceneElementID UTF8String]);
    return self.sceneElementManager->DeleteSceneElement(seid);
}

-(ControllerClientStatus)getSceneElementWithID: (NSString *)sceneElementID
{
    std::string seid([sceneElementID UTF8String]);
    return self.sceneElementManager->GetSceneElement(seid);
}

-(ControllerClientStatus)applySceneElementWithID: (NSString *)sceneElementID
{
    std::string seid([sceneElementID UTF8String]);
    return self.sceneElementManager->ApplySceneElement(seid);
}

-(ControllerClientStatus)getSceneElementDataWithID: (NSString *)sceneElementID
{
    std::string seid([sceneElementID UTF8String]);
    return self.sceneElementManager->GetSceneElementDataSet(seid);
}

-(ControllerClientStatus)getSceneElementDataWithID: (NSString *)sceneElementID andLanguage: (NSString *)language
{
    std::string seid([sceneElementID UTF8String]);
    std::string lang([language UTF8String]);
    return self.sceneElementManager->GetSceneElementDataSet(seid, lang);;
}

/*
 * Accessor for the internal C++ API object this objective-c class encapsulates
 */
-(lsf::SceneElementManager *)sceneElementManager
{
    return static_cast<lsf::SceneElementManager*>(self.handle);
}

@end
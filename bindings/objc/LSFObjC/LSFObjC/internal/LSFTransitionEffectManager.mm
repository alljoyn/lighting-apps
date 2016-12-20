/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFTransitionEffectManager.h"
#import "LSFTransitionEffectManagerCallback.h"
#import <TransitionEffectManager.h>

@interface LSFTransitionEffectManager()

@property (nonatomic, readonly) lsf::TransitionEffectManager *transitionEffectManager;
@property (nonatomic, assign) LSFTransitionEffectManagerCallback *transitionEffectManagerCallback;

@end

@implementation LSFTransitionEffectManager

-(id)initWithControllerClient: (LSFControllerClient *)controllerClient andTransitionEffectManagerCallbackDelegate: (id<LSFTransitionEffectManagerCallbackDelegate>)temDelegate
{
    self = [super init];

    if (self)
    {
        self.transitionEffectManagerCallback = new LSFTransitionEffectManagerCallback(temDelegate);
        self.handle = new lsf::TransitionEffectManager(*(static_cast<lsf::ControllerClient*>(controllerClient.handle)), *(self.transitionEffectManagerCallback));
    }

    return self;
}

-(ControllerClientStatus)getAllTransitionEffectIDs
{
    return self.transitionEffectManager->GetAllTransitionEffectIDs();
}

-(ControllerClientStatus)getTransitionEffectWithID: (NSString *)transitionEffectID
{
    std::string teid([transitionEffectID UTF8String]);
    return self.transitionEffectManager->GetTransitionEffect(teid);
}

-(ControllerClientStatus)applyTranstionEffectWithID: (NSString *)transitionEffectID onLamps: (NSArray *)lampIDs
{
    std::string teid([transitionEffectID UTF8String]);
    LSFStringList lids;

    for (NSString *lid in lampIDs)
    {
        lids.push_back([lid UTF8String]);
    }

    return self.transitionEffectManager->ApplyTransitionEffectOnLamps(teid, lids);
}

-(ControllerClientStatus)applyTranstionEffectWithID: (NSString *)transitionEffectID onLampGroups: (NSArray *)lampGroupIDs
{
    std::string teid([transitionEffectID UTF8String]);
    LSFStringList lgids;

    for (NSString *lgid in lampGroupIDs)
    {
        lgids.push_back([lgid UTF8String]);
    }

    return self.transitionEffectManager->ApplyTransitionEffectOnLampGroups(teid, lgids);
}

-(ControllerClientStatus)getTransitionEffectNameWithID: (NSString *)transitionEffectID
{
    std::string teid([transitionEffectID UTF8String]);
    return self.transitionEffectManager->GetTransitionEffectName(teid);
}

-(ControllerClientStatus)getTransitionEffectNameWithID: (NSString *)transitionEffectID andLanguage: (NSString *)language
{
    std::string teid([transitionEffectID UTF8String]);
    std::string lang([language UTF8String]);
    return self.transitionEffectManager->GetTransitionEffectName(teid, lang);
}

-(ControllerClientStatus)setTransitionEffectNameWithID: (NSString *)transitionEffectID transitionEffectName: (NSString *)transitionEffectName
{
    std::string teid([transitionEffectID UTF8String]);
    std::string name([transitionEffectName UTF8String]);
    return self.transitionEffectManager->SetTransitionEffectName(teid, name);
}

-(ControllerClientStatus)setTransitionEffectNameWithID: (NSString *)transitionEffectID transitionEffectName: (NSString *)transitionEffectName andLanguage: (NSString *)language
{
    std::string teid([transitionEffectID UTF8String]);
    std::string name([transitionEffectName UTF8String]);
    std::string lang([language UTF8String]);
    return self.transitionEffectManager->SetTransitionEffectName(teid, name, lang);
}

-(ControllerClientStatus)createTransitionEffectWithTracking: (uint32_t *)trackingID transitionEffect: (LSFTransitionEffectV2 *)transitionEffect andTransitionEffectName: (NSString *)transitionEffectName
{
    std::string name([transitionEffectName UTF8String]);
    return self.transitionEffectManager->CreateTransitionEffect(*trackingID, *(static_cast<lsf::TransitionEffect*>(transitionEffect.handle)), name);
}

-(ControllerClientStatus)createTransitionEffectWithTracking: (uint32_t *)trackingID transitionEffect: (LSFTransitionEffectV2 *)transitionEffect transitionEffectName: (NSString *)transitionEffectName andLanguage: (NSString *)language
{
    std::string name([transitionEffectName UTF8String]);
    std::string lang([language UTF8String]);
    return self.transitionEffectManager->CreateTransitionEffect(*trackingID, *(static_cast<lsf::TransitionEffect*>(transitionEffect.handle)), name, lang);
}

-(ControllerClientStatus)updateTransitionEffectWithID: (NSString *)transitionEffectID andTransitionEffect: (LSFTransitionEffectV2 *)transitionEffect
{
    std::string teid([transitionEffectID UTF8String]);
    return self.transitionEffectManager->UpdateTransitionEffect(teid, *(static_cast<lsf::TransitionEffect*>(transitionEffect.handle)));
}

-(ControllerClientStatus)deleteTransitionEffectWithID: (NSString *)transitionEffectID
{
    std::string teid([transitionEffectID UTF8String]);
    return self.transitionEffectManager->DeleteTransitionEffect(teid);
}

-(ControllerClientStatus)getTransitionEffectDataSetWithID: (NSString *)transitionEffectID
{
    std::string teid([transitionEffectID UTF8String]);
    return self.transitionEffectManager->GetTransitionEffectDataSet(teid);
}

-(ControllerClientStatus)getTransitionEffectDataSetWithID: (NSString *)transitionEffectID andLanguage: (NSString *)language
{
    std::string teid([transitionEffectID UTF8String]);
    std::string lang([language UTF8String]);
    return self.transitionEffectManager->GetTransitionEffectDataSet(teid, lang);
}

/*
 * Accessor for the internal C++ API object this objective-c class encapsulates
 */
-(lsf::TransitionEffectManager *)transitionEffectManager
{
    return static_cast<lsf::TransitionEffectManager*>(self.handle);
}

@end
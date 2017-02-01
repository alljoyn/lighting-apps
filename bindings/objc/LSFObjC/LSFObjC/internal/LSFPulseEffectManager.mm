/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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

#import "LSFPulseEffectManager.h"
#import "LSFPulseEffectManagerCallback.h"
#import <PulseEffectManager.h>

@interface LSFPulseEffectManager()

@property (nonatomic, readonly) lsf::PulseEffectManager *pulseEffectManager;
@property (nonatomic, assign) LSFPulseEffectManagerCallback *pulseEffectManagerCallback;

@end

@implementation LSFPulseEffectManager

-(id)initWithControllerClient: (LSFControllerClient *)controllerClient andPulseEffectManagerCallbackDelegate: (id<LSFPulseEffectManagerCallbackDelegate>)pemDelegate
{
    self = [super init];

    if (self)
    {
        self.pulseEffectManagerCallback = new LSFPulseEffectManagerCallback(pemDelegate);
        self.handle = new lsf::PulseEffectManager(*(static_cast<lsf::ControllerClient*>(controllerClient.handle)), *(self.pulseEffectManagerCallback));
    }

    return self;
}

-(ControllerClientStatus)getAllPulseEffectIDs
{
    return self.pulseEffectManager->GetAllPulseEffectIDs();
}

-(ControllerClientStatus)getPulseEffectWithID: (NSString *)pulseEffectID
{
    std::string peid([pulseEffectID UTF8String]);
    return self.pulseEffectManager->GetPulseEffect(peid);
}

-(ControllerClientStatus)applyPulseEffectWithID: (NSString *)pulseEffectID onLamps: (NSArray *)lampIDs
{
    std::string peid([pulseEffectID UTF8String]);
    LSFStringList lids;

    for (NSString *lid in lampIDs)
    {
        lids.push_back([lid UTF8String]);
    }

    return self.pulseEffectManager->ApplyPulseEffectOnLamps(peid, lids);
}

-(ControllerClientStatus)applyPulseEffectWithID: (NSString *)pulseEffectID onLampGroups: (NSArray *)lampGroupIDs
{
    std::string peid([pulseEffectID UTF8String]);
    LSFStringList lgids;

    for (NSString *lgid in lampGroupIDs)
    {
        lgids.push_back([lgid UTF8String]);
    }

    return self.pulseEffectManager->ApplyPulseEffectOnLampGroups(peid, lgids);
}

-(ControllerClientStatus)getPulseEffectNameWithID: (NSString *)pulseEffectID
{
    std::string peid([pulseEffectID UTF8String]);
    return self.pulseEffectManager->GetPulseEffectName(peid);
}

-(ControllerClientStatus)getPulseEffectNameWithID: (NSString *)pulseEffectID andLanguage: (NSString *)language
{
    std::string peid([pulseEffectID UTF8String]);
    std::string lang([language UTF8String]);
    return self.pulseEffectManager->GetPulseEffectName(peid, lang);
}

-(ControllerClientStatus)setPulseEffectNameWithID: (NSString *)pulseEffectID pulseEffectName: (NSString *)pulseEffectName
{
    std::string peid([pulseEffectID UTF8String]);
    std::string name([pulseEffectName UTF8String]);
    return self.pulseEffectManager->SetPulseEffectName(peid, name);
}

-(ControllerClientStatus)setPulseEffectNameWithID: (NSString *)pulseEffectID pulseEffectName: (NSString *)pulseEffectName andLanguage: (NSString *)language
{
    std::string peid([pulseEffectID UTF8String]);
    std::string name([pulseEffectName UTF8String]);
    std::string lang([language UTF8String]);
    return self.pulseEffectManager->SetPulseEffectName(peid, name, lang);
}

-(ControllerClientStatus)createPulseEffectWithTracking: (uint32_t *)trackingID pulseEffect: (LSFPulseEffectV2 *)pulseEffect andPulseEffectName: (NSString *)pulseEffectName
{
    std::string name([pulseEffectName UTF8String]);
    return self.pulseEffectManager->CreatePulseEffect(*trackingID, *static_cast<lsf::PulseEffect*>(pulseEffect.handle), name);
}

-(ControllerClientStatus)createPulseEffectWithTracking: (uint32_t *)trackingID pulseEffect: (LSFPulseEffectV2 *)pulseEffect pulseEffectName: (NSString *)pulseEffectName andLanguage: (NSString *)language
{
    std::string name([pulseEffectName UTF8String]);
    std::string lang([language UTF8String]);
    return self.pulseEffectManager->CreatePulseEffect(*trackingID, *static_cast<lsf::PulseEffect*>(pulseEffect.handle), name, lang);
}

-(ControllerClientStatus)updatePulseEffectWithID: (NSString *)pulseEffectID andPulseEffect: (LSFPulseEffectV2 *)pulseEffect
{
    std::string peid([pulseEffectID UTF8String]);
    return self.pulseEffectManager->UpdatePulseEffect(peid, *static_cast<lsf::PulseEffect*>(pulseEffect.handle));
}

-(ControllerClientStatus)deletePulseEffectWithID: (NSString *)pulseEffectID
{
    std::string peid([pulseEffectID UTF8String]);
    return self.pulseEffectManager->DeletePulseEffect(peid);
}

-(ControllerClientStatus)getPulseEffectDataSetWithID: (NSString *)pulseEffectID
{
    std::string peid([pulseEffectID UTF8String]);
    return self.pulseEffectManager->GetPulseEffectDataSet(peid);
}

-(ControllerClientStatus)getPulseEffectDataSetWithID: (NSString *)pulseEffectID andLanguage: (NSString *)language
{
    std::string peid([pulseEffectID UTF8String]);
    std::string lang([language UTF8String]);
    return self.pulseEffectManager->GetPulseEffectDataSet(peid, lang);
}

/*
 * Accessor for the internal C++ API object this objective-c class encapsulates
 */
-(lsf::PulseEffectManager *)pulseEffectManager
{
    return static_cast<lsf::PulseEffectManager*>(self.handle);
}

@end
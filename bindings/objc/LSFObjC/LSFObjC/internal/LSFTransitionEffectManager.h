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

#import "LSFObject.h"
#import "LSFControllerClient.h"
#import "LSFTransitionEffectManagerCallbackDelegate.h"

@interface LSFTransitionEffectManager : LSFObject

-(id)initWithControllerClient: (LSFControllerClient *)controllerClient andTransitionEffectManagerCallbackDelegate: (id<LSFTransitionEffectManagerCallbackDelegate>)temDelegate;
-(ControllerClientStatus)getAllTransitionEffectIDs;
-(ControllerClientStatus)getTransitionEffectWithID: (NSString *)transitionEffectID;
-(ControllerClientStatus)applyTranstionEffectWithID: (NSString *)transitionEffectID onLamps: (NSArray *)lampIDs;
-(ControllerClientStatus)applyTranstionEffectWithID: (NSString *)transitionEffectID onLampGroups: (NSArray *)lampGroupIDs;
-(ControllerClientStatus)getTransitionEffectNameWithID: (NSString *)transitionEffectID;
-(ControllerClientStatus)getTransitionEffectNameWithID: (NSString *)transitionEffectID andLanguage: (NSString *)language;
-(ControllerClientStatus)setTransitionEffectNameWithID: (NSString *)transitionEffectID transitionEffectName: (NSString *)transitionEffectName;
-(ControllerClientStatus)setTransitionEffectNameWithID: (NSString *)transitionEffectID transitionEffectName: (NSString *)transitionEffectName andLanguage: (NSString *)language;
-(ControllerClientStatus)createTransitionEffectWithTracking: (uint32_t *)trackingID transitionEffect: (LSFTransitionEffectV2 *)transitionEffect andTransitionEffectName: (NSString *)transitionEffectName;
-(ControllerClientStatus)createTransitionEffectWithTracking: (uint32_t *)trackingID transitionEffect: (LSFTransitionEffectV2 *)transitionEffect transitionEffectName: (NSString *)transitionEffectName andLanguage: (NSString *)language;
-(ControllerClientStatus)updateTransitionEffectWithID: (NSString *)transitionEffectID andTransitionEffect: (LSFTransitionEffectV2 *)transitionEffect;
-(ControllerClientStatus)deleteTransitionEffectWithID: (NSString *)transitionEffectID;
-(ControllerClientStatus)getTransitionEffectDataSetWithID: (NSString *)transitionEffectID;
-(ControllerClientStatus)getTransitionEffectDataSetWithID: (NSString *)transitionEffectID andLanguage: (NSString *)language;

@end
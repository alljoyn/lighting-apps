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
#import "LSFPulseEffectManagerCallbackDelegate.h"

@interface LSFPulseEffectManager : LSFObject

-(id)initWithControllerClient: (LSFControllerClient *)controllerClient andPulseEffectManagerCallbackDelegate: (id<LSFPulseEffectManagerCallbackDelegate>)pemDelegate;
-(ControllerClientStatus)getAllPulseEffectIDs;
-(ControllerClientStatus)getPulseEffectWithID: (NSString *)pulseEffectID;
-(ControllerClientStatus)applyPulseEffectWithID: (NSString *)pulseEffectID onLamps: (NSArray *)lampIDs;
-(ControllerClientStatus)applyPulseEffectWithID: (NSString *)pulseEffectID onLampGroups: (NSArray *)lampGroupIDs;
-(ControllerClientStatus)getPulseEffectNameWithID: (NSString *)pulseEffectID;
-(ControllerClientStatus)getPulseEffectNameWithID: (NSString *)pulseEffectID andLanguage: (NSString *)language;
-(ControllerClientStatus)setPulseEffectNameWithID: (NSString *)pulseEffectID pulseEffectName: (NSString *)pulseEffectName;
-(ControllerClientStatus)setPulseEffectNameWithID: (NSString *)pulseEffectID pulseEffectName: (NSString *)pulseEffectName andLanguage: (NSString *)language;
-(ControllerClientStatus)createPulseEffectWithTracking: (uint32_t *)trackingID pulseEffect: (LSFPulseEffectV2 *)pulseEffect andPulseEffectName: (NSString *)pulseEffectName;
-(ControllerClientStatus)createPulseEffectWithTracking: (uint32_t *)trackingID pulseEffect: (LSFPulseEffectV2 *)pulseEffect pulseEffectName: (NSString *)pulseEffectName andLanguage: (NSString *)language;
-(ControllerClientStatus)updatePulseEffectWithID: (NSString *)pulseEffectID andPulseEffect: (LSFPulseEffectV2 *)pulseEffect;
-(ControllerClientStatus)deletePulseEffectWithID: (NSString *)pulseEffectID;
-(ControllerClientStatus)getPulseEffectDataSetWithID: (NSString *)pulseEffectID;
-(ControllerClientStatus)getPulseEffectDataSetWithID: (NSString *)pulseEffectID andLanguage: (NSString *)language;

@end
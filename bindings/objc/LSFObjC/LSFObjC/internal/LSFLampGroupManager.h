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
#import "LSFLampGroup.h"
#import "LSFLampState.h"
#import "LSFControllerClient.h"
#import "LSFLampGroupManagerCallbackDelegate.h"
#import <LampGroupManager.h>

using namespace lsf;

@interface LSFLampGroupManager : LSFObject

-(id)initWithControllerClient: (LSFControllerClient *)controllerClient andLampManagerCallbackDelegate: (id<LSFLampGroupManagerCallbackDelegate>)lgmDelegate;
-(ControllerClientStatus)getAllLampGroupIDs;
-(ControllerClientStatus)getLampGroupNameForID: (NSString *)groupID;
-(ControllerClientStatus)getLampGroupNameForID: (NSString *)groupID andLanguage: (NSString *)language;
-(ControllerClientStatus)setLampGroupNameForID: (NSString *)groupID andName: (NSString *)name;
-(ControllerClientStatus)setLampGroupNameForID: (NSString *)groupID andName: (NSString *)name andLanguage: (NSString *)language;
-(ControllerClientStatus)createLampGroup: (LSFLampGroup *)lampGroup withName: (NSString *)lampGroupName;
-(ControllerClientStatus)createLampGroup: (LSFLampGroup *)lampGroup withName: (NSString *)lampGroupName andLanguage: (NSString *)language;
-(ControllerClientStatus)createLampGroupWithTracking: (uint32_t *)trackingID lampGroup: (LSFLampGroup *)lampGroup withName: (NSString *)lampGroupName;
-(ControllerClientStatus)createLampGroupWithTracking: (uint32_t *)trackingID lampGroup: (LSFLampGroup *)lampGroup withName: (NSString *)lampGroupName andLanguage: (NSString *)language;
-(ControllerClientStatus)updateLampGroupWithID: (NSString *)groupID andLampGroup: (LSFLampGroup *)lampGroup;
-(ControllerClientStatus)getLampGroupWithID: (NSString *)groupID;
-(ControllerClientStatus)deleteLampGroupWithID: (NSString *)groupID;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID toState: (LSFLampState *)state;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID toState: (LSFLampState *)state withTransitionPeriod: (unsigned int)transitionPeriod;
-(ControllerClientStatus)pulseLampGroupID: (NSString *)groupID toLampState: (LSFLampState *)toState withPeriod: (unsigned int)period duration: (unsigned int)duration andNumPulses: (unsigned int)numPulses;
-(ControllerClientStatus)pulseLampGroupID: (NSString *)groupID toLampState: (LSFLampState *)toState withPeriod: (unsigned int)period duration: (unsigned int)duration numPulses: (unsigned int)numPulses fromLampState: (LSFLampState *)fromState;
-(ControllerClientStatus)pulseLampGroupID: (NSString *)groupID toPreset: (NSString *)toPresetID withPeriod: (unsigned int)period duration: (unsigned int)duration andNumPulses: (unsigned int)numPulses;
-(ControllerClientStatus)pulseLampGroupID: (NSString *)groupID toPreset: (NSString *)toPresetID withPeriod: (unsigned int)period duration: (unsigned int)duration andNumPulses: (unsigned int)numPulses fromPreset: (NSString *)fromPresetID;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID onOffField: (BOOL)onOff;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID hueField: (unsigned int)hue;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID hueField: (unsigned int)hue withTransitionPeriod: (unsigned int)transitionPeriod;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID saturationField: (unsigned int)saturation;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID saturationField: (unsigned int)saturation withTransitionPeriod: (unsigned int)transitionPeriod;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID brightnessField: (unsigned int)brightness;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID brightnessField: (unsigned int)brightness withTransitionPeriod: (unsigned int)transitionPeriod;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID colorTempField: (unsigned int)colorTemp;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID colorTempField: (unsigned int)colorTemp withTransitionPeriod: (unsigned int)transitionPeriod;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID toPreset: (NSString *)presetID;
-(ControllerClientStatus)transitionLampGroupID: (NSString *)groupID toPreset: (NSString *)presetID withTransitionPeriod: (unsigned int)transitionPeriod;
-(ControllerClientStatus)resetLampGroupStateForID: (NSString *)groupID;
-(ControllerClientStatus)resetLampGroupStateOnOffFieldForID: (NSString *)groupID;
-(ControllerClientStatus)resetLampGroupStateHueFieldForID: (NSString *)groupID;
-(ControllerClientStatus)resetLampGroupStateSaturationFieldForID: (NSString *)groupID;
-(ControllerClientStatus)resetLampGroupStateBrightnessFieldForID: (NSString *)groupID;
-(ControllerClientStatus)resetLampGroupStateColorTempFieldForID: (NSString *)groupID;
-(ControllerClientStatus)getLampGroupDataSetForID: (NSString *)groupID;
-(ControllerClientStatus)getLampGroupDataSetForID: (NSString *)groupID andLanguage: (NSString *)language;
-(ControllerClientStatus)setLampGroupEffectForID: (NSString *)groupID andEffectID: (NSString *)effectID;

@end
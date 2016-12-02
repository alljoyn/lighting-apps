/******************************************************************************
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 ******************************************************************************/

#import <Foundation/Foundation.h>
#import <internal/LSFLampState.h>
#import <internal/LSFLampGroup.h>
#import <internal/LSFTransitionEffectV2.h>
#import <internal/LSFPulseEffectV2.h>
#import <internal/LSFSceneElement.h>
#import <internal/LSFMasterScene.h>
#import <internal/LSFSceneWithSceneElements.h>
#import "LSFSDKPreset.h"

@interface LSFSDKLightingItemUtil : NSObject

+(LSFLampState *)createLampStateFromPower: (BOOL)powerOn hue: (unsigned int)hue saturation: (unsigned int)saturation brightness: (unsigned int)brightness colorTemp: (unsigned int)colorTemp;
+(LSFLampGroup *)createLampGroupFromGroupMembers: (NSArray *)groupMembers;
+(LSFLampGroup *)createLampGroupFromLampIDs: (NSArray *)lampIDs groupIDs: (NSArray *)groupIDs;
+(LSFTransitionEffectV2 *)createTransitionEffectFromPower: (BOOL)powerOn hsvt: (NSArray *)hsvt duration: (unsigned int)duration;
+(LSFTransitionEffectV2 *)createTransitionEffectFromLampState: (LSFLampState *)lampState duration: (unsigned int)duration;
+(LSFTransitionEffectV2 *)createTransitionEffectFromPreset: (LSFSDKPreset *)preset duration: (unsigned int)duration;
+(LSFPulseEffectV2 *)createPulseEffectWithFromPowerOn: (BOOL)fromPowerOn fromColorHsvt: (NSArray *)fromColorHsvt toPowerOn: (BOOL)toPowerOn toColorHsvt: (NSArray *)toColorHsvt period: (unsigned int)period duration: (unsigned int)duration count: (unsigned int)count;
+(LSFPulseEffectV2 *)createPulseEffectFromLampState: (LSFLampState *)fromState toLampState: (LSFLampState *)toState period: (unsigned int)period duration: (unsigned int)duration count: (unsigned int)count;
+(LSFPulseEffectV2 *)createPulseeffectFromPreset: (LSFSDKPreset *)fromPreset toPreset: (LSFSDKPreset *)toPreset period: (unsigned int)period duration: (unsigned int)duration count: (unsigned int)count;
+(LSFSceneElement *)createSceneElementWithEffectID: (NSString *)effectID groupMembers: (NSArray *)members;
+(LSFSceneElement *)createSceneElementWithEffectID: (NSString *)effectID lampIDs: (NSArray *)lampIDs groupIDs: (NSArray *)groupIDs;
+(LSFMasterScene *)createMasterSceneFromSceneID: (NSArray *)sceneIDs;
+(LSFSceneWithSceneElements *)createSceneWithSceneElements: (NSArray *)sceneElementIDs;

@end
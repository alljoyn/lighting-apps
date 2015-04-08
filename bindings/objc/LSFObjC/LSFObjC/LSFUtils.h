/******************************************************************************
 *  *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import "LSFTypes.h"

@interface LSFUtils : NSObject

+(lsf::LSFStringList)convertNSArrayToStringList: (NSArray *)array;
+(NSArray *)convertStringListToNSArray: (lsf::LSFStringList)list;
+(lsf::TransitionLampsLampGroupsToStateList)convertNSArrayToStateTransitionEffects: (NSArray *)stateTransitionEffects;
+(lsf::TransitionLampsLampGroupsToPresetList)convertNSArrayToPresetTransitionEffects: (NSArray *)presetTransitionEffects;
+(lsf::PulseLampsLampGroupsWithStateList)convertNSArrayToStatePulseEffects: (NSArray *)statePulseEffects;
+(lsf::PulseLampsLampGroupsWithPresetList)convertNSArrayToPresetPulseEffects: (NSArray *)presetPulseEffects;
+(NSArray *)convertStateTransitionEffectsToNSArray: (lsf::TransitionLampsLampGroupsToStateList)stateTransitionEffects;
+(NSArray *)convertPresetTransitionEffectsToNSArray: (lsf::TransitionLampsLampGroupsToPresetList)presetTransitionEffects;
+(NSArray *)convertStatePulseEffectsToNSArray: (lsf::PulseLampsLampGroupsWithStateList)statePulseEffects;
+(NSArray *)convertPresetPulseEffectsToNSArray: (lsf::PulseLampsLampGroupsWithPresetList)presetPulseEffects;

@end
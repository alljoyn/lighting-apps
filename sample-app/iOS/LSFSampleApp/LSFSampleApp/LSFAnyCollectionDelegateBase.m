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

#import "LSFAnyCollectionDelegateBase.h"
#import <LSFSDKLightingItem.h>

@implementation LSFAnyCollectionDelegateBase

-(void)onAnyInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andLightingItem: (id)item
{
    //Intentionally left blank
}

-(void)onAnyChanged: (id)item
{
    //Intentionally left blank
}

-(void)onAnyRemoved: (id)item
{
    //Intentionally left blank
}

-(void)onAnyError: (LSFSDKLightingItemErrorEvent *)error
{
    //Intentionally left blank
}

-(void)onLampInitialized: (LSFSDKLamp *)lamp
{
    [self onAnyInitializedWithTrackingID: nil andLightingItem: lamp];
}

-(void)onLampChanged: (LSFSDKLamp *)lamp
{
    [self onAnyChanged: lamp];
}

-(void)onLampRemoved: (LSFSDKLamp *)lamp
{
    [self onAnyRemoved: lamp];
}

-(void)onLampError: (LSFSDKLightingItemErrorEvent *)error
{
    [self onAnyError: error];
}

-(void)onGroupInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andGroup: (LSFSDKGroup *)group
{
    [self onAnyInitializedWithTrackingID: trackingID andLightingItem: group];
}

-(void)onGroupChanged: (LSFSDKGroup *)group
{
    [self onAnyChanged: group];
}

-(void)onGroupRemoved: (LSFSDKGroup *)group
{
    [self onAnyRemoved: group];
}

-(void)onGroupError: (LSFSDKLightingItemErrorEvent *)error
{
    [self onAnyError: error];
}

-(void)onPresetInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andPreset: (LSFSDKPreset *)preset
{
    [self onAnyInitializedWithTrackingID: trackingID andLightingItem: preset];
}

-(void)onPresetChanged: (LSFSDKPreset *)preset
{
    [self onAnyChanged: preset];
}

-(void)onPresetRemoved: (LSFSDKPreset *)preset
{
    [self onAnyRemoved: preset];
}

-(void)onPresetError: (LSFSDKLightingItemErrorEvent *)error
{
    [self onAnyError: error];
}

-(void)onTransitionEffectInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andTransitionEffect: (LSFSDKTransitionEffect *)transitionEffect;
{
    [self onAnyInitializedWithTrackingID: trackingID andLightingItem: transitionEffect];
}

-(void)onTransitionEffectChanged: (LSFSDKTransitionEffect *)transitionEffect
{
    [self onAnyChanged: transitionEffect];
}

-(void)onTransitionEffectRemoved: (LSFSDKTransitionEffect *)transitionEffect
{
    [self onAnyRemoved: transitionEffect];
}

-(void)onTransitionEffectError: (LSFSDKLightingItemErrorEvent *)error
{
    [self onAnyError: error];
}

-(void)onPulseEffectInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andPulseEffect: (LSFSDKPulseEffect *)pulseEffect;
{
    [self onAnyInitializedWithTrackingID: trackingID andLightingItem: pulseEffect];
}

-(void)onPulseEffectChanged: (LSFSDKPulseEffect *)pulseEffect
{
    [self onAnyChanged: pulseEffect];
}

-(void)onPulseEffectRemoved: (LSFSDKPulseEffect *)pulseEffect
{
    [self onAnyRemoved: pulseEffect];
}

-(void)onPulseEffectError: (LSFSDKLightingItemErrorEvent *)error
{
    [self onAnyError: error];
}

-(void)onSceneElementInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andSceneElement:(LSFSDKSceneElement *)sceneElement
{
    [self onAnyInitializedWithTrackingID: trackingID andLightingItem: sceneElement];
}

-(void)onSceneElementChanged: (LSFSDKSceneElement *)sceneElement
{
    [self onAnyChanged: sceneElement];
}

-(void)onSceneElementRemoved: (LSFSDKSceneElement *)sceneElement
{
    [self onAnyRemoved: sceneElement];
}

-(void)onSceneElementError: (LSFSDKLightingItemErrorEvent *)error
{
    [self onAnyError: error];
}

-(void)onSceneInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andScene: (LSFSDKScene *)scene
{
    [self onAnyInitializedWithTrackingID: trackingID andLightingItem: scene];
}

-(void)onSceneChanged: (LSFSDKScene *)scene
{
    [self onAnyChanged: scene];
}

-(void)onSceneRemoved: (LSFSDKScene *)scene
{
    [self onAnyRemoved: scene];
}

-(void)onSceneError: (LSFSDKLightingItemErrorEvent *)error
{
    [self onAnyError: error];
}

-(void)onMasterSceneInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andMasterScene: (LSFSDKMasterScene *)masterScene
{
    [self onAnyInitializedWithTrackingID: trackingID andLightingItem: masterScene];
}

-(void)onMasterSceneChanged: (LSFSDKMasterScene *)masterScene
{
    [self onAnyChanged: masterScene];
}

-(void)onMasterSceneRemoved: (LSFSDKMasterScene *)masterScene
{
    [self onAnyRemoved: masterScene];
}

-(void)onMasterSceneError: (LSFSDKLightingItemErrorEvent *)error
{
    [self onAnyError: error];
}

@end
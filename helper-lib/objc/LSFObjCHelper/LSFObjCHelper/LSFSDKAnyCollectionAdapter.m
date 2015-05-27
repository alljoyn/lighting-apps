/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
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

#import "LSFSDKAnyCollectionAdapter.h"
#import "LSFSDKLightingItem.h"

@implementation LSFSDKAnyCollectionAdapter

-(void)onAnyInitializedWithTrackingID: (LSFTrackingID *)trackingID andLightingItem: (id)item
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

-(void)onGroupInitializedWithTrackingID: (LSFTrackingID *)trackingID andGroup: (LSFSDKGroup *)group
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

-(void)onPresetInitializedWithTrackingID: (LSFTrackingID *)trackingID andPreset: (LSFSDKPreset *)preset
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

-(void)onTransitionEffectInitializedWithTrackingID: (LSFTrackingID *)trackingID andTransitionEffect: (LSFSDKTransitionEffect *)transitionEffect;
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

-(void)onPulseEffectInitializedWithTrackingID: (LSFTrackingID *)trackingID andPulseEffect: (LSFSDKPulseEffect *)pulseEffect;
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

-(void)onSceneElementInitializedWithTrackingID: (LSFTrackingID *)trackingID andSceneElement:(LSFSDKSceneElement *)sceneElement
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

-(void)onSceneInitializedWithTrackingID: (LSFTrackingID *)trackingID andScene: (LSFSDKScene *)scene
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

-(void)onMasterSceneInitializedWithTrackingID: (LSFTrackingID *)trackingID andMasterScene: (LSFSDKMasterScene *)masterScene
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

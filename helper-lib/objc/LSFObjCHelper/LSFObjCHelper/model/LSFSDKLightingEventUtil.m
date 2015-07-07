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

#import "LSFSDKLightingEventUtil.h"
#import "LSFSDKAnyCollectionAdapter.h"
#import "LSFSDKLightingDirector.h"
#import "LSFSDKTrackingIDDelegate.h"

/*
 * Private Classes
 */
@interface MyTrackingIDDelegate : NSObject <LSFSDKTrackingIDDelegate>

@property (nonatomic, strong) id<LSFSDKLightingDelegate> lightingDelegate;
@property (nonatomic) LightingObjectType lightingObjectType;

-(id)initWithLightingItemDelegate: (id<LSFSDKLightingDelegate>)delegate lightingObjectType: (LightingObjectType)lot;

@end

@implementation MyTrackingIDDelegate

@synthesize lightingDelegate = _lightingDelegate;
@synthesize lightingObjectType = _lightingObjectType;

-(id)initWithLightingItemDelegate: (id<LSFSDKLightingDelegate>)delegate lightingObjectType: (LightingObjectType)lot
{
    self = [super init];

    if (self)
    {
        self.lightingDelegate = delegate;
        self.lightingObjectType = lot;
    }

    return self;
}

-(void)dealloc
{
    self.lightingDelegate = nil;
}

-(void)onTrackingIDReceived: (LSFSDKTrackingID *)trackingID lightingItem: (LSFSDKLightingItem *)item
{
    if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKGroupDelegate)] && [item isKindOfClass: [LSFSDKGroup class]])
    {
        id<LSFSDKGroupDelegate> groupDelegate = (id<LSFSDKGroupDelegate>)self.lightingDelegate;
        [groupDelegate onGroupInitializedWithTrackingID: trackingID andGroup: (LSFSDKGroup *)item];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKPresetDelegate)] && [item isKindOfClass: [LSFSDKPreset class]])
    {
        id<LSFSDKPresetDelegate> presetDelegate = (id<LSFSDKPresetDelegate>)self.lightingDelegate;
        [presetDelegate onPresetInitializedWithTrackingID: trackingID andPreset: (LSFSDKPreset *)item];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKTransitionEffectDelegate)] && [item isKindOfClass: [LSFSDKTransitionEffect class]])
    {
        id<LSFSDKTransitionEffectDelegate> transitionEffectDelegate = (id<LSFSDKTransitionEffectDelegate>)self.lightingDelegate;
        [transitionEffectDelegate onTransitionEffectInitializedWithTrackingID: trackingID andTransitionEffect: (LSFSDKTransitionEffect *)item];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKPulseEffectDelegate)] && [item isKindOfClass: [LSFSDKPulseEffect class]])
    {
        id<LSFSDKPulseEffectDelegate> pulseEffectDelegate = (id<LSFSDKPulseEffectDelegate>)self.lightingDelegate;
        [pulseEffectDelegate onPulseEffectInitializedWithTrackingID: trackingID andPulseEffect: (LSFSDKPulseEffect *)item];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKSceneElementDelegate)] && [item isKindOfClass: [LSFSDKSceneElement class]])
    {
        id<LSFSDKSceneElementDelegate> sceneElementDelegate = (id<LSFSDKSceneElementDelegate>)self.lightingDelegate;
        [sceneElementDelegate onSceneElementInitializedWithTrackingID: trackingID andSceneElement: (LSFSDKSceneElement *)item];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKSceneDelegate)] && [item isKindOfClass: [LSFSDKScene class]])
    {
        id<LSFSDKSceneDelegate> sceneDelegate = (id<LSFSDKSceneDelegate>)self.lightingDelegate;
        [sceneDelegate onSceneInitializedWithTrackingID: trackingID andScene: (LSFSDKScene *)item];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKMasterSceneDelegate)] && [item isKindOfClass: [LSFSDKMasterScene class]])
    {
        id<LSFSDKMasterSceneDelegate> masterSceneDelegate = (id<LSFSDKMasterSceneDelegate>)self.lightingDelegate;
        [masterSceneDelegate onMasterSceneInitializedWithTrackingID: trackingID andMasterScene: (LSFSDKMasterScene *)item];
    }
}

-(void)onTrackingIDError: (LSFSDKLightingItemErrorEvent *)error
{
    if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKGroupDelegate)] && self.lightingObjectType == GROUP)
    {
        id<LSFSDKGroupDelegate> groupDelegate = (id<LSFSDKGroupDelegate>)self.lightingDelegate;
        [groupDelegate onGroupError: error];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKPresetDelegate)] && self.lightingObjectType == PRESET)
    {
        id<LSFSDKPresetDelegate> presetDelegate = (id<LSFSDKPresetDelegate>)self.lightingDelegate;
        [presetDelegate onPresetError: error];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKTransitionEffectDelegate)] && self.lightingObjectType == TRANSITION_EFFECT)
    {
        id<LSFSDKTransitionEffectDelegate> transitionEffectDelegate = (id<LSFSDKTransitionEffectDelegate>)self.lightingDelegate;
        [transitionEffectDelegate onTransitionEffectError: error];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKPulseEffectDelegate)] && self.lightingObjectType == PULSE_EFFECT)
    {
        id<LSFSDKPulseEffectDelegate> pulseEffectDelegate = (id<LSFSDKPulseEffectDelegate>)self.lightingDelegate;
        [pulseEffectDelegate onPulseEffectError: error];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKSceneElementDelegate)] && self.lightingObjectType == SCENE_ELEMENT)
    {
        id<LSFSDKSceneElementDelegate> sceneElementDelegate = (id<LSFSDKSceneElementDelegate>)self.lightingDelegate;
        [sceneElementDelegate onSceneElementError: error];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKSceneDelegate)] && self.lightingObjectType == SCENE)
    {
        id<LSFSDKSceneDelegate> sceneDelegate = (id<LSFSDKSceneDelegate>)self.lightingDelegate;
        [sceneDelegate onSceneError: error];
    }
    else if ([self.lightingDelegate conformsToProtocol: @protocol(LSFSDKMasterSceneDelegate)] && self.lightingObjectType == MASTER_SCENE)
    {
        id<LSFSDKMasterSceneDelegate> masterSceneDelegate = (id<LSFSDKMasterSceneDelegate>)self.lightingDelegate;
        [masterSceneDelegate onMasterSceneError: error];
    }
}

@end

@interface MyAnyCollectionAdapter : LSFSDKAnyCollectionAdapter

@property (nonatomic, strong) LSFSDKTrackingID *myTrackingID;
@property (nonatomic, strong) id<LSFSDKTrackingIDDelegate> trackingIDDelegate;

-(id)initWithTrackingID: (LSFSDKTrackingID *)tid trackingIDDelegate: (id<LSFSDKTrackingIDDelegate>)delegate;

@end

@implementation MyAnyCollectionAdapter

@synthesize myTrackingID = _myTrackingID;
@synthesize trackingIDDelegate = _trackingIDDelegate;

-(id)initWithTrackingID: (LSFSDKTrackingID *)tid trackingIDDelegate: (id<LSFSDKTrackingIDDelegate>)delegate
{
    self = [super init];

    if (self)
    {
        self.myTrackingID = tid;
        self.trackingIDDelegate = delegate;
    }

    return self;
}

-(void)dealloc
{
    self.myTrackingID = nil;
    self.trackingIDDelegate = nil;
}

-(void)onAnyInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andLightingItem: (id)item
{
    if (trackingID != nil && trackingID.value == self.myTrackingID.value)
    {
        [[LSFSDKLightingDirector getLightingDirector] removeDelegate: self];
        [self.trackingIDDelegate onTrackingIDReceived: trackingID lightingItem: item];
    }
}

-(void)onAnyError: (LSFSDKLightingItemErrorEvent *)error
{
    if (error.trackingID != nil && error.trackingID.value == self.myTrackingID.value)
    {
        [[LSFSDKLightingDirector getLightingDirector] removeDelegate: self];
        [self.trackingIDDelegate onTrackingIDError: error];
    }
}

@end //End Private Classes

@implementation LSFSDKLightingEventUtil

+(void)listenForTrackingID: (LSFSDKTrackingID *)trackingID lightingDelegate: (id<LSFSDKLightingDelegate>)delegate objectType: (LightingObjectType)lightingObjectType
{
    MyTrackingIDDelegate *myTrackingIDDelegate = [[MyTrackingIDDelegate alloc] initWithLightingItemDelegate: delegate lightingObjectType: lightingObjectType];
    MyAnyCollectionAdapter *anyCollectionAdapter = [[MyAnyCollectionAdapter alloc] initWithTrackingID: trackingID trackingIDDelegate: myTrackingIDDelegate];
    [[LSFSDKLightingDirector getLightingDirector] addDelegate: anyCollectionAdapter];
}

@end

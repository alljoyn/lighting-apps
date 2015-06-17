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

#import "LSFSDKLightingDirector.h"
#import "LSFSDKLampCollectionManager.h"
#import "LSFSDKPresetCollectionManager.h"
#import "LSFSDKGroupCollectionManager.h"
#import "LSFSDKTransitionEffectCollectionManager.h"
#import "LSFSDKPulseEffectCollectionManager.h"
#import "LSFSDKSceneElementCollectionManager.h"
#import "LSFSDKSceneCollectionManager.h"
#import "LSFSDKSceneCollectionManagerV2.h"
#import "LSFSDKMasterSceneCollectionManager.h"
#import "LSFSDKAllJoynManager.h"
#import "LSFSDKLightingItemUtil.h"
#import "LSFSDKLightingItemInitializedFilter.h"
#import "LSFSDKTrackingIDDelegate.h"
#import "LSFSDKLightingEventUtil.h"
#import "Init.h"

static NSString *LANGUAGE_DEFAULT = @"en";

@interface LSFSDKLightingDirector()

-(LSFSDKLampCollectionManager *)getLampCollectionManager;
-(LSFSDKPresetCollectionManager *)getPresetCollectionManager;
-(LSFSDKGroupCollectionManager *)getGroupCollectionManager;
-(LSFSDKTransitionEffectCollectionManager *)getTransitionEffectCollectionManager;
-(LSFSDKPulseEffectCollectionManager *)getPulseEffectCollectionManager;
-(LSFSDKSceneElementCollectionManager *)getSceneElementCollectionManager;
-(LSFSDKSceneCollectionManager *)getSceneCollectionManager;
-(LSFSDKSceneCollectionManagerV2 *)getSceneCollectionManagerV2;
-(LSFSDKMasterSceneCollectionManager *)getMasterSceneCollectionManager;
-(LSFControllerManager *)getControllerManager;

@end

@implementation LSFSDKLightingDirector

@synthesize version = _version;
@synthesize busAttachment = _busAttachment;
@synthesize lamps = _lamps;
@synthesize initializedLamps = _initializedLamps;
@synthesize groups = _groups;
@synthesize initializedGroups = _initializedGroups;
@synthesize presets = _presets;
@synthesize initializedPresets = _initializedPresets;
@synthesize transitionEffects = _transitionEffects;
@synthesize initializedTransitionEffects = _initializedTransitionEffects;
@synthesize pulseEffects = _pulseEffects;
@synthesize initializedPulseEffects = _initializedPulseEffects;
@synthesize sceneElements = _sceneElements;
@synthesize initializedSceneElements = _initializedSceneElements;
@synthesize scenes = _scenes;
@synthesize initializedScenes = _initializedScenes;
@synthesize masterScenes = _masterScenes;
@synthesize initializedMasterScenes = _initializedMasterScenes;
@synthesize defaultLanguage = _defaultLanguage;
@synthesize lightingManager = _lightingManager;

+(LSFSDKLightingDirector *)getLightingDirector
{
    static LSFSDKLightingDirector *lightingDirector = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        AllJoynInit();
        AllJoynRouterInit();
        lightingDirector = [[self alloc] init];
    });

    return lightingDirector;
}

-(id)init
{
    self = [super init];

    if (self)
    {
        NSLog(@"LSFSDKLightingDirector - init(). Static Library Slice Used = %@", ARCH_STR);

        _lightingManager = [[LSFSDKLightingSystemManager alloc] init];
        _defaultLanguage = LANGUAGE_DEFAULT;
    }

    return self;
}

-(unsigned int)version
{
    return 2;
}

-(void)start
{
    [self startWithApplicationName: @"LightingDirector"];
}

-(void)startWithApplicationName: (NSString *)applicationName
{
    [self startWithApplicationName: applicationName dispatchQueue: nil];
}

-(void)startWithBusAttachment: (ajn::BusAttachment *)busAttachment
{
    [self startWithBusAttachment: busAttachment dispatchQueue: nil];
}

-(void)startWithApplicationName: (NSString *)applicationName dispatchQueue: (dispatch_queue_t)queue
{
    [self.lightingManager initializeWithApplicationName: applicationName dispatchQueue: queue andAllJoynDelegate: nil];
    [self.lightingManager start];
}

-(void)startWithBusAttachment: (ajn::BusAttachment *)busAttachment dispatchQueue: (dispatch_queue_t)queue
{
    [self.lightingManager initializeWithBusAttachment: busAttachment dispatchQueue: queue andAllJoynDelegate: nil];
    [self.lightingManager start];
}

-(void)stop
{
    [self.lightingManager stop];
}

-(ajn::BusAttachment *)busAttachment
{
    return [LSFSDKAllJoynManager getBusAttachment];
}

-(NSArray *)lamps
{
    return [[self getLampCollectionManager] getLamps];
}

-(NSArray *)initializedLamps
{
    return [[self getLampCollectionManager] getLampsWithFilter: [[LSFSDKLightingItemInitializedFilter alloc] init]];
}

-(LSFSDKLamp *)getLampWithID: (NSString *)lampID
{
    return [[self getLampCollectionManager] getLampWithID: lampID];
}

-(NSArray *)groups
{
    return [[self getGroupCollectionManager] getGroups];
}

-(NSArray *)initializedGroups
{
    return [[self getGroupCollectionManager] getGroupsWithFilter: [[LSFSDKLightingItemInitializedFilter alloc] init]];
}

-(LSFSDKGroup *)getGroupWithID: (NSString *)groupID
{
    return [[self getGroupCollectionManager] getGroupWithID: groupID];
}

-(NSArray *)presets
{
    return [[self getPresetCollectionManager] getPresets];
}

-(NSArray *)initializedPresets
{
    return [[self getPresetCollectionManager] getPresetsWithFilter: [[LSFSDKLightingItemInitializedFilter alloc] init]];
}

-(LSFSDKPreset *)getPresetWithID: (NSString *)presetID
{
    return [[self getPresetCollectionManager] getPresetWithID: presetID];
}

-(NSArray *)transitionEffects
{
    return [[self getTransitionEffectCollectionManager] getTransitionEffects];
}

-(NSArray *)initializedTransitionEffects
{
    return [[self getTransitionEffectCollectionManager] getTransitionEffectsWithFilter: [[LSFSDKLightingItemInitializedFilter alloc] init]];
}

-(LSFSDKTransitionEffect *)getTransitionEffectWithID: (NSString *)transitionEffectID
{
    return [[self getTransitionEffectCollectionManager] getTransitionEffectWithID: transitionEffectID];
}

-(NSArray *)pulseEffects
{
    return [[self getPulseEffectCollectionManager] getPulseEffects];
}

-(NSArray *)initializedPulseEffects
{
    return [[self getPulseEffectCollectionManager] getPulseEffectsWithFilter: [[LSFSDKLightingItemInitializedFilter alloc] init]];
}

-(LSFSDKPulseEffect *)getPulseEffectWithID: (NSString *)pulseEffectID
{
    return [[self getPulseEffectCollectionManager] getPulseEffectWithID: pulseEffectID];
}

-(NSArray *)sceneElements
{
    return [[self getSceneElementCollectionManager] getSceneElements];
}

-(NSArray *)initializedSceneElements
{
    return [[self getSceneElementCollectionManager] getSceneElementsWithFilter: [[LSFSDKLightingItemInitializedFilter alloc] init]];
}

-(LSFSDKSceneElement *)getSceneElementWithID: (NSString *)sceneElementID
{
    return [[self getSceneElementCollectionManager] getSceneElementWithID: sceneElementID];
}

-(NSArray *)scenes
{
    return [[self getSceneCollectionManagerV2] getScenes];
}

-(NSArray *)initializedScenes
{
    return [[self getSceneCollectionManagerV2] getScenesWithFilter: [[LSFSDKLightingItemInitializedFilter alloc] init]];
}

-(LSFSDKScene *)getSceneWithID: (NSString *)sceneID
{
    return [[self getSceneCollectionManagerV2] getSceneWithID: sceneID];
}

-(NSArray *)masterScenes
{
    return [[self getMasterSceneCollectionManager] getMasterScenes];
}

-(NSArray *)initializedMasterScenes
{
    return [[self getMasterSceneCollectionManager] getMasterScenesWithFilter: [[LSFSDKLightingItemInitializedFilter alloc] init]];
}

-(LSFSDKMasterScene *)getMasterSceneWithID: (NSString *)masterSceneID
{
    return [[self getMasterSceneCollectionManager] getMasterSceneWithID: masterSceneID];
}

-(LSFTrackingID *)createGroupWithMembers: (NSArray *)members groupName: (NSString *)groupName delegate: (id<LSFSDKGroupDelegate>)delegate
{
    LSFTrackingID *trackingID = [[LSFTrackingID alloc] init];
    uint32_t tid = 0;

    if (delegate)
    {
        [LSFSDKLightingEventUtil listenForTrackingID: trackingID lightingDelegate: delegate objectType: GROUP];
    }

    [[LSFSDKAllJoynManager getGroupManager] createLampGroupWithTracking: &tid lampGroup: [LSFSDKLightingItemUtil createLampGroupFromGroupMembers: members] withName: groupName];
    trackingID.value = tid;

    return trackingID;
}

-(LSFTrackingID *)createPresetWithPower: (Power)power color: (LSFSDKColor *)color presetName: (NSString *)presetName delegate: (id<LSFSDKPresetDelegate>)delegate
{
    LSFTrackingID *trackingID = [[LSFTrackingID alloc] init];
    uint32_t tid = 0;

    if (delegate)
    {
        [LSFSDKLightingEventUtil listenForTrackingID: trackingID lightingDelegate: delegate objectType: PRESET];
    }

    [[LSFSDKAllJoynManager getPresetManager] createPresetWithTracking: &tid state: [LSFSDKLightingItemUtil createLampStateFromPower: (power ? ON : OFF) hue: color.hue saturation: color.saturation brightness: color.brightness colorTemp: color.colorTemp] andPresetName: presetName];
    trackingID.value = tid;

    return trackingID;
}

-(LSFTrackingID *)createTransitionEffectWithLampState: (id<LSFSDKLampState>)state duration: (unsigned int)duration name: (NSString *)effectName delegate: (id<LSFSDKTransitionEffectDelegate>)delegate
{
    LSFTrackingID *trackingID = [[LSFTrackingID alloc] init];
    uint32_t tid = 0;

    if (delegate)
    {
        [LSFSDKLightingEventUtil listenForTrackingID: trackingID lightingDelegate: delegate objectType: TRANSITION_EFFECT];
    }

    if ([state isKindOfClass: [LSFSDKPreset class]])
    {
        [[LSFSDKAllJoynManager getTransitionEffectManager] createTransitionEffectWithTracking: &tid transitionEffect: [LSFSDKLightingItemUtil createTransitionEffectFromPreset: (LSFSDKPreset *)state duration: duration] andTransitionEffectName: effectName];
    }
    else
    {
        [[LSFSDKAllJoynManager getTransitionEffectManager] createTransitionEffectWithTracking: &tid transitionEffect: [LSFSDKLightingItemUtil createTransitionEffectFromPower: [state getPowerOn] hsvt: [state getColorHsvt] duration: duration] andTransitionEffectName: effectName];
    }

    trackingID.value = tid;
    return trackingID;
}

-(LSFTrackingID *)createPulseEffectWithFromState: (id<LSFSDKLampState>)fromState toState: (id<LSFSDKLampState>)toState period: (unsigned int)period duration: (unsigned int)duration count: (unsigned int)count name: (NSString *)effectName delegate: (id<LSFSDKPulseEffectDelegate>)delegate
{
    LSFTrackingID *trackingID = [[LSFTrackingID alloc] init];
    uint32_t tid = 0;

    if (delegate)
    {
        [LSFSDKLightingEventUtil listenForTrackingID: trackingID lightingDelegate: delegate objectType: PULSE_EFFECT];
    }

    if (([fromState isKindOfClass: [LSFSDKPreset class]]) && ([toState isKindOfClass: [LSFSDKPreset class]]))
    {
        [[LSFSDKAllJoynManager getPulseEffectManager] createPulseEffectWithTracking: &tid pulseEffect: [LSFSDKLightingItemUtil createPulseeffectFromPreset: (LSFSDKPreset *)fromState toPreset: (LSFSDKPreset *)toState period: period duration: duration count: count] andPulseEffectName: effectName];
    }
    else
    {
        [[LSFSDKAllJoynManager getPulseEffectManager] createPulseEffectWithTracking: &tid pulseEffect: [LSFSDKLightingItemUtil createPulseEffectWithFromPowerOn: [fromState getPowerOn] fromColorHsvt: [fromState getColorHsvt] toPowerOn: [toState getPowerOn] toColorHsvt: [toState getColorHsvt] period: period duration: duration count: count] andPulseEffectName:effectName];
    }

    trackingID.value = tid;
    return trackingID;
}

-(LSFTrackingID *)createSceneElementWithEffect: (id<LSFSDKEffect>)effect groupMembers: (NSArray *)members name: (NSString *)sceneElementName delegate: (id<LSFSDKSceneElementDelegate>)delegate
{
    LSFTrackingID *trackingID = [[LSFTrackingID alloc] init];
    uint32_t tid = 0;

    if (delegate)
    {
        [LSFSDKLightingEventUtil listenForTrackingID: trackingID lightingDelegate: delegate objectType: SCENE_ELEMENT];
    }

    [[LSFSDKAllJoynManager getSceneElementManager] createSceneElementWithTracking: &tid sceneElement: [LSFSDKLightingItemUtil createSceneElementWithEffectID: [effect theID] groupMembers: members] andSceneElementName:sceneElementName];

    trackingID.value = tid;
    return trackingID;
}

-(LSFTrackingID *)createSceneWithSceneElements: (NSArray *)sceneElements name: (NSString *)sceneName delegate: (id<LSFSDKSceneDelegate>)delegate
{
    LSFTrackingID *trackingID = [[LSFTrackingID alloc] init];
    uint32_t tid = 0;

    if (delegate)
    {
        [LSFSDKLightingEventUtil listenForTrackingID: trackingID lightingDelegate: delegate objectType: SCENE];
    }

    NSMutableArray *sceneElementIDs = [[NSMutableArray alloc] initWithCapacity: [sceneElements count]];

    for (LSFSDKSceneElement *sceneElement in sceneElements)
    {
        [sceneElementIDs addObject: [sceneElement theID]];
    }

    [[LSFSDKAllJoynManager getSceneManager] createSceneWithSceneElementsWithTracking: &tid sceneWithSceneElements: [LSFSDKLightingItemUtil createSceneWithSceneElements: sceneElementIDs] andSceneName: sceneName];

    trackingID.value = tid;
    return trackingID;
}

-(LSFTrackingID *)createMasterSceneWithScenes: (NSArray *)scenes name: (NSString *)masterSceneName delegate: (id<LSFSDKMasterSceneDelegate>)delegate
{
    LSFTrackingID *trackingID = [[LSFTrackingID alloc] init];
    uint32_t tid = 0;

    if (delegate)
    {
        [LSFSDKLightingEventUtil listenForTrackingID: trackingID lightingDelegate: delegate objectType: MASTER_SCENE];
    }

    NSMutableArray *sceneIDs = [[NSMutableArray alloc] initWithCapacity: [scenes count]];

    for (LSFSDKScene *scene in scenes)
    {
        [sceneIDs addObject: [scene theID]];
    }

    [[LSFSDKAllJoynManager getMasterSceneManager] createMasterSceneWithTracking: &tid masterScene: [LSFSDKLightingItemUtil createMasterSceneFromSceneID: sceneIDs] withName: masterSceneName];

    trackingID.value = tid;
    return trackingID;
}

-(void)postOnNextControllerConnectionWithDelay: (unsigned int)delay delegate: (id<LSFSDKNextControllerConnectionDelegate>)delegate;
{
    [self.lightingManager postOnNextControllerConnection: delegate withDelay: delay];
}

-(void)postOnNextControllerConnectionWithDelay: (unsigned int)delay block: (void (^)(void))block;
{
    //TODO - Implement
}

-(void)addDelegate: (id<LSFSDKLightingDelegate>)delegate
{
    if ([delegate conformsToProtocol: @protocol(LSFSDKLampDelegate)])
    {
        [self addLampDelegate: (id<LSFSDKLampDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKGroupDelegate)])
    {
        [self addGroupDelegate: (id<LSFSDKGroupDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKPresetDelegate)])
    {
        [self addPresetDelegate: (id<LSFSDKPresetDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKTransitionEffectDelegate)])
    {
        [self addTransitionEffectDelegate: (id<LSFSDKTransitionEffectDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKPulseEffectDelegate)])
    {
        [self addPulseEffectDelegate: (id<LSFSDKPulseEffectDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKSceneElementDelegate)])
    {
        [self addSceneElementDelegate: (id<LSFSDKSceneElementDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKSceneDelegate)])
    {
        [self addSceneDelegate: (id<LSFSDKSceneDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKMasterSceneDelegate)])
    {
        [self addMasterSceneDelegate: (id<LSFSDKMasterSceneDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKControllerDelegate)])
    {
        [self addControllerDelegate: (id<LSFSDKControllerDelegate>)delegate];
    }
}

-(void)addLampDelegate: (id<LSFSDKLampDelegate>)delegate
{
    [[self getLampCollectionManager] addLampDelegate: delegate];
}

-(void)addGroupDelegate: (id<LSFSDKGroupDelegate>)delegate
{
    [[self getGroupCollectionManager] addGroupDelegate: delegate];
}

-(void)addPresetDelegate: (id<LSFSDKPresetDelegate>)delegate
{
    [[self getPresetCollectionManager] addPresetDelegate: delegate];
}

-(void)addTransitionEffectDelegate: (id<LSFSDKTransitionEffectDelegate>)delegate
{
    [[self getTransitionEffectCollectionManager] addTransitionEffectDelegate: delegate];
}

-(void)addPulseEffectDelegate: (id<LSFSDKPulseEffectDelegate>)delegate
{
    [[self getPulseEffectCollectionManager] addPulseEffectDelegate: delegate];
}

-(void)addSceneElementDelegate: (id<LSFSDKSceneElementDelegate>)delegate
{
    [[self getSceneElementCollectionManager] addSceneElementDelegate: delegate];
}

-(void)addSceneDelegate: (id<LSFSDKSceneDelegate>)delegate
{
    [[self getSceneCollectionManagerV2] addSceneDelegate: delegate];
}

-(void)addMasterSceneDelegate: (id<LSFSDKMasterSceneDelegate>)delegate
{
    [[self getMasterSceneCollectionManager] addMasterSceneDelegate: delegate];
}

-(void)addControllerDelegate: (id<LSFSDKControllerDelegate>)delegate
{
    [[self getControllerManager] addDelegate: delegate];
}

-(void)removeDelegate: (id<LSFSDKLightingDelegate>)delegate
{
    if ([delegate conformsToProtocol: @protocol(LSFSDKLampDelegate)])
    {
        [self removeLampDelegate: (id<LSFSDKLampDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKGroupDelegate)])
    {
        [self removeGroupDelegate: (id<LSFSDKGroupDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKPresetDelegate)])
    {
        [self removePresetDelegate: (id<LSFSDKPresetDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKTransitionEffectDelegate)])
    {
        [self removeTransitionEffectDelegate: (id<LSFSDKTransitionEffectDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKPulseEffectDelegate)])
    {
        [self removePulseEffectDelegate: (id<LSFSDKPulseEffectDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKSceneElementDelegate)])
    {
        [self removeSceneElementDelegate: (id<LSFSDKSceneElementDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKSceneDelegate)])
    {
        [self removeSceneDelegate: (id<LSFSDKSceneDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKMasterSceneDelegate)])
    {
        [self removeMasterSceneDelegate: (id<LSFSDKMasterSceneDelegate>)delegate];
    }

    if ([delegate conformsToProtocol: @protocol(LSFSDKControllerDelegate)])
    {
        [self removeControllerDelegate: (id<LSFSDKControllerDelegate>)delegate];
    }
}

-(void)removeLampDelegate: (id<LSFSDKLampDelegate>)delegate
{
    [[self getLampCollectionManager] removeLampDelegate: delegate];
}

-(void)removeGroupDelegate: (id<LSFSDKGroupDelegate>)delegate
{
    [[self getGroupCollectionManager] removeGroupDelegate: delegate];
}

-(void)removePresetDelegate: (id<LSFSDKPresetDelegate>)delegate
{
    [[self getPresetCollectionManager] removePresetDelegate: delegate];
}

-(void)removeTransitionEffectDelegate: (id<LSFSDKTransitionEffectDelegate>)delegate
{
    [[self getTransitionEffectCollectionManager] removeDelegate: delegate];
}

-(void)removePulseEffectDelegate: (id<LSFSDKPulseEffectDelegate>)delegate
{
    [[self getPulseEffectCollectionManager] removePulseEffectDelegate: delegate];
}

-(void)removeSceneElementDelegate: (id<LSFSDKSceneElementDelegate>)delegate
{
    [[self getSceneElementCollectionManager] removeSceneElementDelegate: delegate];
}

-(void)removeSceneDelegate: (id<LSFSDKSceneDelegate>)delegate
{
    [[self getSceneCollectionManagerV2] removeSceneDelegate: delegate];
}

-(void)removeMasterSceneDelegate: (id<LSFSDKMasterSceneDelegate>)delegate
{
    [[self getMasterSceneCollectionManager] removeMasterSceneDelegate: delegate];
}

-(void)removeControllerDelegate: (id<LSFSDKControllerDelegate>)delegate
{
    [[self getControllerManager] removeDelegate: delegate];
}

-(void)setDefaultLanguage: (NSString *)defaultLanguage
{
    if (defaultLanguage != nil)
    {
        _defaultLanguage = defaultLanguage;
    }
}

-(NSString *)defaultLanguage
{
    return _defaultLanguage;
}

/*
 * Private Functions
 */
-(LSFSDKLampCollectionManager *)getLampCollectionManager
{
    return [self.lightingManager lampCollectionManager];
}

-(LSFSDKPresetCollectionManager *)getPresetCollectionManager
{
    return [self.lightingManager presetCollectionManager];
}

-(LSFSDKGroupCollectionManager *)getGroupCollectionManager
{
    return [self.lightingManager groupCollectionManager];
}

-(LSFSDKTransitionEffectCollectionManager *)getTransitionEffectCollectionManager
{
    return [self.lightingManager transitionEffectCollectionManager];
}

-(LSFSDKPulseEffectCollectionManager *)getPulseEffectCollectionManager
{
    return [self.lightingManager pulseEffectCollectionManager];
}

-(LSFSDKSceneElementCollectionManager *)getSceneElementCollectionManager
{
    return [self.lightingManager sceneElementCollectionManager];
}

-(LSFSDKSceneCollectionManager *)getSceneCollectionManager
{
    return [self.lightingManager sceneCollectionManagerV1];
}

-(LSFSDKSceneCollectionManagerV2 *)getSceneCollectionManagerV2
{
    return [self.lightingManager sceneCollectionManager];
}

-(LSFSDKMasterSceneCollectionManager *)getMasterSceneCollectionManager
{
    return [self.lightingManager masterSceneCollectionManager];
}

-(LSFControllerManager *)getControllerManager
{
    return [self.lightingManager controllerManager];
}

-(LSFSDKLightingSystemManager *)lightingManager
{
    return _lightingManager;
}

@end
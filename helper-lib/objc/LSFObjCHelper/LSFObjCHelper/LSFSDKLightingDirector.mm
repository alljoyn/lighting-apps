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
#import "LSFLightingSystemManager.h"
#import "LSFLampModelContainer.h"
#import "LSFGroupModelContainer.h"
#import "LSFSceneModelContainer.h"
#import "LSFAllJoynManager.h"

@interface LSFSDKLightingDirector()

@property (nonatomic, strong) LSFLightingSystemManager *lightingManager;

@end

@implementation LSFSDKLightingDirector

@synthesize version = _version;
@synthesize busAttachment = _busAttachment;
@synthesize lamps = _lamps;
@synthesize groups = _groups;
@synthesize presets = _presets;
@synthesize transitionEffects = _transitionEffects;
@synthesize pulseEffects = _pulseEffects;
@synthesize sceneElements = _sceneElements;
@synthesize scenes = _scenes;
@synthesize masterScenes = _masterScenes;
@synthesize defaultLanguage = _defaultLanguage;
@synthesize lightingManager = _lightingManager;

+(LSFSDKLightingDirector *)getLightingDirector
{
    static LSFSDKLightingDirector *lightingDirector = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        lightingDirector = [[self alloc] init];
    });

    return lightingDirector;
}

-(id)init
{
    self = [super init];

    if (self)
    {
        self.lightingManager = [LSFLightingSystemManager getLightingSystemManager];
        _version = 1;
    }

    return self;
}

-(void)start
{
    [self.lightingManager start];
}

-(void)startWithApplicationName: (NSString *)applicationName
{
    //TODO - Implement
}

-(void)startWithBusAttachment: (ajn::BusAttachment *)busAttachment
{
    //TODO - Implement
}

-(void)startWithApplicationName: (NSString *)applicationName dispatchQueue: (dispatch_queue_t)queue
{
    //TODO - Implement
}

-(void)startWithBusAttachment: (ajn::BusAttachment *)busAttachment dispatchQueue: (dispatch_queue_t)queue
{
    //TODO - Implement
}

-(void)stop
{
    [self.lightingManager stop];
}

-(NSArray *)lamps
{
    NSMutableDictionary *lamps = [[LSFLampModelContainer getLampModelContainer] lampContainer];
    return [lamps allValues];
}

-(NSArray *)completeLamps
{
    //TODO - Implement
    return nil;
}

-(LSFSDKLamp *)getLampWithID: (NSString *)lampID
{
    //TODO - Implement
    return nil;
}

-(NSArray *)groups
{
    NSMutableDictionary *groups = [[LSFGroupModelContainer getGroupModelContainer] groupContainer];
    return [groups allValues];
}

-(NSArray *)completeGroups
{
    //TODO - Implement
    return nil;
}

-(LSFSDKGroup *)getGroupWithID: (NSString *)groupID
{
    //TODO - Implement
    return nil;
}

-(NSArray *)presets
{
    //TODO - Implement
    return nil;
}

-(NSArray *)completePresets
{
    //TODO - Implement
    return nil;
}

-(LSFSDKPreset *)getPresetWithID: (NSString *)presetID
{
    //TODO - Implement
    return nil;
}

-(NSArray *)transitionEffects
{
    //TODO - Implement
    return nil;
}

-(NSArray *)completeTransitionEffects
{
    //TODO - Implement
    return nil;
}

-(LSFSDKTransitionEffect *)getTransitionEffectWithID: (NSString *)transitionEffectID
{
    //TODO - Implement
    return nil;
}

-(NSArray *)pulseEffects
{
    //TODO - Implement
    return nil;
}

-(NSArray *)completePulseEffects
{
    //TODO - Implement
    return nil;
}

-(LSFSDKPulseEffect *)getPulseEffectWithID: (NSString *)pulseEffectID
{
    //TODO - Implement
    return nil;
}

-(NSArray *)sceneElements
{
    //TODO - Implement
    return nil;
}

-(NSArray *)completeSceneElements
{
    //TODO - Implement
    return nil;
}

-(LSFSDKSceneElement *)getSceneElementWithID: (NSString *)sceneElementID
{
    //TODO - Implement
    return nil;
}

-(NSArray *)scenes
{
    NSMutableDictionary *scenes = [[LSFSceneModelContainer getSceneModelContainer] sceneContainer];
    return [scenes allValues];
}

-(NSArray *)completeScenes
{
    //TODO - Implement
    return nil;
}

-(LSFSDKScene *)getSceneWithID: (NSString *)sceneID
{
    //TODO - Implement
    return nil;
}

-(NSArray *)masterScenes
{
    //TODO - Implement
    return nil;
}

-(NSArray *)completeMasterScenes
{
    //TODO - Implement
    return nil;
}

-(LSFSDKMasterScene *)getMasterSceneWithID: (NSString *)masterSceneID
{
    //TODO - Implement
    return nil;
}

-(LSFSDKGroup *)createGroupSyncWithMembers: (NSArray *)members groupName: (NSString *)groupName
{
    //TODO - Implement
    return nil;
}

-(void)createGroupWithMembers: (NSArray *)members groupName: (NSString *)groupName delegate: (id<LSFSDKGroupDelegate>)delegate
{
    //TODO - Implement
}

-(LSFSDKPreset *)createPresetSyncWithPower: (Power)power color: (LSFSDKColor *)color presetName: (NSString *)presetName
{
    //TODO - Implement
    return nil;
}

-(void)createPresetWithPower: (Power)power color: (LSFSDKColor *)color presetName: (NSString *)presetName delegate: (id<LSFSDKPresetDelegate>)delegate
{
    //TODO - Implement
}

-(LSFSDKTransitionEffect *)createTransitionEffectSyncWithLampState: (id<LSFSDKLampState>)state duration: (unsigned long)duration name: (NSString *)effectName
{
    //TODO - Implement
    return nil;
}

-(void)createTransitionEffectWithLampState: (id<LSFSDKLampState>)state duration: (unsigned long)duration name: (NSString *)effectName delegate: (id<LSFSDKTransitionEffectDelegate>)delegate
{
    //TODO - Implement
}

-(LSFSDKPulseEffect *)createPulseEffectSyncWithFromState: (id<LSFSDKLampState>)fromState toState: (id<LSFSDKLampState>)toState period: (unsigned long)period duration: (unsigned long)duration count: (unsigned long)count name: (NSString *)effectName
{
    //TODO - Implement
    return nil;
}

-(void)createPulseEffectWithFromState: (id<LSFSDKLampState>)fromState toState: (id<LSFSDKLampState>)toState period: (unsigned long)period duration: (unsigned long)duration count: (unsigned long)count name: (NSString *)effectName delegate: (id<LSFSDKPulseEffectDelegate>)delegate
{
    //TODO - Implement
}

-(LSFSDKSceneElement *)createSceneElementSyncWithEffect: (id<LSFSDKEffect>)effect groupMembers: (NSArray *)members name: (NSString *)sceneElementName
{
    //TODO - Implement
    return nil;
}

-(void)createSceneElementWithEffect: (id<LSFSDKEffect>)effect groupMembers: (NSArray *)members name: (NSString *)sceneElementName delegate: (id<LSFSDKSceneElementDelegate>)delegate
{
    //TODO - Implement
}

-(LSFSDKScene *)createSceneSyncWithSceneElements: (NSArray *)sceneElements name: (NSString *)sceneName
{
    //TODO - Implement
    return nil;
}

-(void)createSceneWithSceneElements: (NSArray *)sceneElements name: (NSString *)sceneName delegate: (id<LSFSDKSceneDelegate>)delegate
{
    //TODO - Implement
}

-(LSFSDKMasterScene *)createMasterSceneSyncWithScenes: (NSArray *)scenes name: (NSString *)masterSceneName
{
    //TODO - Implement
    return nil;
}

-(void)createMasterSceneWithScenes: (NSArray *)scenes name: (NSString *)masterSceneName delegate: (id<LSFSDKMasterSceneDelegate>)delegate
{
    //TODO - Implement
}

-(void)postOnNextControllerConnectionWithDelay: (unsigned int)delay delegate: (id<LSFSDKNextControllerConnectionDelegate>)delegate;
{
    [self.lightingManager postOnNextControllerConnection: delegate];
}

-(void)postOnNextControllerConnectionWithDelay: (unsigned int)delay block: (void (^)(void))block;
{
    //TODO - Implement
}

-(void)waitForInitialSetCompletion
{
    //TODO - Implement
}

-(void)addDelegate: (id<LSFSDKLightingDelegate>)delegate
{
    //TODO - Implement
}

-(void)addLampDelegate: (id<LSFSDKLampDelegate>)delegate
{
    //TODO - Implement
}

-(void)addGroupDelegate: (id<LSFSDKGroupDelegate>)delegate
{
    //TODO - Implement
}

-(void)addPresetDelegate: (id<LSFSDKPresetDelegate>)delegate
{
    //TODO - Implement
}

-(void)addTransitionEffectDelegate: (id<LSFSDKTransitionEffectDelegate>)delegate
{
    //TODO - Implement
}

-(void)addPulseEffectDelegate: (id<LSFSDKPulseEffectDelegate>)delegate
{
    //TODO - Implement
}

-(void)addSceneElementDelegate: (id<LSFSDKSceneElementDelegate>)delegate
{
    //TODO - Implement
}

-(void)addSceneDelegate: (id<LSFSDKSceneDelegate>)delegate
{
    //TODO - Implement
}

-(void)addMasterSceneDelegate: (id<LSFSDKMasterSceneDelegate>)delegate
{
    //TODO - Implement
}

-(void)addControllerDelegate: (id<LSFSDKControllerDelegate>)delegate
{
    //TODO - Implement
}

-(void)addInitialSetDelegate: (id<LSFSDKInitialSetDelegate>)delegate
{
    //TODO - Implements
}

-(void)removeDelegate: (id<LSFSDKLightingDelegate>)delegate
{
    //TODO - Implement
}

-(void)removeLampDelegate: (id<LSFSDKLampDelegate>)delegate
{
    //TODO - Implement
}

-(void)removeGroupDelegate: (id<LSFSDKGroupDelegate>)delegate
{
    //TODO - Implement
}

-(void)removePresetDelegate: (id<LSFSDKPresetDelegate>)delegate
{
    //TODO - Implement
}

-(void)removeTransitionEffectDelegate: (id<LSFSDKTransitionEffectDelegate>)delegate
{
    //TODO - Implement
}

-(void)removePulseEffectDelegate: (id<LSFSDKPulseEffectDelegate>)delegate
{
    //TODO - Implement
}

-(void)removeSceneElementDelegate: (id<LSFSDKSceneElementDelegate>)delegate
{
    //TODO - Implement
}

-(void)removeSceneDelegate: (id<LSFSDKSceneDelegate>)delegate
{
    //TODO - Implement
}

-(void)removeMasterSceneDelegate: (id<LSFSDKMasterSceneDelegate>)delegate
{
    //TODO - Implement
}

-(void)removeControllerDelegate: (id<LSFSDKControllerDelegate>)delegate
{
    //TODO - Implement
}

-(void)setLocalControllerServiceEnabled: (BOOL)enabled
{
    //TODO - Implement
}

-(void)removeInitialSetDelegate: (id<LSFSDKInitialSetDelegate>)delegate
{
    //TODO - Implement
}

-(void)setNetworkConnected: (BOOL)connected
{
    //TODO - Implement
}

-(unsigned int)version
{
    //TODO - Implement
    return 0;
}

-(ajn::BusAttachment *)busAttachment
{
    return [[LSFAllJoynManager getAllJoynManager] bus];
}

-(void)setCreateSyncTimeout: (unsigned long)createSyncTimeout
{
    //TODO - Implement
}

-(unsigned long)createSyncTimeout
{
    //TODO - Implement
    return 0;
}

-(void)setDefaultLanguage: (NSString *)defaultLanguage
{
    //TODO - Impelement
}

-(NSString *)defaultLanguage
{
    //TODO - Implement
    return nil;
}

@end

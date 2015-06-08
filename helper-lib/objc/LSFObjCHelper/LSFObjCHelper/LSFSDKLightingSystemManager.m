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

#import "LSFSDKLightingSystemManager.h"
#import "LSFSDKAllJoynManager.h"
#import "LSFSDKLampCollectionManager.h"
#import "LSFSDKAllLampsLampGroup.h"

/*
 * Private Class
 */
@interface MyControllerAdapter : NSObject  <LSFSDKControllerDelegate>

@property (nonatomic, weak) id<LSFSDKNextControllerConnectionDelegate> delegate;
@property (nonatomic, strong) LSFSDKLightingSystemManager *manager;
@property (nonatomic) unsigned int delay;

-(id)initWithNextControlleConnectionDelegate: (id<LSFSDKNextControllerConnectionDelegate>)nccd lightingSystemManager: (LSFSDKLightingSystemManager *)lsm andDelay: (unsigned int)delay;

@end

@implementation MyControllerAdapter

@synthesize delegate = _delegate;
@synthesize manager = _manager;
@synthesize delay = _delay;

-(id)initWithNextControlleConnectionDelegate: (id<LSFSDKNextControllerConnectionDelegate>)nccd lightingSystemManager: (LSFSDKLightingSystemManager *)lsm andDelay: (unsigned int)delay
{
    self = [super init];

    if (self)
    {
        self.delegate = nccd;
        self.manager = lsm;
        self.delay = (delay / 1000);
    }

    return self;
}

-(void)onLeaderModelChange:(LSFControllerModel *)leadModel
{
    NSLog(@"MyControllerAdapter - onLeaderModelChanged() callback executing");

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delay * NSEC_PER_SEC)), self.manager.dispatchQueue, ^{
        if ([leadModel connected])
        {
            NSLog(@"MyControllerAdapter - Controller is connected, firing next controller connection delegate");
            [self.manager.controllerManager removeDelegate: self];
            [self.delegate onNextControllerConnection];
        }
    });
}

-(void)onControllerError:(LSFSDKControllerErrorEvent *)errorEvent
{
    //Intentionally left blank
}

@end //End Private Class

@interface LSFSDKLightingSystemManager()

-(void)clearModels;

@end

@implementation LSFSDKLightingSystemManager

@synthesize defaultLanguage = _defaultLanguage;
@synthesize dispatchQueue = _dispatchQueue;
@synthesize controllerClientCB = _controllerClientCB;
@synthesize controllerServiceManagerCB = _controllerServiceManagerCB;
@synthesize groupManagerCB = _groupManagerCB;
@synthesize lampManagerCB = _lampManagerCB;
@synthesize presetManagerCB = _presetManagerCB;
@synthesize transitionEffectManagerCB = _transitionEffectManagerCB;
@synthesize pulseEffectManagerCB = _pulseEffectManagerCB;
@synthesize sceneElementManagerCB = _sceneElementManagerCB;
@synthesize sceneManagerCBV1 = _sceneManagerCBV1;
@synthesize sceneWithSceneElementsManagerCB = _sceneWithSceneElementsManagerCB;
@synthesize sceneManagerCB = _sceneManagerCB;
@synthesize masterSceneManagerCB = _masterSceneManagerCB;
@synthesize lampCollectionManager = _lampCollectionManager;
@synthesize presetCollectionManager = _presetCollectionManager;
@synthesize groupCollectionManager = _groupCollectionManager;
@synthesize transitionEffectCollectionManager = _transitionEffectCollectionManager;
@synthesize pulseEffectCollectionManager = _pulseEffectCollectionManager;
@synthesize sceneElementCollectionManager = _sceneElementCollectionManager;
@synthesize sceneCollectionManagerV1 = _sceneCollectionManagerV1;
@synthesize sceneCollectionManager = _sceneCollectionManager;
@synthesize masterSceneCollectionManager = _masterSceneCollectionManager;
@synthesize controllerManager = _controllerManager;

-(id)init
{
    self = [super init];

    if (self)
    {
        self.defaultLanguage = @"en";
        LSFSDKAllLampsLampGroup *allLampsLampGroup = [LSFSDKAllLampsLampGroup getInstance];
        [allLampsLampGroup setLightingSystemManager: self];

        _controllerClientCB = [[LSFSDKHelperControllerClientCallback alloc] initWithLightingSystemManager: self];
        _controllerServiceManagerCB = [[LSFSDKHelperControllerServiceManagerCallback alloc] initWithLightingSystemManager: self];
        _groupManagerCB = [[LSFSDKHelperGroupManagerCallback alloc] initWithLightingSystemManager: self];
        _lampManagerCB = [[LSFSDKHelperLampManagerCallback alloc] initWithLightingSystemManager: self];
        _presetManagerCB = [[LSFSDKHelperPresetManagerCallback alloc] initWithLightingSystemManager: self];
        _transitionEffectManagerCB = [[LSFSDKHelperTransitionEffectManagerCallback alloc] initWithLightingSystemManager:self];
        _pulseEffectManagerCB = [[LSFSDKHelperPulseEffectManagerCallback alloc] initWithLightingSystemManager: self];
        _sceneElementManagerCB = [[LSFSDKHelperSceneElementManagerCallback alloc] initWithLightingSystemManager: self];
        _sceneManagerCBV1 = [[LSFSDKHelperSceneManagerCallbackV1 alloc] initWithLightingSystemManager: self];
        _sceneWithSceneElementsManagerCB = [[LSFSDKHelperSceneManagerCallbackV2 alloc] initWithLightingSystemManager: self];
        _sceneManagerCB = [[LSFSDKHelperSceneManagerCallback alloc] initWithSceneManagerCallbacks: [NSArray arrayWithObjects: _sceneManagerCBV1, _sceneWithSceneElementsManagerCB, nil]];
        _masterSceneManagerCB = [[LSFSDKHelperMasterSceneManagerCallback alloc] initWithLightingSystemManager: self];

        _lampCollectionManager = [[LSFSDKLampCollectionManager alloc] init];
        _presetCollectionManager = [[LSFSDKPresetCollectionManager alloc] init];
        _groupCollectionManager = [[LSFSDKGroupCollectionManager alloc] init];
        _transitionEffectCollectionManager = [[LSFSDKTransitionEffectCollectionManager alloc] init];
        _pulseEffectCollectionManager = [[LSFSDKPulseEffectCollectionManager alloc] init];
        _sceneElementCollectionManager = [[LSFSDKSceneElementCollectionManager alloc] init];
        _sceneCollectionManagerV1 = [[LSFSDKSceneCollectionManager alloc] init];
        _sceneCollectionManager = [[LSFSDKSceneCollectionManagerV2 alloc] init];
        _masterSceneCollectionManager = [[LSFSDKMasterSceneCollectionManager alloc] init];

        _controllerManager = [[LSFControllerManager alloc] init];
        [_controllerManager addDelegate: self];

        //TODO - initialize properties
    }

    return self;
}

-(void)initializeWithApplicationName: (NSString *)applicationName dispatchQueue: (dispatch_queue_t)queue andAllJoynDelegate: (id<LSFSDKAllJoynDelegate>)alljoynDelegate
{
    self.dispatchQueue = queue;

    [LSFSDKAllJoynManager initializeWithApplicationName: applicationName controllerClientCallback: _controllerClientCB controllerServiceManagerCallback: _controllerServiceManagerCB lampManagerCallback: _lampManagerCB groupManagerCallback: _groupManagerCB presetManagerCallback: _presetManagerCB transitionEffectManagerCallback: _transitionEffectManagerCB pulseEffectManagerCallback: _pulseEffectManagerCB sceneElementManagerCallback: _sceneElementManagerCB sceneManagerCallback: _sceneManagerCB masterSceneManagerCallback: _masterSceneManagerCB];
}

-(void)initializeWithBusAttachment: (ajn::BusAttachment *)busAttachment dispatchQueue: (dispatch_queue_t)queue andAllJoynDelegate: (id<LSFSDKAllJoynDelegate>)alljoynDelegate
{
    self.dispatchQueue = queue;

    [LSFSDKAllJoynManager initializeWithBusAttachment: busAttachment controllerClientCallback: _controllerClientCB controllerServiceManagerCallback: _controllerServiceManagerCB lampManagerCallback: _lampManagerCB groupManagerCallback: _groupManagerCB presetManagerCallback: _presetManagerCB transitionEffectManagerCallback: _transitionEffectManagerCB pulseEffectManagerCallback: _pulseEffectManagerCB sceneElementManagerCallback: _sceneElementManagerCB sceneManagerCallback: _sceneManagerCB masterSceneManagerCallback: _masterSceneManagerCB];
}

-(void)start
{
    [LSFSDKAllJoynManager startWithQueue: self.dispatchQueue];
}

-(void)stop
{
    [LSFSDKAllJoynManager stop];
}

-(void)setDispatchQueue: (dispatch_queue_t)dispatchQueue
{
    if (dispatchQueue == nil)
    {
        dispatchQueue = dispatch_queue_create("LSFDispatchQueue", NULL);
    }

    _dispatchQueue = dispatchQueue;
}

-(LSFSDKLampCollectionManager *)lampCollectionManager
{
    return _lampCollectionManager;
}

-(LSFSDKPresetCollectionManager *)presetCollectionManager
{
    return _presetCollectionManager;
}

-(LSFSDKGroupCollectionManager *)groupCollectionManager
{
    return _groupCollectionManager;
}

-(LSFSDKTransitionEffectCollectionManager *)transitionEffectCollectionManager
{
    return _transitionEffectCollectionManager;
}

-(LSFSDKPulseEffectCollectionManager *)pulseEffectCollectionManager
{
    return _pulseEffectCollectionManager;
}

-(LSFSDKSceneElementCollectionManager *)sceneElementCollectionManager
{
    return _sceneElementCollectionManager;
}

-(LSFSDKSceneCollectionManager *)sceneCollectionManagerV1
{
    return _sceneCollectionManagerV1;
}

-(LSFSDKSceneCollectionManagerV2 *)sceneCollectionManager
{
    return _sceneCollectionManager;
}

-(LSFSDKMasterSceneCollectionManager *)masterSceneCollectionManager
{
    return _masterSceneCollectionManager;
}

-(LSFLampManager *)lampManager
{
    return [LSFSDKAllJoynManager getLampManager];
}

-(LSFLampGroupManager *)groupManager
{
    return [LSFSDKAllJoynManager getGroupManager];
}

-(LSFPresetManager *)presetManager
{
    return [LSFSDKAllJoynManager getPresetManager];
}

-(LSFTransitionEffectManager *)transitionEffectManager
{
    return [LSFSDKAllJoynManager getTransitionEffectManager];
}

-(LSFPulseEffectManager *)pulseEffectManager
{
    return [LSFSDKAllJoynManager getPulseEffectManager];
}

-(LSFSceneElementManager *)sceneElementManager
{
    return [LSFSDKAllJoynManager getSceneElementManager];
}

-(LSFSceneManager *)sceneManager
{
    return [LSFSDKAllJoynManager getSceneManager];
}

-(LSFMasterSceneManager *)masterSceneManager
{
    return [LSFSDKAllJoynManager getMasterSceneManager];
}

-(LSFControllerManager *)controllerManager
{
    return _controllerManager;
}

-(void)postOnNextControllerConnection: (id<LSFSDKNextControllerConnectionDelegate>)delegate withDelay: (unsigned int)delay
{
    MyControllerAdapter *controllerAdapter = [[MyControllerAdapter alloc] initWithNextControlleConnectionDelegate: delegate lightingSystemManager: self andDelay: delay];
    [_controllerManager addDelegate: controllerAdapter];
}

/*
 * LSFSDKControllerDelegate implementation
 */
-(void)onLeaderModelChange: (LSFControllerModel *)leadModel
{
    NSLog(@"LSFSDKLightingSystemManager - onLeaderModelChange() callback executing");

    if (![leadModel connected])
    {
        NSLog(@"Clearing Models");
        [self clearModels];
    }
}

-(void)onControllerError: (LSFSDKControllerErrorEvent *)errorEvent
{
    //Intentionally left blank
}

/*
 * Private Functions
 */
-(void)clearModels
{
    [_lampManagerCB clear];

    [_lampCollectionManager removeAllLamps];
    [_presetCollectionManager removeAllPresets];
    [_groupCollectionManager removeAllGroups];
    [_transitionEffectCollectionManager removeAllTransitionEffects];
    [_pulseEffectCollectionManager removeAllPulseEffects];
    [_sceneElementCollectionManager removeAllSceneElements];
    [_sceneCollectionManagerV1 removeAllScenes];
    [_sceneCollectionManager removeAllScenes];
    [_masterSceneCollectionManager removeAllMasterScenes];
}

@end

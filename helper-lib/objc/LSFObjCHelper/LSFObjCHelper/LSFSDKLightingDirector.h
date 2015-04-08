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

#import <Foundation/Foundation.h>
#import "LSFSDKNextControllerConnectionDelegate.h"
#import "BusAttachment.h"
#import "LSFSDKLamp.h"
#import "LSFSDKGroup.h"
#import "LSFSDKPreset.h"
#import "LSFSDKTransitionEffect.h"
#import "LSFSDKPulseEffect.h"
#import "LSFSDKScene.h"
#import "LSFSDKMasterScene.h"
#import "LSFSDKSceneElement.h"
#import "LSFSDKEffect.h"
#import "LSFSDKLampDelegate.h"
#import "LSFSDKGroupDelegate.h"
#import "LSFSDKPresetDelegate.h"
#import "LSFSDKTransitionEffectDelegate.h"
#import "LSFSDKPulseEffectDelegate.h"
#import "LSFSDKSceneElementDelegate.h"
#import "LSFSDKSceneDelegate.h"
#import "LSFSDKMasterSceneDelegate.h"
#import "LSFSDKControllerDelegate.h"
#import "LSFSDKInitialSetDelegate.h"

/**
 * LSFSDKLightingDirector is the main class in the facade interface of the iOS Lighting SDK.
 * It provides access to instances of other facade classes that represent active components
 * in the Lighting system.
 *
 * *Note:* Please see the LSFTutorial project for an example of how to use the LSFSDKLightingDirector
 * class.
 */
@interface LSFSDKLightingDirector : NSObject

/** @name Class Properties */

/**
 * Returns the version number of the interface provided by this class
 *
 * @return Version number
 */
@property (nonatomic, readonly) unsigned int version;

/**
 * Returns the AllJoyn BusAttachment object being used to connect to the Lighting System
 *
 * @warning *Note:* The BusAttachment will be nil until some time after the call start.
 *
 * @return AllJoyn BusAttachment object.
 */
@property (nonatomic, readonly) ajn::BusAttachment *busAttachment;

/**
 * Returns a snapshot of the active Lamps in the Lighting system including lamps that may not have
 * received all data from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as
 * new lamps are discovered or existing lamps are determined to be offline. This array may be empty.
 *
 * @return Array of active Lamps.
 */
@property (nonatomic, strong, readonly) NSArray *lamps;

/**
 * Returns a snapshot of the active Lamps in the Lighting system that have received all data from the
 * controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as
 * new lamps are discovered or existing lamps are determined to be offline. This array may be empty.
 *
 * @return Array of active Lamps.
 */
@property (nonatomic, strong, readonly) NSArray *completeLamps;

/**
 * Returns a snapshot of the active Group definitions in the Lighting system including groups that may
 * not have received all data from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new groups
 * are created or existing groups are deleted. This array may be empty.
 *
 * @return Array of active Groups.
 */
@property (nonatomic, strong, readonly) NSArray *groups;

/**
 * Returns a snapshot of the active Group definitions in the Lighting system that have received all data from the
 * controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new groups are created
 * or existing groups are deleted. This array may be empty.
 *
 * @return Array of active fully-populated Groups.
 */
@property (nonatomic, strong, readonly) NSArray *completeGroups;

/**
 * Returns a snapshot of the active Preset definitions in the Lighting system including presets that may
 * not have received all data from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new presets
 * are created or existing presets are deleted. This array may be empty.
 *
 * @return Array of active Presets.
 */
@property (nonatomic, strong, readonly) NSArray *presets;

/**
 * Returns a snapshot of the active Preset definitions in the Lighting system that have received all data from the
 * controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new presets are created
 * or existing presets are deleted. This array may be empty.
 *
 * @return Array of active fully-populated Presets.
 */
@property (nonatomic, strong, readonly) NSArray *completePresets;

/**
 * Returns a snapshot of the active Transition Effect definitions in the Lighting system including transition effects
 * that may not have received all data from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new transition effects
 * are created or existing transtion effects are deleted. This array may be empty.
 *
 * @return Array of active Transition Effects.
 */
@property (nonatomic, strong, readonly) NSArray *transitionEffects;

/**
 * Returns a snapshot of the active Transition Effect definitions in the Lighting system that have received all data
 * from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new transition effects
 * are created or existing transition effects are deleted. This array may be empty.
 *
 * @return Array of active fully-populated Transition Effects.
 */
@property (nonatomic, strong, readonly) NSArray *completeTransitionEffects;

/**
 * Returns a snapshot of the active Pulse Effect definitions in the Lighting system including pulse effects that may
 * not have received all data from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new pulse effects
 * are created or existing pulse effects are deleted. This array may be empty.
 *
 * @return Array of active Pulse Effects.
 */
@property (nonatomic, strong, readonly) NSArray *pulseEffects;

/**
 * Returns a snapshot of the active Pulse Effect definitions in the Lighting system that have received all data
 * from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new pulse effects
 * are created or existing pulse effects are deleted. This array may be empty.
 *
 * @return Array of active fully-populated Pulse Effects.
 */
@property (nonatomic, strong, readonly) NSArray *completePulseEffects;

/**
 * Returns a snapshot of the active Scene Element definitions in the Lighting system including scene elements that may
 * not have received all data from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new scene elements
 * are created or existing scene elements are deleted. This array may be empty.
 *
 * @return Array of active Scene Elements.
 */
@property (nonatomic, strong, readonly) NSArray *sceneElements;

/**
 * Returns a snapshot of the active Scene Element definitions in the Lighting system that have received all data
 * from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new scene elements
 * are created or existing scene elements are deleted. This array may be empty.
 *
 * @return Array of active fully-populated Scene Elements.
 */
@property (nonatomic, strong, readonly) NSArray *completeSceneElements;

/**
 * Returns a snapshot of the active Scene definitions in the Lighting system including scenes that may not have received
 * all data from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new scenes are created or
 * existing scenes are deleted. This array may be empty.
 *
 * @return Array of active Scenes.
 */
@property (nonatomic, strong, readonly) NSArray *scenes;

/**
 * Returns a snapshot of the active Scene definitions in the Lighting system that have received all data from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new scenes are created or
 * existing scenes are deleted. This array may be empty.
 *
 * @return Array of active fully-populated Scenes.
 */
@property (nonatomic, strong, readonly) NSArray *completeScenes;

/**
 * Returns a snapshot of the active Master Scene definitions in the Lighting system including masteer scenes that may not
 * have received all data from the controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new master scenes are created or
 * existing master scenes are deleted. This array may be empty.
 *
 * @return Array of active Master Scenes.
 */
@property (nonatomic, strong, readonly) NSArray *masterScenes;

/**
 * Returns a snapshot of the active Master Scene definitions in the Lighting system that have received all data from the
 * controller.
 *
 * @warning *Note:* The contents of this array may change in subsequent calls to this method as new masterscenes are created or
 * existing master scenes are deleted. This array may be empty.
 *
 * @return Array of active fully-populated Master Scenes.
 */
@property (nonatomic, strong, readonly) NSArray *completeMasterScenes;

/**
 * Specifies the amount of time to wait (in milliseconds) for synchronous create methods to return.
 *
 * @warning *Note:* Default create sync timeout is 30 seconds.
 */
@property (nonatomic) unsigned long createSyncTimeout;

/**
 * Specifies the default language used in the Lighting System.
 *
 * @warning *Note:* Default language is english ("en").
 */
@property (nonatomic, strong) NSString *defaultLanguage;

/**
 * Toggles the state of the bundled Lighting Controller Service.
 */
@property (nonatomic) BOOL controllerServiceEnabled;

/**
 * Specifies whether there is an active network connection.
 *
 * *Note:* This is only used for the bundled lighting controller service.
 */
@property (nonatomic) BOOL isNetworkConnected;

/** @name Creating LSFSDKLightingDirector */

/**
 * Constructs and returns a singleton instance of LSFSDKLightingDirector.
 *
 * @warning *Note:* The start() method must be called at some point after construction when you're
 * ready to begin working with the Lighting system.
 *
 * @return LSFSDKLightingDirector singleton instance.
 */
+(LSFSDKLightingDirector *)getLightingDirector;

/** @name Starting/Stopping LSFSDKLightingDirector */

/**
 * Causes the LightingDirector to start interacting with the Lighting system.
 *
 * @warning *Note:* you should make sure that Wi-Fi or other network connection is available before
 * calling this method.
 */
-(void)start;

/**
 * Causes the LightingDirector to start interacting with the Lighting system using the specified
 * application name.
 *
 * @warning *Note:* you should make sure that Wi-Fi or other network connection is available before
 * calling this method.
 *
 * @param applicationName  Specifies the application name to be used when creating the AllJoyn bus attachment.
 */
-(void)startWithApplicationName: (NSString *)applicationName;

/**
 * Causes the LightingDirector to start interacting with the Lighting system using the specified
 * AllJoyn bus attachment.
 *
 * @warning *Note:* you should make sure that Wi-Fi or other network connection is available before
 * calling this method.
 *
 * @param busAttachment  Specifies the AllJoyn bus attachment to use in the Lighting System.
 */
-(void)startWithBusAttachment: (ajn::BusAttachment *)busAttachment;

/**
 * Causes the LightingDirector to start interacting with the Lighting system using the specified
 * application name and dispatch queue.
 *
 * @warning *Note:* you should make sure that Wi-Fi or other network connection is available before
 * calling this method.
 *
 * @param applicationName  Specifies the application name to be used when creating the AllJoyn bus attachment.
 * @param queue  Specifies the dispatch queue to handle all lighting events. All internal tasks will be processed using the thread associated with this queue.
 */
-(void)startWithApplicationName: (NSString *)applicationName dispatchQueue: (dispatch_queue_t)queue;

/**
 * Causes the LightingDirector to start interacting with the Lighting system using the specified
 * AllJoyn bus attachment and dispatch queue.
 *
 * @warning *Note:* you should make sure that Wi-Fi or other network connection is available before
 * calling this method.
 *
 * @param busAttachment  Specifies the AllJoyn bus attachment to use in the Lighting System.
 * @param queue  Specifies the dispatch queue to handle all lighting events. All internal tasks will be processed using the thread associated with this queue.
 */
-(void)startWithBusAttachment: (ajn::BusAttachment *)busAttachment dispatchQueue: (dispatch_queue_t)queue;

/**
 * Causes the LSFSDKLightingDirector to stop interacting with the Lighting system.
 */
-(void)stop;

/** @name Getters for active Lighting System components */

/**
 * Returns an instance of the LSFSDKLamp with the corresponding ID.
 *
 * @param lampID  The ID of the Lamp.
 *
 * @return Instance of LSFSDKLamp.
 */
-(LSFSDKLamp *)getLampWithID: (NSString *)lampID;

/**
 * Returns an instance of the LSFSDKGroup with the corresponding ID.
 *
 * @param groupID  The ID of the Group.
 *
 * @return Instance of LSFSDKGroup.
 */
-(LSFSDKGroup *)getGroupWithID: (NSString *)groupID;

/**
 * Returns an instance of the LSFSDKPreset with the corresponding ID.
 *
 * @param presetID  The ID of the Preset.
 *
 * @return Instance of LSFSDKPreset.
 */
-(LSFSDKPreset *)getPresetWithID: (NSString *)presetID;

/**
 * Returns an instance of the LSFSDKTransitionEffect with the corresponding ID.
 *
 * @param transitionEffectID  The ID of the Transition Effect.
 *
 * @return Instance of LSFSDKTransitionEffect.
 */
-(LSFSDKTransitionEffect *)getTransitionEffectWithID: (NSString *)transitionEffectID;

/**
 * Returns an instance of the LSFSDKPulseEffect with the corresponding ID.
 *
 * @param pulseEffectID  The ID of the Pulse Effect.
 *
 * @return Instance of LSFSDKPulseEffect.
 */
-(LSFSDKPulseEffect *)getPulseEffectWithID: (NSString *)pulseEffectID;

/**
 * Returns an instance of the LSFSDKSceneElement with the corresponding ID.
 *
 * @param sceneElementID  The ID of the Scene Element.
 *
 * @return Instance of LSFSDKSceneElement.
 */
-(LSFSDKSceneElement *)getSceneElementWithID: (NSString *)sceneElementID;

/**
 * Returns an instance of the LSFSDKScene with the corresponding ID.
 *
 * @param sceneID  The ID of the Scene.
 *
 * @return Instance of LSFSDKScene.
 */
-(LSFSDKScene *)getSceneWithID: (NSString *)sceneID;

/**
 * Returns an instance of the LSFSDKMasterScene with the corresponding ID.
 *
 * @param masterSceneID  The ID of the Master Scene.
 *
 * @return Instance of LSFSDKMasterScene.
 */
-(LSFSDKMasterScene *)getMasterSceneWithID: (NSString *)masterSceneID;

/** @name Creating active Lighting System components */

/**
 * Synchronously creates a Group on the Lighting Controller.
 *
 * @warning *Note:* This is a blocking call that will block the current thread until the object is
 * successfully created or the create sync timeout is exceeded.
 *
 * @param members  Array of LSFSDKGroupMember.
 * @param groupName  Name of the group.
 *
 * @return Instance of LSFSDKGroup, or nil upon failure.
 */
-(LSFSDKGroup *)createGroupSyncWithMembers: (NSArray *)members groupName: (NSString *)groupName;

/**
 * Asynchronously creates a Group on the Lighting Controller.
 *
 * @param members  Array of LSFSDKGroupMember.
 * @param groupName  Name of the group.
 * @param delegate  Specifies a callback that's invoked only for the group being created.
 */
-(void)createGroupWithMembers: (NSArray *)members groupName: (NSString *)groupName delegate: (id<LSFSDKGroupDelegate>)delegate;

/**
 * Synchronously creates a Preset on the Lighting Controller.
 *
 * @warning *Note:* This is a blocking call that will block the current thread until the object is
 * successfully created or the create sync timeout is exceeded.
 *
 * @param power  Specifies the power of the preset's lamp state.
 * @param color  Specifies the color of the preset's lamp state.
 * @param presetName  Name of the preset.
 *
 * @return Instance of LSFSDKPreset, or nil upon failure..
 */
-(LSFSDKPreset *)createPresetSyncWithPower: (Power)power color: (LSFSDKColor *)color presetName: (NSString *)presetName;

/**
 * Asynchronously creates a Preset on the Lighting Controller.
 *
 * @param power  Specifies the power of the preset's lamp state.
 * @param color  Specifies the color of the preset's lamp state.
 * @param presetName  Name of the preset.
 * @param delegate  Specifies a callback that's invoked only for the preset being created.
 *
 * @return Instance of LSFSDKPreset.
 */
-(void)createPresetWithPower: (Power)power color: (LSFSDKColor *)color presetName: (NSString *)presetName delegate: (id<LSFSDKPresetDelegate>)delegate;

/**
 * Synchronously creates a Transtion Effect on the Lighting Controller.
 *
 * @warning *Note:* This is a blocking call that will block the current thread until the object is
 * successfully created or the create sync timeout is exceeded.
 *
 * @param state  Specifies the lamp state of the transition effect.
 * @param duration  Specifies how long the transition effect will take.
 * @param effectName  Name of the transition effect.
 *
 * @return Instance of LSFSDKTransitionEffect, or nil upon failure.
 */
-(LSFSDKTransitionEffect *)createTransitionEffectSyncWithLampState: (id<LSFSDKLampState>)state duration: (unsigned long)duration name: (NSString *)effectName;

/**
 * Synchronously creates a Transtion Effect on the Lighting Controller.
 *
 * @param state  Specifies the lamp state of the transition effect.
 * @param duration  Specifies how long the transition effect will take.
 * @param effectName  Name of the transition effect.
 * @param delegate  Specifies a callback that's invoked only for the transition effect being created.
 */
-(void)createTransitionEffectWithLampState: (id<LSFSDKLampState>)state duration: (unsigned long)duration name: (NSString *)effectName delegate: (id<LSFSDKTransitionEffectDelegate>)delegate;

/**
 * Synchronously creates a Pulse Effect on the Lighting Controller.
 *
 * @warning *Note:* This is a blocking call that will block the current thread until the object is
 * successfully created or the create sync timeout is exceeded.
 *
 * @param fromState  Specifies the starting lamp state of the pulse effect.
 * @param toState  Specifies the ending lamp state of the pulse effect.
 * @param period  Specifies the period of the pulse (in ms). Period refers to the time duration between the start of two pulses.
 * @param duration  Specifies the duration of a single pulse (in ms). This must be less than the period.
 * @param count  Specifies the number of pulses.
 * @param effectName  Name of the pulse effect.
 *
 * @return Instance of LSFSDKPulseEffect, or nil upon failure.
 */
-(LSFSDKPulseEffect *)createPulseEffectSyncWithFromState: (id<LSFSDKLampState>)fromState toState: (id<LSFSDKLampState>)toState period: (unsigned long)period duration: (unsigned long)duration count: (unsigned long)count name: (NSString *)effectName;

/**
 * Asynchronously creates a Pulse Effect on the Lighting Controller.
 *
 * @param fromState  Specifies the starting lamp state of the pulse effect.
 * @param toState  Specifies the ending lamp state of the pulse effect.
 * @param period  Specifies the period of the pulse (in ms). Period refers to the time duration between the start of two pulses.
 * @param duration  Specifies the duration of a single pulse (in ms). This must be less than the period.
 * @param count  Specifies the number of pulses.
 * @param effectName  Name of the pulse effect.
 * @param delegate  Specifies a callback that's invoked only for the pulse effect being created.
 */
-(void)createPulseEffectWithFromState: (id<LSFSDKLampState>)fromState toState: (id<LSFSDKLampState>)toState period: (unsigned long)period duration: (unsigned long)duration count: (unsigned long)count name: (NSString *)effectName delegate: (id<LSFSDKPulseEffectDelegate>)delegate;

/**
 * Synchronously creates a Scene Element on the Lighting Controller.
 *
 * @warning *Note:* This is a blocking call that will block the current thread until the object is
 * successfully created or the create sync timeout is exceeded.
 *
 * @param effect  Specifies the scene elements effect.
 * @param members  Specifies LSFSDKGroupMember's for which the effect will be applied.
 * @param sceneElementName  Name of the scene element.
 *
 * @return Instance of LSFSDKSceneElement, or nil upon failure.
 */
-(LSFSDKSceneElement *)createSceneElementSyncWithEffect: (id<LSFSDKEffect>)effect groupMembers: (NSArray *)members name: (NSString *)sceneElementName;

/**
 * Asynchronously creates a Scene Element on the Lighting Controller.
 *
 * @param effect  Specifies the scene elements effect.
 * @param members  Specifies LSFSDKGroupMember's for which the effect will be applied.
 * @param sceneElementName  Name of the scene element.
 * @param delegate  Specifies a callback that's invoked only for the scene element being created.
 */
-(void)createSceneElementWithEffect: (id<LSFSDKEffect>)effect groupMembers: (NSArray *)members name: (NSString *)sceneElementName delegate: (id<LSFSDKSceneElementDelegate>)delegate;

/**
 * Synchronously creates a Scene on the Lighting Controller.
 *
 * @warning *Note:* This is a blocking call that will block the current thread until the object is
 * successfully created or the create sync timeout is exceeded.
 *
 * @param sceneElements  Specifies the scene elements that belong to the scene.
 * @param sceneName  Name of the scene.
 *
 * @return Instance of LSFSDKScene, or nil upon failure.
 */
-(LSFSDKScene *)createSceneSyncWithSceneElements: (NSArray *)sceneElements name: (NSString *)sceneName;

/**
 * Asynchronously creates a Scene on the Lighting Controller.
 *
 * @param sceneElements  Specifies the scene elements that belong to the scene.
 * @param sceneName  Name of the scene.
 * @param delegate  Specifies a callback that's invoked only for the scene being created.
 */
-(void)createSceneWithSceneElements: (NSArray *)sceneElements name: (NSString *)sceneName delegate: (id<LSFSDKSceneDelegate>)delegate;

/**
 * Synchronously creates a Master Scene on the Lighting Controller.
 *
 * @warning *Note:* This is a blocking call that will block the current thread until the object is
 * successfully created or the create sync timeout is exceeded.
 *
 * @param scenes  Specifies the scenes that belong to the master scene.
 * @param masterSceneName  Name of the master scene.
 *
 * @return Instance of LSFSDKMasterScene, or nil upon failure.
 */
-(LSFSDKMasterScene *)createMasterSceneSyncWithScenes: (NSArray *)scenes name: (NSString *)masterSceneName;

/**
 * Asynchronously creates a Master Scene on the Lighting Controller.
 *
 * @param scenes  Specifies the scenes that belong to the master scene.
 * @param masterSceneName  Name of the master scene.
 * @param delegate  Specifies a callback that's invoked only for the master scene being created.
 */
-(void)createMasterSceneWithScenes: (NSArray *)scenes name: (NSString *)masterSceneName delegate: (id<LSFSDKMasterSceneDelegate>)delegate;

/** @name Add and Remove Lighting System delegates */

/**
 * Specifies a delegate to invoke once a connection to a lighting system has been established. After a connection is established,
 * this listener will be invoked only one time.
 *
 * This allows clients of the LightingDirector to be notified once a connection has
 * been established.
 *
 * @param delay  Specifies a delay between when a connection occurs and when the delegate should be invoked
 * @param delegate  The delegate to invoke on connection
 */
-(void)postOnNextControllerConnectionWithDelay: (unsigned int)delay delegate: (id<LSFSDKNextControllerConnectionDelegate>)delegate;

/**
 * Specifies a block to execute once a connection to a lighting system has been established. After a connection is established,
 * this block will be executed only one time.
 *
 * This allows clients of the LightingDirector to be notified once a connection has
 * been established.
 *
 * @param delay  Specifies a delay between when a connection occurs and when the delegate should be invoked
 * @param block  The block to execute on connection
 */
-(void)postOnNextControllerConnectionWithDelay: (unsigned int)delay block: (void (^)(void))block;

/**
 * Waits for the initial data set from the controller to be received before returning
 *
 * @warning *Note:* This is a blocking call that will block the current thread until the method returns.
 */
-(void)waitForInitialSetCompletion;

/**
 * Adds a global delegate to receive all Lighting System events associated with the provided delegate.
 *
 * @param delegate  The delegate that receives Lighting System events.
 */
-(void)addDelegate: (id<LSFSDKLightingDelegate>)delegate;

/**
 * Adds a global delegate to receive all Lamp events.
 *
 * @param delegate  The delegate that receives all lamp events.
 */
-(void)addLampDelegate: (id<LSFSDKLampDelegate>)delegate;

/**
 * Adds a global delegate to receive all Group events.
 *
 * @param delegate  The delegate that receives all group events.
 */
-(void)addGroupDelegate: (id<LSFSDKGroupDelegate>)delegate;

/**
 * Adds a global delegate to receive all Preset events.
 *
 * @param delegate  The delegate that receives all preset events.
 */
-(void)addPresetDelegate: (id<LSFSDKPresetDelegate>)delegate;

/**
 * Adds a global delegate to receive all Transition Effect events.
 *
 * @param delegate  The delegate that receives all Lighting System transition effect events.
 */
-(void)addTransitionEffectDelegate: (id<LSFSDKTransitionEffectDelegate>)delegate;

/**
 * Adds a global delegate to receive all Pulse Effect events.
 *
 * @param delegate  The delegate that receives all Lighting System pulse effect events.
 */
-(void)addPulseEffectDelegate: (id<LSFSDKPulseEffectDelegate>)delegate;

/**
 * Adds a global delegate to receive all Scene Element events.
 *
 * @param delegate  The delegate that receives all scene element events.
 */
-(void)addSceneElementDelegate: (id<LSFSDKSceneElementDelegate>)delegate;

/**
 * Adds a global delegate to receive all Scene events.
 *
 * @param delegate  The delegate that receives all scene events.
 */
-(void)addSceneDelegate: (id<LSFSDKSceneDelegate>)delegate;

/**
 * Adds a global delegate to receive all Master Scene events.
 *
 * @param delegate  The delegate that receives all master scene events.
 */
-(void)addMasterSceneDelegate: (id<LSFSDKMasterSceneDelegate>)delegate;

/**
 * Adds a global delegate to receive all Controller events.
 *
 * @param delegate  The delegate that receives all controller events.
 */
-(void)addControllerDelegate: (id<LSFSDKControllerDelegate>)delegate;

/**
 * Adds a global delegate to receive a callback when the initial data set has been received from
 * the controller.
 *
 * @param delegate  The delegate that receives initial data set events.
 */
-(void)addInitialSetDelegate: (id<LSFSDKInitialSetDelegate>)delegate;

/**
 * Removes a global delegate to receive all Lighting System events associated with the provided delegate.
 *
 * @param delegate  The delegate that receives Lighting System events.
 */
-(void)removeDelegate: (id<LSFSDKLightingDelegate>)delegate;

/**
 * Removes a global delegate to receive all Lamp events.
 *
 * @param delegate  The delegate that receives all lamp events.
 */
-(void)removeLampDelegate: (id<LSFSDKLampDelegate>)delegate;

/**
 * Removes a global delegate to receive all Group events.
 *
 * @param delegate  The delegate that receives all group events.
 */
-(void)removeGroupDelegate: (id<LSFSDKGroupDelegate>)delegate;

/**
 * Removes a global delegate to receive all Preset events.
 *
 * @param delegate  The delegate that receives all preset events.
 */
-(void)removePresetDelegate: (id<LSFSDKPresetDelegate>)delegate;

/**
 * Removes a global delegate to receive all Transition Effect events.
 *
 * @param delegate  The delegate that receives all Lighting System transition effect events.
 */
-(void)removeTransitionEffectDelegate: (id<LSFSDKTransitionEffectDelegate>)delegate;

/**
 * Removes a global delegate to receive all Pulse Effect events.
 *
 * @param delegate  The delegate that receives all Lighting System pulse effect events.
 */
-(void)removePulseEffectDelegate: (id<LSFSDKPulseEffectDelegate>)delegate;

/**
 * Removes a global delegate to receive all Scene Element events.
 *
 * @param delegate  The delegate that receives all scene element events.
 */
-(void)removeSceneElementDelegate: (id<LSFSDKSceneElementDelegate>)delegate;

/**
 * Removes a global delegate to receive all Scene events.
 *
 * @param delegate  The delegate that receives all scene events.
 */
-(void)removeSceneDelegate: (id<LSFSDKSceneDelegate>)delegate;

/**
 * Removes a global delegate to receive all Master Scene events.
 *
 * @param delegate  The delegate that receives all master scene events.
 */
-(void)removeMasterSceneDelegate: (id<LSFSDKMasterSceneDelegate>)delegate;

/**
 * Removes a global delegate to receive all Controller events.
 *
 * @param delegate  The delegate that receives all controller events.
 */
-(void)removeControllerDelegate: (id<LSFSDKControllerDelegate>)delegate;

/**
 * Removes a global delegate to receive a callback when the initial data set has been received from
 * the controller.
 *
 * @param delegate  The delegate that receives initial data set events.
 */
-(void)removeInitialSetDelegate: (id<LSFSDKInitialSetDelegate>)delegate;


@end

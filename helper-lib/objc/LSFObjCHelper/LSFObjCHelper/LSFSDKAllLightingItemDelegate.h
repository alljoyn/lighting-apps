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
#import "LSFSDKLampDelegate.h"
#import "LSFSDKGroupDelegate.h"
#import "LSFSDKPresetDelegate.h"
#import "LSFSDKTransitionEffectDelegate.h"
#import "LSFSDKPulseEffectDelegate.h"
#import "LSFSDKSceneElementDelegate.h"
#import "LSFSDKSceneDelegate.h"
#import "LSFSDKMasterSceneDelegate.h"
#import "LSFSDKControllerDelegate.h"

/**
 * Provides an interface for developers to implement and receive all Lighting related events in the
 * Lighting system. This includes events for lamps, groups, presets, transition/pulse effects, scene
 * elements, scenes, master scenes, and controller.
 *
 * **Note:** Once implemented, the delegate must be registered with the LSFSDKLightingDirector in order
 * to receive all Lighting callbacks. See [LSFSDKLightingDirector addDelegate:] for more information.
 */
@protocol LSFSDKAllLightingItemDelegate <LSFSDKLampDelegate, LSFSDKGroupDelegate, LSFSDKPresetDelegate, LSFSDKTransitionEffectDelegate, LSFSDKPulseEffectDelegate, LSFSDKSceneElementDelegate, LSFSDKSceneDelegate, LSFSDKMasterSceneDelegate, LSFSDKControllerDelegate>

@end
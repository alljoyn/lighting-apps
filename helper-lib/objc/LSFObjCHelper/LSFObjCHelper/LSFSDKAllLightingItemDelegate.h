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
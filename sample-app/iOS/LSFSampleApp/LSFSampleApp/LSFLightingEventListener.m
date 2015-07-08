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

#import "LSFLightingEventListener.h"
#import <LSFSDKLightingDirector.h>

@implementation LSFLightingEventListener

-(void)onLampInitialized: (LSFSDKLamp *)lamp
{
    //Intentionally left blank
}

-(void)onLampChanged: (LSFSDKLamp *)lamp
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: lamp, nil] forKeys: [[NSArray alloc] initWithObjects: @"lamp", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFLampChangedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onLampRemoved: (LSFSDKLamp *)lamp
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: lamp, nil] forKeys: [[NSArray alloc] initWithObjects: @"lamp", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFLampRemovedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onLampError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"%s Error: %@", __FUNCTION__, [error name]);
}

-(void)onGroupInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andGroup: (LSFSDKGroup *)group
{
    //Intentionally left blank
}

-(void)onGroupChanged: (LSFSDKGroup *)group
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: group, nil] forKeys: [[NSArray alloc] initWithObjects: @"group", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFGroupChangedNotification" object: self userInfo: userInfoDict];
    });
}
-(void)onGroupRemoved: (LSFSDKGroup *)group
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: group, nil] forKeys: [[NSArray alloc] initWithObjects: @"group", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFGroupRemovedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onGroupError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"%s Error: %@", __FUNCTION__, [error name]);
}

-(void)onPresetInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andPreset: (LSFSDKPreset *)preset
{
    //Intentionally left blank
}

-(void)onPresetChanged: (LSFSDKPreset *)preset
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: preset, nil] forKeys: [[NSArray alloc] initWithObjects: @"preset", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFPresetChangedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onPresetRemoved: (LSFSDKPreset *)preset
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: preset, nil] forKeys: [[NSArray alloc] initWithObjects: @"preset", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFPresetRemovedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onPresetError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"%s Error: %@", __FUNCTION__, [error name]);
}

-(void)onTransitionEffectInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andTransitionEffect: (LSFSDKTransitionEffect *)transitionEffect;
{
    //Intentionally left blank
}

-(void)onTransitionEffectChanged: (LSFSDKTransitionEffect *)transitionEffect
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: transitionEffect, nil] forKeys: [[NSArray alloc] initWithObjects: @"transitionEffect", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFTransitionEffectChangedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onTransitionEffectRemoved: (LSFSDKTransitionEffect *)transitionEffect
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: transitionEffect, nil] forKeys: [[NSArray alloc] initWithObjects: @"transitionEffect", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFTransitionEffectRemovedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onTransitionEffectError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"%s Error: %@", __FUNCTION__, [error name]);
}

-(void)onPulseEffectInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andPulseEffect: (LSFSDKPulseEffect *)pulseEffect;
{
    //Intentionally left blank
}

-(void)onPulseEffectChanged: (LSFSDKPulseEffect *)pulseEffect
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: pulseEffect, nil] forKeys: [[NSArray alloc] initWithObjects: @"pulseEffect", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFPulseEffectChangedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onPulseEffectRemoved: (LSFSDKPulseEffect *)pulseEffect
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: pulseEffect, nil] forKeys: [[NSArray alloc] initWithObjects: @"pulseEffect", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFPulseEffectRemovedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onPulseEffectError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"%s Error: %@", __FUNCTION__, [error name]);
}

-(void)onSceneElementInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andSceneElement: (LSFSDKSceneElement *)sceneElement
{
    //Intentionally left blank
}

-(void)onSceneElementChanged: (LSFSDKSceneElement *)sceneElement
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: sceneElement, nil] forKeys: [[NSArray alloc] initWithObjects: @"sceneElement", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFSceneElementChangedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onSceneElementRemoved: (LSFSDKSceneElement *)sceneElement
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: sceneElement, nil] forKeys: [[NSArray alloc] initWithObjects: @"sceneElement", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFSceneElementRemovedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onSceneElementError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"%s Error: %@", __FUNCTION__, [error name]);
}

-(void)onSceneInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andScene: (LSFSDKScene *)scene
{
    //Intentionally left blank
}

-(void)onSceneChanged: (LSFSDKScene *)scene
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: scene, nil] forKeys: [[NSArray alloc] initWithObjects: @"scene", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFSceneChangedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onSceneRemoved: (LSFSDKScene *)scene
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: scene, nil] forKeys: [[NSArray alloc] initWithObjects: @"scene", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFSceneRemovedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onSceneError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"%s Error: %@", __FUNCTION__, [error name]);
}

-(void)onMasterSceneInitializedWithTrackingID: (LSFSDKTrackingID *)trackingID andMasterScene: (LSFSDKMasterScene *)masterScene
{
    //Intentionally left blank
}

-(void)onMasterSceneChanged: (LSFSDKMasterScene *)masterScene
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: masterScene, nil] forKeys: [[NSArray alloc] initWithObjects: @"masterScene", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFMasterSceneChangedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onMasterSceneRemoved: (LSFSDKMasterScene *)masterScene
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: masterScene, nil] forKeys: [[NSArray alloc] initWithObjects: @"masterScene", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFMasterSceneRemovedNotification" object: self userInfo: userInfoDict];
    });
}

-(void)onMasterSceneError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"%s Error: %@", __FUNCTION__, [error name]);
}

//-(void)onLeaderModelChange: (LSFControllerModel *)leadModel
-(void)onLeaderChange: (LSFSDKController *)leader
{
    NSLog(@"%s", __FUNCTION__);

    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *userInfoDict = [[NSDictionary alloc] initWithObjects: [[NSArray alloc] initWithObjects: leader, nil] forKeys: [[NSArray alloc] initWithObjects: @"leader", nil]];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"LSFContollerLeaderModelChange" object: self userInfo: userInfoDict];
    });
}

-(void)onControllerError: (LSFSDKControllerErrorEvent *)errorEvent
{
    //Intentionally left blank
}

@end

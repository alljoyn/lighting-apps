/******************************************************************************
 * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE."];
    [noticeText addAttribute: NSFontAttributeName value: [UIFont fontWithName: @"Helvetica Neue" size: 18.0f] range: NSMakeRange(0, noticeText.length)];

    return noticeText;
}

+(BOOL)preset: (LSFSDKPreset *)preset matchesMyLampState: (LSFSDKMyLampState *)state
{
    Power presetPower = [preset getPower];
    LSFSDKColor *presetColor = [preset getColor];

    Power lampStatePower = [state power];
    LSFSDKColor *lampStateColor = [state color];

    return
    presetPower == lampStatePower                       &&
    presetColor.hue == lampStateColor.hue               &&
    presetColor.saturation == lampStateColor.saturation &&
    presetColor.brightness == lampStateColor.brightness &&
    presetColor.colorTemp == lampStateColor.colorTemp;
}

+(NSArray *)getPresetsWithMyLampState: (LSFSDKMyLampState *)state
{
    NSMutableArray *presetsArray = [[NSMutableArray alloc] init];
    for (LSFSDKPreset *preset in [[LSFSDKLightingDirector getLightingDirector] presets])
    {
        if (![preset.name hasPrefix: PRESET_NAME_PREFIX])
        {
            BOOL matchesPreset = [self preset: preset matchesMyLampState: state];

            if (matchesPreset)
            {
                [presetsArray addObject: preset];
            }
        }
    }

    return presetsArray;
}

+(NSArray *)sortLightingItemsByName: (NSArray *)items
{
    NSMutableArray *sortedArray = [NSMutableArray arrayWithArray: [items sortedArrayUsingComparator: ^NSComparisonResult(id a, id b) {
        NSString *first = [(LSFSDKLightingItem *)a name];
        NSString *second = [(LSFSDKLightingItem *)b name];

        NSComparisonResult result = [first localizedCaseInsensitiveCompare: second];
        if (result == NSOrderedSame)
        {
            result = [((LSFSDKLightingItem *)a).theID localizedCaseInsensitiveCompare: ((LSFSDKLightingItem *)b).theID];
        }

        return result;
    }]];

    return sortedArray;
}

+(void)disableActionSheet: (UIActionSheet *)actionSheet buttonAtIndex: (NSInteger)index
{
    NSInteger buttonCount = 0;

    for (UIView *view in [actionSheet subviews])
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            if (buttonCount == index)
            {
                if ([view respondsToSelector:@selector(setEnabled:)])
                {
                    UIButton *button = (UIButton *)view;
                    button.enabled = NO;
                }
            }

            buttonCount++;
        }
    }
}

+(NSString *)memberStringForPendingSceneElement: (LSFPendingSceneElement *)sceneElement
{
    NSMutableString *memberString = [[NSMutableString alloc] init];
    NSUInteger numMembers = sceneElement.members.count;

    if (numMembers > 0)
    {
        [memberString appendString: [[sceneElement.members objectAtIndex: 0] name]];

        if (sceneElement.members.count > 1)
        {
            [memberString appendString: [NSString stringWithFormat: @" (and %lu more)", (unsigned long)sceneElement.members.count - 1]];
        }
    }

    return memberString;
}

+(NSString *) generateRandomHexStringWithLength: (int)len
{
    NSString *digits = @"0123456789ABCDEF";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

    for (int i = 0; i < len; i++)
    {
        unichar c = [digits characterAtIndex: (arc4random() % [digits length])];
        [randomString appendFormat: @"%C", c];
    }

    return randomString;
}

+(LSFSDKTrackingID *)createEffectFromPendingItem: (LSFPendingEffect *)effect
{
    NSArray* matchingPresets = nil;
    id<LSFSDKLampState> effectLampState = nil;
    id<LSFSDKLampState> effectEndLampState = nil;

    switch (effect.type)
    {
        case PRESET:
            return [[LSFSDKLightingDirector getLightingDirector] createPresetWithPower: effect.state.power color: effect.state.color presetName: effect.name];
            break;
        case TRANSITION:
            matchingPresets = [LSFUtilityFunctions getPresetsWithMyLampState: effect.state];
            effectLampState = (matchingPresets.count > 0)? [matchingPresets objectAtIndex: 0] : effect.state;

            return [[LSFSDKLightingDirector getLightingDirector] createTransitionEffectWithLampState: effectLampState duration: effect.duration name: effect.name];
        case PULSE:
            matchingPresets = [LSFUtilityFunctions getPresetsWithMyLampState: effect.state];
            effectLampState = (matchingPresets.count > 0)? [matchingPresets objectAtIndex: 0] : effect.state;

            matchingPresets = [LSFUtilityFunctions getPresetsWithMyLampState: effect.endState];
            effectEndLampState = (matchingPresets.count > 0)? [matchingPresets objectAtIndex: 0] : effect.endState;

            return [[LSFSDKLightingDirector getLightingDirector] createPulseEffectWithFromState: effectLampState toState: effectEndLampState period: effect.period duration: effect.duration count: effect.pulses name: effect.name];
        default:
            return nil;
    }
}

+(LSFSDKTrackingID *)createSceneElementFromPendingItem: (LSFPendingSceneElement *)sceneElement
{
    id<LSFSDKEffect> effect = [[LSFSDKLightingDirector getLightingDirector] getEffectWithID: sceneElement.pendingEffect.theID];

    return [[LSFSDKLightingDirector getLightingDirector] createSceneElementWithEffect: effect groupMembers: sceneElement.members name: sceneElement.name];
}

+(LSFSDKTrackingID *)createSceneFromPendingItem: (LSFPendingSceneV2 *)scene
{
    NSArray *sceneElementIDs = [scene.pendingSceneElements valueForKeyPath: @"theID"];
    NSMutableArray *sceneElements = [[NSMutableArray alloc] init];
    for (NSString *elementID in sceneElementIDs)
    {
        [sceneElements addObject: [[LSFSDKLightingDirector getLightingDirector] getSceneElementWithID: elementID]];
    }

    return [[LSFSDKLightingDirector getLightingDirector] createSceneWithSceneElements: sceneElements name: scene.name];
}

+(void)updateSceneElementWithID: (NSString *)elementID pendingItem: (LSFPendingSceneElement *)pendingElement
{
    LSFSDKSceneElement *element = [[LSFSDKLightingDirector getLightingDirector] getSceneElementWithID: elementID];
    id<LSFSDKEffect> effect = [[LSFSDKLightingDirector getLightingDirector] getEffectWithID: pendingElement.pendingEffect.theID];
    [element modifyWithEffect: effect groupMembers: pendingElement.members];
}

+(void)updateEffectWithID: (NSString *)effectID pendingItem: (LSFPendingEffect *)pendingEffect
{
    id<LSFSDKEffect> effect = [[LSFSDKLightingDirector getLightingDirector] getEffectWithID: effectID];

    if ([effect isKindOfClass: [LSFSDKPreset class]])
    {
        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            LSFSDKPreset *preset = (LSFSDKPreset *)effect;
            [preset modifyWithPower: pendingEffect.state.power color: pendingEffect.state.color];
        });
    }
    else if ([effect isKindOfClass: [LSFSDKTransitionEffect class]])
    {
        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            LSFSDKTransitionEffect *transition = (LSFSDKTransitionEffect *)effect;

            NSArray *matchingPresets = [LSFUtilityFunctions getPresetsWithMyLampState: pendingEffect.state];
            id<LSFSDKLampState> effectLampState = (matchingPresets.count > 0)? [matchingPresets objectAtIndex: 0] : pendingEffect.state;

            [transition modify: effectLampState duration: pendingEffect.duration];
        });
    }
    else if ([effect isKindOfClass: [LSFSDKPulseEffect class]])
    {
        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            LSFSDKPulseEffect *pulse = (LSFSDKPulseEffect *)effect;

            NSArray *matchingPresets = [LSFUtilityFunctions getPresetsWithMyLampState: pendingEffect.state];
            id<LSFSDKLampState> effectLampState = (matchingPresets.count > 0)? [matchingPresets objectAtIndex: 0] : pendingEffect.state;

            matchingPresets = [LSFUtilityFunctions getPresetsWithMyLampState: pendingEffect.endState];
            id<LSFSDKLampState> effectEndLampState = (matchingPresets.count >0)? [matchingPresets objectAtIndex: 0] : pendingEffect.endState;

            [pulse modifyFromState: effectLampState toState: effectEndLampState period: pendingEffect.period duration: pendingEffect.duration count: pendingEffect.pulses];
        });
    }
}

+(int)getBoundedMinColorTempForMembers: (NSArray *)members
{
    int minTemp = INT_MIN;

    for (id member in members)
    {
        if ([member isKindOfClass: [LSFSDKGroupMember class]])
        {
            minTemp = MAX(minTemp, [member colorTempMin]);
        }
    }

    return minTemp;
}

+(int)getBoundedMaxColorTempForMembers: (NSArray *)members
{
    int maxTemp = INT_MAX;

    for (id member in members)
    {
        if ([member isKindOfClass: [LSFSDKGroupMember class]])
        {
            maxTemp = MIN(maxTemp, [member colorTempMax]);
        }
    }

    return maxTemp;
}

@end
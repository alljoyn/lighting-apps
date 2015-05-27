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

#import "LSFSDKSceneElement.h"
#import "LSFSDKLamp.h"
#import "LSFSDKGroup.h"
#import "LSFSDKAllJoynManager.h"
#import "LSFSDKLightingItemUtil.h"
#import "LSFSDKLightingDirector.h"

@implementation LSFSDKSceneElement

-(id)initWithSceneElementID: (NSString *)sceneElementID
{
    return [self initWithSceneElementID: sceneElementID sceneElementName: nil];
}

-(id)initWithSceneElementID: (NSString *)sceneElementID sceneElementName: (NSString *)sceneElementName
{
    self = [super init];

    if (self)
    {
        sceneElementModel = [[LSFSceneElementDataModelV2 alloc] initWithSceneElementID: sceneElementID andSceneElementName: sceneElementName];
    }

    return self;
}

-(void)apply
{
    NSString *errorContext = @"LSFSDKSceneElement apply: error";

    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneElementManager] applySceneElementWithID: sceneElementModel.theID]];
}

-(void)modifyWithEffect: (id<LSFSDKEffect>)effect groupMembers: (NSArray *)members
{
    NSString *errorContext = @"LSFSDKSceneElement modify: error";

    if ([self postInvalidArgIfNull: errorContext object: effect] && [self postInvalidArgIfNull: errorContext object: members])
    {
        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneElementManager] updateSceneElementWithID: sceneElementModel.theID withSceneElement: [LSFSDKLightingItemUtil createSceneElementWithEffectID: [effect theID] groupMembers: members]]];
    }
}

-(void)addMember: (LSFSDKGroupMember *)member
{
    NSString *errorContext = @"LSFSDKSceneElement addMember: error";

    if ([self postInvalidArgIfNull: errorContext object: member])
    {
        NSMutableSet *lamps = [[NSMutableSet alloc] initWithSet: sceneElementModel.lamps];
        NSMutableSet *groups = [[NSMutableSet alloc] initWithSet: sceneElementModel.groups];

        if ([member isKindOfClass: [LSFSDKLamp class]])
        {
            [lamps addObject: member.theID];
        }
        else if ([member isKindOfClass: [LSFSDKGroup class]])
        {
            [groups addObject: member.theID];
        }

        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneElementManager] updateSceneElementWithID: sceneElementModel.theID withSceneElement: [LSFSDKLightingItemUtil createSceneElementWithEffectID: sceneElementModel.effectID lampIDs: [lamps allObjects] groupIDs: [groups allObjects]]]];
    }
}

-(void)removeMember: (LSFSDKGroupMember *)member
{
    NSString *errorContext = @"LSFSDKSceneElement removeMember: error";

    if ([self postInvalidArgIfNull: errorContext object: member])
    {
        NSMutableSet *lamps = [[NSMutableSet alloc] initWithSet: sceneElementModel.lamps];
        NSMutableSet *groups = [[NSMutableSet alloc] initWithSet: sceneElementModel.groups];

        if ([member isKindOfClass: [LSFSDKLamp class]])
        {
            [lamps removeObject: member.theID];
        }
        else if ([member isKindOfClass: [LSFSDKGroup class]])
        {
            [groups removeObject: member.theID];
        }

        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneElementManager] updateSceneElementWithID: sceneElementModel.theID withSceneElement: [LSFSDKLightingItemUtil createSceneElementWithEffectID: sceneElementModel.effectID lampIDs: [lamps allObjects] groupIDs: [groups allObjects]]]];
    }
}

-(void)deleteSceneElement
{
    NSString *errorContext = @"LSFSDKSceneElement deleteSceneElement: error";

    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneElementManager] deleteSceneElementWithID: sceneElementModel.theID]];
}

/*
 * Override base class functions
 */
-(void)rename:(NSString *)name
{
    NSString *errorContext = @"LSFSDKSceneElement rename: error";

    if ([self postInvalidArgIfNull: errorContext object: name])
    {
        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneElementManager] setSceneElementNameWithID: sceneElementModel.theID andSceneElementName: name]];
    }
}

-(LSFModel *)getItemDataModel
{
    return [self getSceneElementDataModel];
}

-(void)postError:(NSString *)name status:(LSFResponseCode)status
{
    dispatch_async([[[LSFSDKLightingDirector getLightingDirector] lightingManager] dispatchQueue], ^{
        [[[[LSFSDKLightingDirector getLightingDirector] lightingManager] sceneElementCollectionManager] sendErrorEvent: name statusCode: status itemID: sceneElementModel.theID];
    });
}

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFSceneElementDataModelV2 *)getSceneElementDataModel
{
    return sceneElementModel;
}

@end

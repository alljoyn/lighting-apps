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

#import "LSFSDKMasterScene.h"
#import "LSFSDKAllJoynManager.h"
#import "LSFSDKLightingItemUtil.h"
#import "LSFSDKLightingDirector.h"

@implementation LSFSDKMasterScene

-(id)initWithMasterSceneID: (NSString *)masterSceneID
{
    self = [super init];

    if (self)
    {
        masterSceneDataModel = [[LSFMasterSceneDataModel alloc] initWithMasterSceneID: masterSceneID];
    }

    return self;
}

-(void)apply
{
    NSString *errorContext = @"LSFSDKMasterScene apply: error";

    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] applyMasterSceneWithID: masterSceneDataModel.theID]];
}

-(void)modify: (NSArray *)scenes
{
    NSString *errorContext = @"LSFSDKMasterScene modify: error";

    if ([self postInvalidArgIfNull: errorContext object: scenes])
    {
        NSMutableArray *sceneIDs = [[NSMutableArray alloc] init];

        for (LSFSDKScene *scene in scenes)
        {
            [sceneIDs addObject: [scene theID]];
        }

        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] updateMasterSceneWithID: masterSceneDataModel.theID andMasterScene: [LSFSDKLightingItemUtil createMasterSceneFromSceneID: sceneIDs]]];
    }
}

-(void)add: (LSFSDKScene *)scene
{
    NSString *errorContext = @"LSFSDKMasterScene add: error";
    if ([self postInvalidArgIfNull: errorContext object: scene])
    {
        NSMutableSet *sceneIDsSet = [[NSMutableSet alloc] initWithArray: masterSceneDataModel.masterScene.sceneIDs];

        if (![sceneIDsSet containsObject: scene.theID])
        {
            [sceneIDsSet addObject: scene.theID];
            [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] updateMasterSceneWithID: masterSceneDataModel.theID andMasterScene: [LSFSDKLightingItemUtil createMasterSceneFromSceneID: [sceneIDsSet allObjects]]]];
        }
    }
}

-(void)remove: (LSFSDKScene *)scene
{
    NSString *errorContext = @"LSFSDKMasterScene remove: error";

    if ([self postInvalidArgIfNull: errorContext object: scene])
    {
        NSMutableSet *sceneIDsSet = [[NSMutableSet alloc] initWithArray: masterSceneDataModel.masterScene.sceneIDs];

        if ([sceneIDsSet containsObject: scene.theID])
        {
            [sceneIDsSet removeObject: scene.theID];
            [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] updateMasterSceneWithID: masterSceneDataModel.theID andMasterScene: [LSFSDKLightingItemUtil createMasterSceneFromSceneID: [sceneIDsSet allObjects]]]];
        }
    }
}

-(void)deleteMasterScene
{
    NSString *errorContext = @"LSFSDKMasterScene deleteMasterScene: error";
    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] deleteMasterSceneWithID: masterSceneDataModel.theID]];
}

/*
 * Override base class functions
 */
-(void)rename:(NSString *)name
{
    NSString *errorContext = @"LSFSDKMasterScene rename: error";

    if ([self postInvalidArgIfNull: errorContext object: name])
    {
        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getMasterSceneManager] setMasterSceneNameWithID: masterSceneDataModel.theID andMasterSceneName: name]];
    }
}

-(LSFModel *)getItemDataModel
{
    return [self getMasterSceneDataModel];
}

-(void)postError:(NSString *)name status:(LSFResponseCode)status
{
    dispatch_async([[[LSFSDKLightingDirector getLightingDirector] lightingManager] dispatchQueue], ^{
        [[[[LSFSDKLightingDirector getLightingDirector] lightingManager] masterSceneCollectionManager] sendErrorEvent: name statusCode: status itemID: masterSceneDataModel.theID];
    });
}

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFMasterSceneDataModel *)getMasterSceneDataModel
{
    return masterSceneDataModel;
}

@end

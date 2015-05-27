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

#import "LSFSDKSceneV2.h"
#import "LSFSDKAllJoynManager.h"
#import "LSFSDKLightingItemUtil.h"
#import "LSFSDKLightingDirector.h"

@implementation LSFSDKSceneV2

-(id)initWithSceneID: (NSString *)sceneID
{
    LSFSceneDataModelV2 *model = [[LSFSceneDataModelV2 alloc] initWithSceneID: sceneID];
    return [self initWithSceneDataModel: model];
}

-(id)initWithSceneDataModel: (LSFSceneDataModelV2 *)model
{
    self = [super init];

    if (self)
    {
        sceneModel = model;
    }

    return self;
}

-(void)modify: (NSArray *)sceneElements
{
    NSString *errorContext = @"LSFSDKSceneV2 modify: error";

    if ([self postInvalidArgIfNull: errorContext object: sceneElements])
    {
        NSMutableArray *sceneElementIDs = [[NSMutableArray alloc] init];
        for (LSFSDKSceneElement *sceneElement in sceneElements)
        {
            [sceneElementIDs addObject: [sceneElement theID]];
        }

        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneManager] updateSceneWithSceneElementsWithID: sceneModel.theID withSceneWithSceneElements: [LSFSDKLightingItemUtil createSceneWithSceneElements: sceneElementIDs]]];
    }
}

-(void)add: (LSFSDKSceneElement *)sceneElement
{
    NSString *errorContext = @"LSFSDKSceneV2 add: error";

    if ([self postInvalidArgIfNull: errorContext object: sceneElement])
    {
        NSMutableSet *sceneElementIDs = [[NSMutableSet alloc] initWithArray: [[sceneModel sceneWithSceneElements] sceneElements]];
        [sceneElementIDs addObject: [sceneElement theID]];

        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneManager] updateSceneWithSceneElementsWithID: sceneModel.theID withSceneWithSceneElements: [LSFSDKLightingItemUtil createSceneWithSceneElements: [sceneElementIDs allObjects]]]];
    }
}

-(void)remove: (LSFSDKSceneElement *)sceneElement
{
    NSString *errorContext = @"LSFSDKSceneV2 remove: error";

    if ([self postInvalidArgIfNull: errorContext object: sceneElement])
    {
        NSMutableSet *sceneElementIDs = [[NSMutableSet alloc] initWithArray: [[sceneModel sceneWithSceneElements] sceneElements]];
        [sceneElementIDs removeObject: [sceneElement theID]];

        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneManager] updateSceneWithSceneElementsWithID: sceneModel.theID withSceneWithSceneElements: [LSFSDKLightingItemUtil createSceneWithSceneElements: [sceneElementIDs allObjects]]]];
    }
}

/*
 * Override base class functions
 */
-(LSFModel *)getItemDataModel
{
    return [self getSceneDataModel];
}

-(void)postError:(NSString *)name status:(LSFResponseCode)status
{
    dispatch_async([[[LSFSDKLightingDirector getLightingDirector] lightingManager] dispatchQueue], ^{
        [[[[LSFSDKLightingDirector getLightingDirector] lightingManager] sceneCollectionManager] sendErrorEvent: name statusCode: status itemID: sceneModel.theID];
    });
}

/*
 * Note: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.
 */
-(LSFSceneDataModelV2 *)getSceneDataModel
{
    return sceneModel;
}

@end

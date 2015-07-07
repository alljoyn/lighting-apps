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

#import "LSFSDKHelperSceneManagerCallbackV1.h"
#import "LSFSDKLightingSystemManager.h"
#import "LSFSDKSceneV1.h"
#import "LSFSDKAllJoynManager.h"

@interface LSFSDKHelperSceneManagerCallbackV1()

@property (nonatomic, strong) LSFSDKLightingSystemManager *manager;
@property (nonatomic, strong) NSMutableDictionary *creationTrackingIDs;

-(void)postProcessSceneID: (NSString *)sceneID;
-(void)postUpdateSceneID: (NSString *)sceneID;
-(void)postUpdateSceneWithID: (NSString *)sceneID scene: (LSFScene *)scene;
-(void)postUpdateSceneNameForID: (NSString *)sceneID sceneName: (NSString *)sceneName;
-(void)postDeleteScenes: (NSArray *)sceneIDs;
-(void)postSendSceneChanged: (NSString *)sceneID;
-(void)postSendSceneInitialized: (NSString *)sceneID;

@end

@implementation LSFSDKHelperSceneManagerCallbackV1

@synthesize manager = _manager;
@synthesize creationTrackingIDs = _creationTrackingIDs;

-(id)initWithLightingSystemManager: (LSFSDKLightingSystemManager *)manager
{
    self = [super init];

    if (self)
    {
        self.manager = manager;
        self.creationTrackingIDs = [[NSMutableDictionary alloc] init];
    }

    return self;
}

/*
 * Implementation of LSFSceneManagerCallbackDelegate
 */
-(void)getAllSceneIDsReplyWithCode: (LSFResponseCode)rc andSceneIDs: (NSArray *)sceneIDs
{
    if (rc != LSF_OK)
    {
        [self.manager.sceneCollectionManagerV1 sendErrorEvent: @"getAllSceneIDsReplyCB" statusCode: rc];
    }

    for (NSString *sceneID in sceneIDs)
    {
        [self postProcessSceneID: sceneID];
    }
}

-(void)getSceneNameReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID language: (NSString *)language andName: (NSString *)sceneName
{
    if (rc != LSF_OK)
    {
        [self.manager.sceneCollectionManagerV1 sendErrorEvent: @"getSceneNameReplyCB" statusCode: rc itemID: sceneID];
    }

    [self postUpdateSceneNameForID: sceneID sceneName: sceneName];
}

-(void)getSceneVersionReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andSceneVersion: (unsigned int)sceneVersion
{
    //Currently does nothing
}

-(void)setSceneNameReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andLanguage: (NSString *)language
{
    if (rc != LSF_OK)
    {
        [self.manager.sceneCollectionManagerV1 sendErrorEvent: @"setSceneNameReplyCB" statusCode: rc itemID: sceneID];
    }

    [[LSFSDKAllJoynManager getSceneManager] getSceneNameWithID: sceneID andLanguage: self.manager.defaultLanguage];
}

-(void)scenesNameChanged: (NSArray *)sceneIDs
{
    dispatch_async(self.manager.dispatchQueue, ^{
        BOOL containsNewIDs = NO;

        for (NSString *sceneID in sceneIDs)
        {
            if ([self.manager.sceneCollectionManagerV1 hasID: sceneID])
            {
                [[LSFSDKAllJoynManager getSceneManager] getSceneNameWithID: sceneID andLanguage: self.manager.defaultLanguage];
            }
            else
            {
                containsNewIDs = YES;
            }
        }

        if (containsNewIDs)
        {
            [[LSFSDKAllJoynManager getSceneManager] getAllSceneIDs];
        }
    });
}

-(void)createSceneReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    if (rc != LSF_OK)
    {
        [self.manager.sceneCollectionManagerV1 sendErrorEvent: @"createSceneReplyCB" statusCode: rc itemID: sceneID];
    }
}

-(void)createSceneTrackingReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andTrackingID: (unsigned int)trackingID
{
    if (rc != LSF_OK)
    {
        [self.manager.sceneCollectionManagerV1 sendErrorEvent: @"createSceneTrackingReplyCB" statusCode: rc itemID: sceneID withTrackingID: [[LSFSDKTrackingID alloc] initWithValue:trackingID]];
    }
    else
    {
        LSFSDKTrackingID *myTrackingID = [[LSFSDKTrackingID alloc] initWithValue: trackingID];
        [self.creationTrackingIDs setValue: myTrackingID forKey: sceneID];
    }
}

-(void)createSceneWithSceneElementsReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andTrackingID: (unsigned int)trackingID
{
    //Currently does nothing
}

-(void)scenesCreated: (NSArray *)sceneIDs
{
    [[LSFSDKAllJoynManager getSceneManager] getAllSceneIDs];
}

-(void)updateSceneReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    if (rc != LSF_OK)
    {
        [self.manager.sceneCollectionManagerV1 sendErrorEvent: @"updateSceneReplyCB" statusCode: rc itemID: sceneID];
    }
}

-(void)updateSceneWithSceneElementsReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    //Currently does nothing
}

-(void)scenesUpdated: (NSArray *)sceneIDs
{
    for (NSString *sceneID in sceneIDs)
    {
        [[LSFSDKAllJoynManager getSceneManager] getSceneWithID: sceneID];
    }
}

-(void)deleteSceneReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    if (rc != LSF_OK)
    {
        [self.manager.sceneCollectionManagerV1 sendErrorEvent: @"deleteSceneReplyCB" statusCode: rc itemID: sceneID];
    }
}

-(void)scenesDeleted: (NSArray *)sceneIDs
{
    [self postDeleteScenes: sceneIDs];
}

-(void)getSceneReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andScene: (LSFScene *)scene
{
    if (rc != LSF_OK)
    {
        [self.manager.sceneCollectionManagerV1 sendErrorEvent: @"getSceneReplyCB" statusCode: rc itemID: sceneID];
    }

    [self postUpdateSceneWithID: sceneID scene: scene];
}

-(void)getSceneWithSceneElementsReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andSceneWithSceneElements: (LSFSceneWithSceneElements *)sceneWithSceneElements
{
    //Currently does nothing
}

-(void)applySceneReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    if (rc != LSF_OK)
    {
        [self.manager.sceneCollectionManagerV1 sendErrorEvent: @"applySceneReplyCB" statusCode: rc itemID: sceneID];
    }
}

-(void)scenesApplied: (NSArray *)sceneIDs
{
    //Currently does nothing
}

/*
 * Private function implementations
 */
-(void)postProcessSceneID: (NSString *)sceneID
{
    dispatch_async(self.manager.dispatchQueue, ^{
        BOOL hasID = [self.manager.sceneCollectionManagerV1 hasID: sceneID];
        if (!hasID)
        {
            [self postUpdateSceneID: sceneID];
            [[LSFSDKAllJoynManager getSceneManager] getSceneDataWithID: sceneID andLanguage: self.manager.defaultLanguage];
        }
    });
}

-(void)postUpdateSceneID: (NSString *)sceneID
{
    dispatch_async(self.manager.dispatchQueue, ^{
        BOOL hasID = [self.manager.sceneCollectionManagerV1 hasID: sceneID];
        if (!hasID)
        {
            [self.manager.sceneCollectionManagerV1 addSceneWithID: sceneID];
        }
    });

    [self postSendSceneChanged: sceneID];
}

-(void)postUpdateSceneWithID: (NSString *)sceneID scene: (LSFScene *)scene
{
    dispatch_async(self.manager.dispatchQueue, ^{
        LSFSceneDataModel *sceneModel = [self.manager.sceneCollectionManagerV1 getModelWithID: sceneID];

        if (sceneModel != nil)
        {
            BOOL wasInitialized = [sceneModel isInitialized];

            [sceneModel fromScene: scene];

            if (wasInitialized != [sceneModel isInitialized])
            {
                [self postSendSceneInitialized: sceneID];
            }
        }
    });

    [self postSendSceneChanged: sceneID];
}

-(void)postUpdateSceneNameForID: (NSString *)sceneID sceneName: (NSString *)sceneName
{
    dispatch_async(self.manager.dispatchQueue, ^{
        LSFSceneDataModel *sceneModel = [self.manager.sceneCollectionManagerV1 getModelWithID: sceneID];

        if (sceneModel != nil)
        {
            BOOL wasInitialized = [sceneModel isInitialized];

            sceneModel.name = sceneName;

            if (wasInitialized != [sceneModel isInitialized])
            {
                [self postSendSceneInitialized: sceneID];
            }
        }
    });

    [self postSendSceneChanged: sceneID];
}

-(void)postDeleteScenes: (NSArray *)sceneIDs
{
    dispatch_async(self.manager.dispatchQueue, ^{
        for (NSString *sceneID in sceneIDs)
        {
            [self.manager.sceneCollectionManagerV1 removeSceneWithID: sceneID];
        }
    });
}

-(void)postSendSceneChanged: (NSString *)sceneID
{
    dispatch_async(self.manager.dispatchQueue, ^{
        [self.manager.sceneCollectionManagerV1 sendChangedEvent: sceneID];
    });
}

-(void)postSendSceneInitialized: (NSString *)sceneID
{
    dispatch_async(self.manager.dispatchQueue, ^{
        LSFSDKTrackingID *trackingID = [self.creationTrackingIDs valueForKey: sceneID];

        if (trackingID != nil)
        {
            [self.creationTrackingIDs removeObjectForKey: sceneID];
        }

        [self.manager.sceneCollectionManagerV1 sendInitializedEvent: sceneID withTrackingID: trackingID];
    });
}

@end

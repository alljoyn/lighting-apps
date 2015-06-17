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

#import "LSFSDKHelperSceneManagerCallback.h"

@interface LSFSDKHelperSceneManagerCallback()

@property (nonatomic, strong) NSArray *sceneManagerCBs;

@end

@implementation LSFSDKHelperSceneManagerCallback

@synthesize sceneManagerCBs = _sceneManagerCBs;

-(id)initWithSceneManagerCallbacks: (NSArray *)sceneManagerCBs
{
    self = [super init];

    if (self)
    {
        self.sceneManagerCBs = sceneManagerCBs;
    }

    return self;
}

/*
 * Implementation of LSFSceneManagerCallbackDelegate
 */
-(void)getAllSceneIDsReplyWithCode: (LSFResponseCode)rc andSceneIDs: (NSArray *)sceneIDs
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate getAllSceneIDsReplyWithCode: rc andSceneIDs: sceneIDs];
    }
}

-(void)getSceneNameReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID language: (NSString *)language andName: (NSString *)sceneName
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate getSceneNameReplyWithCode: rc sceneID: sceneID language: language andName: sceneName];
    }
}

-(void)getSceneVersionReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andSceneVersion: (unsigned int)sceneVersion
{
    //TODO - unsused at this time
}

-(void)setSceneNameReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andLanguage: (NSString *)language
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate setSceneNameReplyWithCode: rc sceneID: sceneID andLanguage: language];
    }
}

-(void)scenesNameChanged: (NSArray *)sceneIDs
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate scenesNameChanged: sceneIDs];
    }
}

-(void)createSceneReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate createSceneReplyWithCode: rc andSceneID: sceneID];
    }
}

-(void)createSceneTrackingReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andTrackingID: (unsigned int)trackingID
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate createSceneTrackingReplyWithCode: rc sceneID: sceneID andTrackingID: trackingID];
    }
}

-(void)createSceneWithSceneElementsReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andTrackingID: (unsigned int)trackingID
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate createSceneWithSceneElementsReplyWithCode: rc sceneID: sceneID andTrackingID: trackingID];
    }
}

-(void)scenesCreated: (NSArray *)sceneIDs
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate scenesCreated: sceneIDs];
    }
}

-(void)updateSceneReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate updateSceneReplyWithCode: rc andSceneID: sceneID];
    }
}

-(void)updateSceneWithSceneElementsReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate updateSceneWithSceneElementsReplyWithCode: rc andSceneID: sceneID];
    }
}

-(void)scenesUpdated: (NSArray *)sceneIDs
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate scenesUpdated: sceneIDs];
    }
}

-(void)deleteSceneReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate deleteSceneReplyWithCode: rc andSceneID: sceneID];
    }
}

-(void)scenesDeleted: (NSArray *)sceneIDs
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate scenesDeleted: sceneIDs];
    }
}

-(void)getSceneReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andScene: (LSFScene *)scene
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate getSceneReplyWithCode: rc sceneID: sceneID andScene: scene];
    }
}

-(void)getSceneWithSceneElementsReplyWithCode: (LSFResponseCode)rc sceneID: (NSString *)sceneID andSceneWithSceneElements: (LSFSceneWithSceneElements *)sceneWithSceneElements
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate getSceneWithSceneElementsReplyWithCode: rc sceneID: sceneID andSceneWithSceneElements: sceneWithSceneElements];
    }
}

-(void)applySceneReplyWithCode: (LSFResponseCode)rc andSceneID: (NSString *)sceneID
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate applySceneReplyWithCode: rc andSceneID: sceneID];
    }
}

-(void)scenesApplied: (NSArray *)sceneIDs
{
    for (id<LSFSceneManagerCallbackDelegate> delegate in self.sceneManagerCBs)
    {
        [delegate scenesApplied: sceneIDs];
    }
}

@end

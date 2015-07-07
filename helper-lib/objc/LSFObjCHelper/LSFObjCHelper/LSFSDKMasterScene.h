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

#import "LSFSDKLightingItem.h"
#import "LSFSDKScene.h"
#import "model/LSFMasterSceneDataModel.h"

@interface LSFSDKMasterScene : LSFSDKLightingItem
{
    @protected LSFMasterSceneDataModel *masterSceneDataModel;
}

-(id)initWithMasterSceneID: (NSString *)masterSceneID;
-(void)apply;
-(void)modify: (NSArray *)scenes;
-(void)add: (LSFSDKScene *)scene;
-(void)remove: (LSFSDKScene *)scene;
-(void)deleteItem;
-(NSArray *)getScenes;
-(BOOL)hasScene: (LSFSDKScene *)scene;
-(BOOL)hasSceneWithID: (NSString *)sceneID;

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFMasterSceneDataModel *)getMasterSceneDataModel;

@end
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

#import "LSFSDKSceneCollectionManager.h"
#import "LSFSDKSceneV1.h"
#import "LSFSDKSceneDelegate.h"

@interface LSFSDKSceneCollectionManagerV1 : LSFSDKSceneCollectionManager

-(id)init;
-(void)addSceneDelegate: (id<LSFSDKSceneDelegate>)sceneDelegate;
-(void)removeSceneDelegate: (id<LSFSDKSceneDelegate>)sceneDelegate;
-(LSFSDKSceneV1 *)addSceneWithID: (NSString *)sceneID;
-(LSFSDKSceneV1 *)addSceneWithModel: (LSFSceneDataModel *)sceneModel;
-(LSFSDKSceneV1 *)addSceneWithID: (NSString *)sceneID scene: (LSFSDKSceneV1 *)scene;
-(LSFSDKSceneV1 *)getSceneWithID: (NSString *)sceneID;
-(NSArray *)getScenes;
-(NSArray *)getScenesWithFilter: (id<LSFSDKLightingItemFilter>)filter;
-(NSArray *)getScenesCollectionWithFilter: (id<LSFSDKLightingItemFilter>)filter;
-(NSArray *)removeAllScenes;
-(LSFSDKSceneV1 *)removeSceneWithID: (NSString *)sceneID;
-(LSFSceneDataModel *)getModelWithID: (NSString *)sceneID;

@end

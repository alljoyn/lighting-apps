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

#import "LSFSDKScene.h"
#import "LSFSDKSceneElement.h"
#import "model/LSFSceneDataModelV2.h"

@interface LSFSDKSceneV2 : LSFSDKScene
{
    @protected LSFSceneDataModelV2 *sceneModel;
}

-(instancetype)init NS_UNAVAILABLE;
-(void)modify: (NSArray *)sceneElements;
-(void)add: (LSFSDKSceneElement *)sceneElement;
-(void)remove: (LSFSDKSceneElement *)sceneElement;
-(BOOL)hasSceneElement: (LSFSDKSceneElement *)sceneElement;
-(BOOL)hasSceneElementWithID: (NSString *)sceneElementID;
-(NSArray *)getSceneElementIDs;
-(NSArray *)getSceneElements;

/*
 * Note: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.
 */
-(LSFSceneDataModelV2 *)getSceneDataModel;

@end

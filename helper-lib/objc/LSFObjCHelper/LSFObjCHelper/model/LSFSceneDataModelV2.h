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

#import "LSFModel.h"
#import <internal/LSFSceneWithSceneElements.h>

extern const NSString *SCENE_DEFAULT_NAME;

@interface LSFSceneDataModelV2 : LSFModel
{
    @protected BOOL sceneWithSceneElementsInitialized;
}

@property (nonatomic, strong) LSFSceneWithSceneElements *sceneWithSceneElements;

-(id)init;
-(id)initWithSceneID: (NSString *)sceneID;
-(id)initWithSceneID: (NSString *)sceneID sceneName: (NSString *)sceneName;
-(BOOL)containsSceneElement: (NSString *)sceneElementID;

@end
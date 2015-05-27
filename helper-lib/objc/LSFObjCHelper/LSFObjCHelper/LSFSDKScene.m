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
#import "LSFSDKAllJoynManager.h"

@implementation LSFSDKScene

-(void)apply
{
    NSString *errorContext = @"LSFSDKScene apply: error";

    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneManager] applySceneWithID: [self theID]]];
}

-(void)deleteScene
{
    NSString *errorContext = @"LSFSDKScene delete: error";

    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneManager] deleteSceneWithID: [self theID]]];
}

/*
 * Override base class functions
 */
-(void)rename:(NSString *)name
{
    NSString *errorContext = @"LSFSDKScene rename: error";

    if ([self postInvalidArgIfNull: errorContext object: name])
    {
        [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneManager] setSceneNameWithID: [self theID] andSceneName: name]];
    }
}

@end

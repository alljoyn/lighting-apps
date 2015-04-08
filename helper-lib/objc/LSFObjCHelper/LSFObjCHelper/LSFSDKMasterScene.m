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

@interface LSFSDKMasterScene()

@property (nonatomic, strong) LSFMasterSceneDataModel *masterSceneDataModel;

@end

@implementation LSFSDKMasterScene

@synthesize masterSceneDataModel = _masterSceneDataModel;

-(id)initWithMasterSceneID: (NSString *)masterSceneID
{
    self = [super init];

    if (self)
    {
        self.masterSceneDataModel = [[LSFMasterSceneDataModel alloc] initWithID: masterSceneID];
    }

    return self;
}

-(void)apply
{
    NSLog(@"LSFMasterScene - apply() executing");

    //LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    //[ajManager.lsfMasterSceneManager applyMasterSceneWithID: self.masterSceneDataModel.theID];
}

-(void)modify: (NSArray *)scenes
{
    //TODO - implement
}

-(void)add: (LSFSDKScene *)scene
{
    //TODO - implement
}

-(void)remove: (LSFSDKScene *)scene
{
    //TODO - implement
}

-(void)deleteMasterScene
{
    //TODO - implement
}

/*
 * Override base class functions
 */
-(void)rename:(NSString *)name
{
    //TODO - implement
}

-(LSFModel *)getItemDataModel
{
    return [self getMasterSceneDataModel];
}

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFMasterSceneDataModel *)getMasterSceneDataModel
{
    return self.masterSceneDataModel;
}

@end

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

#import "LSFLightingDirector.h"
#import "LSFLamp.h"
#import "LSFGroup.h"
#import "LSFLightingScene.h"
#import "LSFLightingSystemManager.h"
#import "LSFLampModelContainer.h"
#import "LSFGroupModelContainer.h"
#import "LSFSceneModelContainer.h"
#import "LSFAllJoynManager.h"

@interface LSFLightingDirector()

@property (nonatomic, strong) LSFLightingSystemManager *lightingManager;

@end

@implementation LSFLightingDirector

@synthesize version = _version;
@synthesize busAttachment = _busAttachment;
@synthesize lightingManager = _lightingManager;

-(id)init
{
    self = [super init];

    if (self)
    {
        self.lightingManager = [LSFLightingSystemManager getLightingSystemManager];
        _version = 1;
    }

    return self;
}

-(void)start
{
    [self.lightingManager start];
}

-(void)stop
{
    [self.lightingManager stop];
}

-(AJNBusAttachment *)busAttachment
{
    return [[LSFAllJoynManager getAllJoynManager] bus];
}

-(NSArray *)getLamps
{
    NSMutableDictionary *lamps = [[LSFLampModelContainer getLampModelContainer] lampContainer];
    return [lamps allValues];
}

-(NSArray *)getGroups
{
    NSMutableDictionary *groups = [[LSFGroupModelContainer getGroupModelContainer] groupContainer];
    return [groups allValues];
}

-(NSArray *)getScenes
{
    NSMutableDictionary *scenes = [[LSFSceneModelContainer getSceneModelContainer] sceneContainer];
    return [scenes allValues];
}

-(void)postOnNextControllerConnection: (id<LSFNextControllerConnectionDelegate>)delegate
{
    [self.lightingManager postOnNextControllerConnection: delegate];
}

@end

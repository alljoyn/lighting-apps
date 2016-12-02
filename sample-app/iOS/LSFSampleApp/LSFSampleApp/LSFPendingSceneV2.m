/******************************************************************************
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 ******************************************************************************/

#import "LSFPendingSceneV2.h"
#import "LSFPendingSceneElement.h"
#import <LSFSDKLightingDirector.h>

@implementation LSFPendingSceneV2

@synthesize pendingSceneElements = _pendingSceneElements;

-(id)init
{
    self = [super init];

    if (self)
    {
        _pendingSceneElements = nil;
    }

    return self;
}

-(id)initFromSceneID: (NSString *)sceneID
{
    self = [super init];

    LSFSDKScene *scene = [[LSFSDKLightingDirector getLightingDirector] getSceneWithID: sceneID];

    if (scene && [scene isKindOfClass: [LSFSDKSceneV2 class]])
    {
        LSFSDKSceneV2 *sceneV2 = (LSFSDKSceneV2 *) scene;

        self.theID = sceneV2.theID;
        self.name = sceneV2.name;

        self.pendingSceneElements = [[NSMutableArray alloc] init];
        for (LSFSDKSceneElement *element in [sceneV2 getSceneElements])
        {
            NSString *elementID = element.theID;
            [self.pendingSceneElements addObject: [[LSFPendingSceneElement alloc] initFromSceneElementID: elementID]];
        }
    }
    else
    {
        NSLog(@"SceneV2 not found in Lighting Director. Returning default pending object");
    }

    return self;
}

-(BOOL)hasValidSceneElements
{
    if (self.pendingSceneElements)
    {
        for (LSFPendingSceneElement *elem in self.pendingSceneElements)
        {
            if (!elem.theID)
            {
                return NO;
            }
        }
    }

    return YES;
}

@end
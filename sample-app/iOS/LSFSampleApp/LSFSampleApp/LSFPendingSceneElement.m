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

#import "LSFPendingSceneElement.h"
#import <LSFSDKLightingDirector.h>

@implementation LSFPendingSceneElement

@synthesize members = _members;
@synthesize pendingEffect = _pendingEffect;
@synthesize capability = _capability;
@synthesize hasEffect = _hasEffect;

-(id)init
{
    self = [super init];

    if (self)
    {
        _members = nil;
        _pendingEffect = nil;
        _capability = nil;
        _hasEffect = NO;
    }

    return self;
}

-(id)initFromSceneElementID: (NSString *)sceneElementID
{
    self = [self init];

    LSFSDKSceneElement *element = [[LSFSDKLightingDirector getLightingDirector] getSceneElementWithID: sceneElementID];

    if (element)
    {
        self.theID = element.theID;
        self.name = element.name;

        self.pendingEffect = [[LSFPendingEffect alloc] initFromEffectID: [[element getEffect] theID]];

        self.members = [NSMutableArray arrayWithArray: [element getGroups]];
        [self.members addObjectsFromArray: [element getLamps]];

        self.capability = [[LSFSDKCapabilityData alloc] init];

        for (LSFSDKGroupMember *member in self.members)
        {
            [self.capability includeData: [member getCapabilities]];

            if ([member isKindOfClass: [LSFSDKLamp class]])
            {
                self.hasEffect = self.hasEffect || ((LSFSDKLamp *)member).details.hasEffects;
            }
            else if ([member isKindOfClass: [LSFSDKGroup class]])
            {
                for (LSFSDKLamp *lamp in [((LSFSDKGroup *) member) getLamps])
                {
                    self.hasEffect = self.hasEffect || lamp.details.hasEffects;
                }
            }
        }
    }
    else
    {
        NSLog(@"SceneElement not found in Lighting Director. Returning default pending object");
    }

    return self;
}

@end
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

#import "LSFSDKScene.h"
#import "LSFSDKLightingDirector.h"
#import "LSFSDKLightingItemHasComponentFilter.h"
#import "manager/LSFSDKAllJoynManager.h"

@implementation LSFSDKScene

-(void)apply
{
    NSString *errorContext = @"LSFSDKScene apply: error";

    [self postErrorIfFailure: errorContext status: [[LSFSDKAllJoynManager getSceneManager] applySceneWithID: [self theID]]];
}

-(void)deleteItem
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

-(NSArray *) getDependentCollection
{
    LSFSDKLightingDirector *director = [LSFSDKLightingDirector getLightingDirector];

    NSMutableArray *dependents = [[NSMutableArray alloc] init];
    [dependents addObjectsFromArray: [[[director lightingManager] masterSceneCollectionManager] getMasterScenesCollectionWithFilter: [[LSFSDKLightingItemHasComponentFilter alloc] initWithComponent: self]]];

    return [NSArray arrayWithArray: dependents];
}

@end
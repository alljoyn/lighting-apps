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

#import "LSFSDKSceneElement+Init.h"

@implementation LSFSDKSceneElement (Init)

-(id)initWithSceneElementID: (NSString *)sceneElementID
{
    return [self initWithSceneElementID: sceneElementID sceneElementName: nil];
}

-(id)initWithSceneElementID: (NSString *)sceneElementID sceneElementName: (NSString *)sceneElementName
{
    self = [super init];

    if (self)
    {
        sceneElementModel = [[LSFSceneElementDataModelV2 alloc] initWithSceneElementID: sceneElementID andSceneElementName: sceneElementName];
    }

    return self;
}

@end
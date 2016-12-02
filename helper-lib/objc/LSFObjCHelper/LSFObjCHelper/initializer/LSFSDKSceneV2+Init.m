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

#import "LSFSDKSceneV2+Init.h"

@implementation LSFSDKSceneV2 (Init)

-(id)initWithSceneID: (NSString *)sceneID
{
    LSFSceneDataModelV2 *model = [[LSFSceneDataModelV2 alloc] initWithSceneID: sceneID];
    return [self initWithSceneDataModel: model];
}

-(id)initWithSceneDataModel: (LSFSceneDataModelV2 *)model
{
    self = [super init];

    if (self)
    {
        sceneModel = model;
    }

    return self;
}

@end
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

#import "LSFSDKMasterScene+Init.h"

@implementation LSFSDKMasterScene (Init)

-(id)initWithMasterSceneID: (NSString *)masterSceneID
{
    self = [super init];

    if (self)
    {
        masterSceneDataModel = [[LSFMasterSceneDataModel alloc] initWithMasterSceneID: masterSceneID];
    }

    return self;
}

@end
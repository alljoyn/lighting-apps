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

#import "LSFSDKPreset+Init.h"

@implementation LSFSDKPreset (Init)

-(id)initWithPresetID: (NSString *)presetID
{
    return [self initWithPresetID: presetID andName: nil];
}

-(id)initWithPresetID: (NSString *)presetID andName: (NSString *)presetName
{
    self = [super init];

    if (self)
    {
        presetModel = [[LSFPresetModel alloc] initWithPresetID: presetID andName: presetName];
    }

    return self;
}

@end
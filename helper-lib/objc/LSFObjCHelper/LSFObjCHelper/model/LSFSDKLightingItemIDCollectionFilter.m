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

#import "LSFSDKLightingItemIDCollectionFilter.h"

@implementation LSFSDKLightingItemIDCollectionFilter

@synthesize itemIDs = _itemIDs;

-(id)initWithItemIDs: (NSArray *)IDs;
{
    self = [super init];

    if (self)
    {
        //Intentionally left blank
        self.itemIDs = IDs;
    }

    return self;
}

-(BOOL)passes: (LSFSDKLightingItem *)item
{
    return [self.itemIDs containsObject: item.theID];
}

@end
/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
 *    
 *    SPDX-License-Identifier: Apache-2.0
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *    
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *    
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *    
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
******************************************************************************/

#import "LSFMasterScene.h"
#import "LSFUtils.h"
#import <LSFTypes.h>

@interface LSFMasterScene()

@property (nonatomic, readonly) lsf::MasterScene *masterScene;

@end

@implementation LSFMasterScene

@synthesize masterScene = _masterScene;

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.handle = new lsf::MasterScene();
    }
    
    return self;
}

-(id)initWithSceneIDs: (NSArray *)sceneIDs
{
    self = [super init];
    
    if (self)
    {
        lsf::LSFStringList sceneIDList = [LSFUtils convertNSArrayToStringList: sceneIDs];
        self.handle = new lsf::MasterScene(sceneIDList);
    }
    
    return self;
}

-(void)setSceneIDs:(NSArray *)sceneIDs
{
    self.masterScene->scenes = [LSFUtils convertNSArrayToStringList: sceneIDs];
}

-(NSArray *)sceneIDs
{
    return [LSFUtils convertStringListToNSArray: self.masterScene->scenes];
}

-(LSFResponseCode)isDependentOnScene: (NSString *)sceneID
{
    std::string sid([sceneID UTF8String]);
    return self.masterScene->IsDependentOnScene(sid);
}

/*
 * Accessor for the internal C++ API object this objective-c class encapsulates
 */
- (lsf::MasterScene *)masterScene
{
    return static_cast<lsf::MasterScene*>(self.handle);
}

@end
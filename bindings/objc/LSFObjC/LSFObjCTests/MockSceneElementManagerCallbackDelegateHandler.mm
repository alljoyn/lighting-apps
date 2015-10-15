/******************************************************************************
 *  * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
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
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "MockSceneElementManagerCallbackDelegateHandler.h"

@interface MockSceneElementManagerCallbackDelegateHandler()

@property (nonatomic) NSMutableArray *dataArray;

@end

@implementation MockSceneElementManagerCallbackDelegateHandler

@synthesize dataArray = _dataArray;

-(id)init
{
    self = [super init];

    if (self)
    {
        self.dataArray = [[NSMutableArray alloc] init];
    }

    return self;
}

-(NSArray *)getCallbackData
{
    return self.dataArray;
}

//Delegate methods
-(void)getAllSceneElementIDsReplyWithCode: (LSFResponseCode)rc andSceneElementIDs: (NSArray *)sceneElementIDs
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"getAllSceneElementIDs"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementIDs];
}

-(void)getSceneElementNameReplyWithCode: (LSFResponseCode)rc sceneElementID: (NSString *)sceneElementID language: (NSString *)language andSceneElementName: (NSString *)sceneElementName
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"getSceneElementName"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];
    [self.dataArray addObject: language];
    [self.dataArray addObject: sceneElementName];
}

-(void)setSceneElementNameReplyWithCode: (LSFResponseCode)rc sceneElementID: (NSString *)sceneElementID andLanguage: (NSString *)language
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"setSceneElementName"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];
    [self.dataArray addObject: language];
}

-(void)sceneElementsNameChanged: (NSArray *)sceneElementIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"sceneElementsNameChanged"];
    [self.dataArray addObject: sceneElementIDs];
}

-(void)createSceneElementReplyWithCode: (LSFResponseCode)rc sceneElementID: (NSString *)sceneElementID andTrackingID: (unsigned int)trackingID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    NSNumber *tid = [[NSNumber alloc] initWithUnsignedInt: trackingID];
    [self.dataArray addObject: @"createSceneElement"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];
    [self.dataArray addObject: tid];
}

-(void)sceneElementsCreated: (NSArray *)sceneElementIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"sceneElementsCreated"];
    [self.dataArray addObject: sceneElementIDs];
}

-(void)updateSceneElementReplyWithCode: (LSFResponseCode)rc andSceneElementID: (NSString *)sceneElementID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"updateSceneElement"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];
}

-(void)sceneElementsUpdated: (NSArray *)sceneElementIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"sceneElementsUpdated"];
    [self.dataArray addObject: sceneElementIDs];
}

-(void)deleteSceneElementReplyWithCode: (LSFResponseCode)rc andSceneElementID: (NSString *)sceneElementID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"deleteSceneElement"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];
}

-(void)sceneElementsDeleted: (NSArray *)sceneElementIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"sceneElementsDeleted"];
    [self.dataArray addObject: sceneElementIDs];
}

-(void)getSceneElementReplyWithCode: (LSFResponseCode)rc sceneElementID: (NSString *)sceneElementID andSceneElement: (LSFSceneElement *)sceneElement
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"getSceneElement"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];
    [self.dataArray addObject: sceneElement.lamps];
    [self.dataArray addObject: sceneElement.lampGroups];
    [self.dataArray addObject: sceneElement.effectID];
}

-(void)applySceneElementReplyWithCode: (LSFResponseCode)rc andSceneElementID: (NSString *)sceneElementID
{
    [self.dataArray removeAllObjects];
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: rc];
    [self.dataArray addObject: @"applySceneElement"];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];
}

-(void)sceneElementsApplied: (NSArray *)sceneElementIDs
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject: @"sceneElementsApplied"];
    [self.dataArray addObject: sceneElementIDs];
}

@end
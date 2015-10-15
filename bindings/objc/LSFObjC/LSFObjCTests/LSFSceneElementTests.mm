/******************************************************************************
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
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

#import "LSFSceneElementTests.h"
#import <internal/LSFSceneElement.h>
#import <alljoyn/Init.h>

@interface LSFSceneElementTests()

@property (nonatomic) LSFSceneElement *sceneElement;

@end

@implementation LSFSceneElementTests

@synthesize sceneElement = _sceneElement;

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    AllJoynInit();
    self.sceneElement = [[LSFSceneElement alloc] init];
}

-(void)tearDown
{
    self.sceneElement = nil;
    AllJoynShutdown();

    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testNoArgConstructor
{
    XCTAssertTrue((self.sceneElement.lamps.count == 0), @"Lamp IDs should be empty");
    XCTAssertTrue((self.sceneElement.lampGroups.count == 0), @"Lamp Group IDs should be empty");
    XCTAssertTrue([self.sceneElement.effectID isEqualToString: @""], @"Effect ID should be an empty string");
}

-(void)testConstructorWithArguments
{
    NSArray *lampIDs = [NSArray arrayWithObjects: @"lampID1", @"lampID2", @"lampID3", nil];
    NSArray *lampGroupIDs = [NSArray arrayWithObjects: @"lampGroupID1", @"lampGroupID2", nil];
    NSString *effectID = @"testEffectID";

    self.sceneElement = [[LSFSceneElement alloc] initWithLampIDs: lampIDs lampGroupIDs: lampGroupIDs andEffectID: effectID];

    XCTAssertTrue((self.sceneElement.lamps.count == 3), @"Lamp IDs should be 3");
    XCTAssertTrue([self.sceneElement.lamps isEqualToArray: lampIDs], @"Lamp IDs array should be equal");
    XCTAssertTrue((self.sceneElement.lampGroups.count == 2), @"Lamp Group IDs should be 2");
    XCTAssertTrue([self.sceneElement.lampGroups isEqualToArray: lampGroupIDs], @"Lamp Group IDs array should be equal");
    XCTAssertTrue([self.sceneElement.effectID isEqualToString: effectID], @"Effect ID should be an equal");
}

-(void)testSetGetLamps
{
    XCTAssertTrue((self.sceneElement.lamps.count == 0), @"Lamp IDs should be empty");

    NSArray *lampIDs = [NSArray arrayWithObjects: @"lampID1", @"lampID2", @"lampID3", nil];
    self.sceneElement.lamps = lampIDs;

    XCTAssertTrue((self.sceneElement.lamps.count == 3), @"Lamp IDs should be 3");
    XCTAssertTrue([self.sceneElement.lamps isEqualToArray: lampIDs], @"Lamp IDs array should be equal");
}

-(void)testSetGetLampGroups
{
    XCTAssertTrue((self.sceneElement.lampGroups.count == 0), @"Lamp Group IDs should be empty");

    NSArray *lampGroupIDs = [NSArray arrayWithObjects: @"lampGroupID1", @"lampGroupID2", nil];
    self.sceneElement.lampGroups = lampGroupIDs;

    XCTAssertTrue((self.sceneElement.lampGroups.count == 2), @"Lamp Group IDs should be 2");
    XCTAssertTrue([self.sceneElement.lampGroups isEqualToArray: lampGroupIDs], @"Lamp Group IDs array should be equal");
}

-(void)testSetGetEffectID
{
    XCTAssertTrue([self.sceneElement.effectID isEqualToString: @""], @"Effect ID should be an empty string");

    NSString *effectID = @"testEffectID";
    self.sceneElement.effectID = effectID;

    XCTAssertTrue([self.sceneElement.effectID isEqualToString: effectID], @"Effect ID should be an equal");
}

@end
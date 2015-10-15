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

#import "LSFSceneWithSceneElementsTests.h"
#import <internal/LSFSceneWithSceneElements.h>
#import <alljoyn/Init.h>

@interface LSFSceneWithSceneElementsTests()

@property (nonatomic) LSFSceneWithSceneElements *sceneWithSceneElements;

@end

@implementation LSFSceneWithSceneElementsTests

@synthesize sceneWithSceneElements = _sceneWithSceneElements;

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    AllJoynInit();
    self.sceneWithSceneElements = [[LSFSceneWithSceneElements alloc] init];
}

-(void)tearDown
{
    self.sceneWithSceneElements = nil;
    AllJoynShutdown();

    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testNoArgConstructor
{
    XCTAssertTrue((self.sceneWithSceneElements.sceneElements.count == 0), @"Scene Element IDs should be empty");
}

-(void)testConstructorWithArguments
{
    NSArray *sceneElementIDs = [NSArray arrayWithObjects: @"sceneElementID1", @"sceneElementID2", @"sceneElementID3", nil];

    self.sceneWithSceneElements = [[LSFSceneWithSceneElements alloc] initWithSceneElementIDs: sceneElementIDs];

    XCTAssertTrue((self.sceneWithSceneElements.sceneElements.count == 3), @"Scene Element IDs should be 3");
    XCTAssertTrue([self.sceneWithSceneElements.sceneElements isEqualToArray: sceneElementIDs], @"Scene Element IDs should be equal");
}

-(void)testSetGetSceneElementIDs
{
    XCTAssertTrue((self.sceneWithSceneElements.sceneElements.count == 0), @"Scene Element IDs should be empty");

    NSArray *sceneElementIDs = [NSArray arrayWithObjects: @"sceneElementID1", @"sceneElementID2", @"sceneElementID3", nil];
    self.sceneWithSceneElements.sceneElements = sceneElementIDs;

    XCTAssertTrue((self.sceneWithSceneElements.sceneElements.count == 3), @"Scene Element IDs should be 3");
    XCTAssertTrue([self.sceneWithSceneElements.sceneElements isEqualToArray: sceneElementIDs], @"Scene Element IDs should be equal");
}

-(void)testIsDependentOnSceneElementID
{
    NSString *sceneElementID1 = @"sceneElementID1";
    NSString *sceneElementID2 = @"sceneElementID2";
    NSString *sceneElementID3 = @"sceneElementID3";
    NSString *nondependentSceneElementID = @"nondependentSceneElementID";
    NSArray *sceneElementIDs = [NSArray arrayWithObjects: sceneElementID1, sceneElementID2, sceneElementID3, nil];

    self.sceneWithSceneElements = [[LSFSceneWithSceneElements alloc] initWithSceneElementIDs: sceneElementIDs];

    LSFResponseCode status = [self.sceneWithSceneElements isDependentOnSceneElementWithID: sceneElementID1];
    XCTAssertTrue(status == LSF_ERR_DEPENDENCY, @"Status should be LSF_ERR_DEPENDENCY");

    status = [self.sceneWithSceneElements isDependentOnSceneElementWithID: sceneElementID2];
    XCTAssertTrue(status == LSF_ERR_DEPENDENCY, @"Status should be LSF_ERR_DEPENDENCY");

    status = [self.sceneWithSceneElements isDependentOnSceneElementWithID: sceneElementID3];
    XCTAssertTrue(status == LSF_ERR_DEPENDENCY, @"Status should be LSF_ERR_DEPENDENCY");

    status = [self.sceneWithSceneElements isDependentOnSceneElementWithID: nondependentSceneElementID];
    XCTAssertTrue(status == LSF_OK, @"Status should be LSF_OK");
}

@end
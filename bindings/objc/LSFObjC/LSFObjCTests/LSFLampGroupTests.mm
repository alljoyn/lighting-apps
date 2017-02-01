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

#import "LSFLampGroupTests.h"
#import <internal/LSFLampGroup.h>

@interface LSFLampGroupTests()

@property (nonatomic) LSFLampGroup *lampGroup;

@end

@implementation LSFLampGroupTests

@synthesize lampGroup = _lampGroup;

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.lampGroup = [[LSFLampGroup alloc] init];
}

-(void)tearDown
{
    self.lampGroup = nil;
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testBasicSet
{
    NSArray *lampIDs = [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", nil];
    NSArray *lampGroupIDs = [NSArray arrayWithObjects: @"F", @"G", @"H", nil];

    [self.lampGroup setLamps: lampIDs];
    [self.lampGroup setLampGroups: lampGroupIDs];

    XCTAssertTrue([[self.lampGroup lamps] isEqualToArray: lampIDs], @"Start and end lamp IDs should be equal");
    XCTAssertTrue([[self.lampGroup lampGroups] isEqualToArray: lampGroupIDs], @"Start and end lamp group IDs should be equal");
}

-(void)testDoubleSet
{
    NSArray *lampIDs = [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", nil];
    NSArray *lampGroupIDs = [NSArray arrayWithObjects: @"F", @"G", @"H", nil];

    [self.lampGroup setLamps: lampIDs];
    [self.lampGroup setLampGroups: lampGroupIDs];

    [self.lampGroup setLamps: lampIDs];
    [self.lampGroup setLampGroups: lampGroupIDs];

    XCTAssertTrue([[self.lampGroup lamps] isEqualToArray: lampIDs], @"Start and end lamp IDs should be equal");
    XCTAssertTrue([[self.lampGroup lampGroups] isEqualToArray: lampGroupIDs], @"Start and end lamp group IDs should be equal");
}

-(void)testIsDependentGroup;
{
    NSString *lampGroupID1 = @"lampGroupID1";
    NSString *lampGroupID2 = @"lampGroupID2";
    NSString *nonDependentGroupID = @"nonDependentGroupID";
    
    NSArray *setLampGroupIDs = [NSArray arrayWithObjects: lampGroupID1, lampGroupID2, nil];
    [self.lampGroup setLampGroups: setLampGroupIDs];
    
    LSFResponseCode code;
    code = [self.lampGroup isDependentLampGroup: lampGroupID1];
    XCTAssertTrue(code == LSF_ERR_DEPENDENCY, @"Response code should be equal to LSF_ERR_DEPENDENCY");
    
    code = [self.lampGroup isDependentLampGroup: lampGroupID2];
    XCTAssertTrue(code == LSF_ERR_DEPENDENCY, @"Response code should be equal to LSF_ERR_DEPENDENCY");
    
    code = [self.lampGroup isDependentLampGroup: nonDependentGroupID];
    XCTAssertTrue(code == LSF_OK, @"Response code should be equal to LSF_OK");
}

@end
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

#import "LSFSceneElementManagerCallbackTests.h"
#import "MockSceneElementManagerCallbackDelegateHandler.h"
#import <internal/LSFSceneElementManagerCallback.h>
#import <alljoyn/Init.h>

@interface LSFSceneElementManagerCallbackTests()

@property (nonatomic) MockSceneElementManagerCallbackDelegateHandler *semcdh;
@property (nonatomic) LSFSceneElementManagerCallback *semc;
@property (nonatomic) NSMutableArray *dataArray;

@end

@implementation LSFSceneElementManagerCallbackTests

@synthesize semcdh = _semcdh;
@synthesize semc = _semc;
@synthesize dataArray = _dataArray;

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    AllJoynInit();
    self.semcdh = [[MockSceneElementManagerCallbackDelegateHandler alloc] init];
    self.semc = new LSFSceneElementManagerCallback(self.semcdh);
    self.dataArray = [[NSMutableArray alloc] init];
}

-(void)tearDown
{
    delete self.semc;
    self.semcdh = nil;
    AllJoynShutdown();

    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testGetAllSceneElementIDs
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *functionName = @"getAllSceneElementIDs";
    NSString *sceneElementID1 = @"sceneElementID1";
    NSString *sceneElementID2 = @"sceneElementID2";
    NSString *sceneElementID3 = @"sceneElementID3";
    NSString *sceneElementID4 = @"sceneElementID4";
    NSArray *sceneElementIDsArray = [[NSArray alloc] initWithObjects: sceneElementID1, sceneElementID2, sceneElementID3, sceneElementID4, nil];

    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: sceneElementIDsArray];

    //Call callback method
    LSFStringList sceneElementIDList;
    std::string id1([sceneElementID1 UTF8String]);
    sceneElementIDList.push_back(id1);
    std::string id2([sceneElementID2 UTF8String]);
    sceneElementIDList.push_back(id2);
    std::string id3([sceneElementID3 UTF8String]);
    sceneElementIDList.push_back(id3);
    std::string id4([sceneElementID4 UTF8String]);
    sceneElementIDList.push_back(id4);
    self.semc->GetAllSceneElementIDsReplyCB(code, sceneElementIDList);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testGetSceneElementName
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *functionName = @"getSceneElementName";
    NSString *sceneElementID = @"sceneElementID1";
    NSString *language = @"en";
    NSString *sceneElementName = @"testSceneElementName";

    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: sceneElementID];
    [self.dataArray addObject: language];
    [self.dataArray addObject: sceneElementName];

    //Call callback method
    std::string seid([sceneElementID UTF8String]);
    std::string name([sceneElementName UTF8String]);
    std::string lang([language UTF8String]);
    self.semc->GetSceneElementNameReplyCB(code, seid, lang, name);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testSetSceneElementName
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *functionName = @"setSceneElementName";
    NSString *sceneElementID = @"sceneElementID1";
    NSString *language = @"en";

    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: sceneElementID];
    [self.dataArray addObject: language];

    //Call callback method
    std::string seid([sceneElementID UTF8String]);
    std::string lang([language UTF8String]);
    self.semc->SetSceneElementNameReplyCB(code, seid, lang);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testSceneElementsNameChanged
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    NSString *functionName = @"sceneElementsNameChanged";
    NSString *sceneElementID1 = @"sceneElementID1";
    NSString *sceneElementID2 = @"sceneElementID2";
    NSString *sceneElementID3 = @"sceneElementID3";
    NSString *sceneElementID4 = @"sceneElementID4";
    NSArray *sceneElementIDsArray = [[NSArray alloc] initWithObjects: sceneElementID1, sceneElementID2, sceneElementID3, sceneElementID4, nil];

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: sceneElementIDsArray];

    //Call callback method
    LSFStringList sceneElementIDList;
    std::string id1([sceneElementID1 UTF8String]);
    sceneElementIDList.push_back(id1);
    std::string id2([sceneElementID2 UTF8String]);
    sceneElementIDList.push_back(id2);
    std::string id3([sceneElementID3 UTF8String]);
    sceneElementIDList.push_back(id3);
    std::string id4([sceneElementID4 UTF8String]);
    sceneElementIDList.push_back(id4);
    self.semc->SceneElementsNameChangedCB(sceneElementIDList);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testCreateSceneElement
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    unsigned int tid = 1234;
    NSNumber *trackingID = [[NSNumber alloc] initWithUnsignedInt: tid];
    NSString *functionName = @"createSceneElement";
    NSString *sceneElementID = @"sceneElementID1";

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: trackingID];
    [self.dataArray addObject: sceneElementID];

    //Call callback method
    std::string seid([sceneElementID UTF8String]);
    self.semc->CreateSceneElementReplyCB(code, seid, tid);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testSceneElementsCreated
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    NSString *functionName = @"sceneElementsCreated";
    NSString *sceneElementID1 = @"sceneElementID1";
    NSString *sceneElementID2 = @"sceneElementID2";
    NSString *sceneElementID3 = @"sceneElementID3";
    NSString *sceneElementID4 = @"sceneElementID4";
    NSArray *sceneElementIDsArray = [[NSArray alloc] initWithObjects: sceneElementID1, sceneElementID2, sceneElementID3, sceneElementID4, nil];

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: sceneElementIDsArray];

    //Call callback method
    LSFStringList sceneElementIDList;
    std::string id1([sceneElementID1 UTF8String]);
    sceneElementIDList.push_back(id1);
    std::string id2([sceneElementID2 UTF8String]);
    sceneElementIDList.push_back(id2);
    std::string id3([sceneElementID3 UTF8String]);
    sceneElementIDList.push_back(id3);
    std::string id4([sceneElementID4 UTF8String]);
    sceneElementIDList.push_back(id4);
    self.semc->SceneElementsCreatedCB(sceneElementIDList);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testUpdateSceneElement
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *functionName = @"updateSceneElement";
    NSString *sceneElementID = @"sceneElementID1";

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];

    //Call callback method
    std::string seid([sceneElementID UTF8String]);
    self.semc->UpdateSceneElementReplyCB(code, seid);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testSceneElementsUpdated
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    NSString *functionName = @"sceneElementsUpdated";
    NSString *sceneElementID1 = @"sceneElementID1";
    NSString *sceneElementID2 = @"sceneElementID2";
    NSString *sceneElementID3 = @"sceneElementID3";
    NSString *sceneElementID4 = @"sceneElementID4";
    NSArray *sceneElementIDsArray = [[NSArray alloc] initWithObjects: sceneElementID1, sceneElementID2, sceneElementID3, sceneElementID4, nil];

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: sceneElementIDsArray];

    //Call callback method
    LSFStringList sceneElementIDList;
    std::string id1([sceneElementID1 UTF8String]);
    sceneElementIDList.push_back(id1);
    std::string id2([sceneElementID2 UTF8String]);
    sceneElementIDList.push_back(id2);
    std::string id3([sceneElementID3 UTF8String]);
    sceneElementIDList.push_back(id3);
    std::string id4([sceneElementID4 UTF8String]);
    sceneElementIDList.push_back(id4);
    self.semc->SceneElementsUpdatedCB(sceneElementIDList);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testDeleteSceneElement
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *functionName = @"deleteSceneElement";
    NSString *sceneElementID = @"sceneElementID1";

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];

    //Call callback method
    std::string seid([sceneElementID UTF8String]);
    self.semc->DeleteSceneElementReplyCB(code, seid);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testSceneElementsDeleted
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    NSString *functionName = @"sceneElementsDeleted";
    NSString *sceneElementID1 = @"sceneElementID1";
    NSString *sceneElementID2 = @"sceneElementID2";
    NSString *sceneElementID3 = @"sceneElementID3";
    NSString *sceneElementID4 = @"sceneElementID4";
    NSArray *sceneElementIDsArray = [[NSArray alloc] initWithObjects: sceneElementID1, sceneElementID2, sceneElementID3, sceneElementID4, nil];

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: sceneElementIDsArray];

    //Call callback method
    LSFStringList sceneElementIDList;
    std::string id1([sceneElementID1 UTF8String]);
    sceneElementIDList.push_back(id1);
    std::string id2([sceneElementID2 UTF8String]);
    sceneElementIDList.push_back(id2);
    std::string id3([sceneElementID3 UTF8String]);
    sceneElementIDList.push_back(id3);
    std::string id4([sceneElementID4 UTF8String]);
    sceneElementIDList.push_back(id4);
    self.semc->SceneElementsDeletedCB(sceneElementIDList);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testGetSceneElement
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *functionName = @"getSceneElement";
    NSString *sceneElementID = @"sceneElementID1";
    NSString *effectID = @"testEffectID";

    NSString *lampID1 = @"lampID1";
    NSString *lampID2 = @"lampID2";
    NSString *lampID3 = @"lampID3";
    NSArray *lampIDs = [NSArray arrayWithObjects: lampID1, lampID2, lampID3, nil];

    NSString *lampGroupID1 = @"lampGroupID1";
    NSString *lampGroupID2 = @"lampGroupID2";
    NSArray *lampGroupIDs = [NSArray arrayWithObjects: lampGroupID1, lampGroupID2, nil];

    LSFSceneElement *sceneElement = [[LSFSceneElement alloc] initWithLampIDs: lampIDs lampGroupIDs: lampGroupIDs andEffectID: effectID];

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];
    [self.dataArray addObject: lampIDs];
    [self.dataArray addObject: lampGroupIDs];
    [self.dataArray addObject: effectID];

    //Call callback method
    std::string seid([sceneElementID UTF8String]);
    self.semc->GetSceneElementReplyCB(code, seid, *static_cast<lsf::SceneElement*>(sceneElement.handle));

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testApplySceneElement
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *functionName = @"applySceneElement";
    NSString *sceneElementID = @"sceneElementID1";

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: sceneElementID];

    //Call callback method
    std::string seid([sceneElementID UTF8String]);
    self.semc->ApplySceneElementReplyCB(code, seid);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testSceneElementsApplied
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    NSString *functionName = @"sceneElementsApplied";
    NSString *sceneElementID1 = @"sceneElementID1";
    NSString *sceneElementID2 = @"sceneElementID2";
    NSString *sceneElementID3 = @"sceneElementID3";
    NSString *sceneElementID4 = @"sceneElementID4";
    NSArray *sceneElementIDsArray = [[NSArray alloc] initWithObjects: sceneElementID1, sceneElementID2, sceneElementID3, sceneElementID4, nil];

    [self.dataArray addObject: functionName];
    [self.dataArray addObject: sceneElementIDsArray];

    //Call callback method
    LSFStringList sceneElementIDList;
    std::string id1([sceneElementID1 UTF8String]);
    sceneElementIDList.push_back(id1);
    std::string id2([sceneElementID2 UTF8String]);
    sceneElementIDList.push_back(id2);
    std::string id3([sceneElementID3 UTF8String]);
    sceneElementIDList.push_back(id3);
    std::string id4([sceneElementID4 UTF8String]);
    sceneElementIDList.push_back(id4);
    self.semc->SceneElementsAppliedCB(sceneElementIDList);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.semcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

@end
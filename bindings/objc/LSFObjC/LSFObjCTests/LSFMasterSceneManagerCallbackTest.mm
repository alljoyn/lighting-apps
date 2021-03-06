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

#import "LSFMasterSceneManagerCallbackTest.h"
#import "MockMasterSceneManagerCallbackDelegateHandler.h"
#import <internal/LSFMasterSceneManagerCallback.h>

@interface LSFMasterSceneManagerCallbackTest()

@property (nonatomic) MockMasterSceneManagerCallbackDelegateHandler *msmcdh;
@property (nonatomic) LSFMasterSceneManagerCallback *msmc;
@property (nonatomic) NSMutableArray *dataArray;

@end

@implementation LSFMasterSceneManagerCallbackTest

@synthesize msmcdh = _msmcdh;
@synthesize msmc = _msmc;
@synthesize dataArray = _dataArray;

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.msmcdh = [[MockMasterSceneManagerCallbackDelegateHandler alloc] init];
    self.msmc = new LSFMasterSceneManagerCallback(self.msmcdh);
    self.dataArray = [[NSMutableArray alloc] init];
}

-(void)tearDown
{
    delete self.msmc;
    self.msmcdh = nil;
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testGetMasterSceneIDs
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *functionName = @"getAllMasterSceneIDs";
    NSString *masterSceneID1 = @"masterSceneID1";
    NSString *masterSceneID2 = @"masterSceneID2";
    NSString *masterSceneID3 = @"masterSceneID3";
    NSString *masterSceneID4 = @"masterSceneID4";
    NSArray *masterSceneIDsArray = [[NSArray alloc] initWithObjects: masterSceneID1, masterSceneID2, masterSceneID3, masterSceneID4, nil];
    
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneIDsArray];
    
    //Call callback method
    LSFStringList masterSceneIDList;
    std::string id1([masterSceneID1 UTF8String]);
    masterSceneIDList.push_back(id1);
    std::string id2([masterSceneID2 UTF8String]);
    masterSceneIDList.push_back(id2);
    std::string id3([masterSceneID3 UTF8String]);
    masterSceneIDList.push_back(id3);
    std::string id4([masterSceneID4 UTF8String]);
    masterSceneIDList.push_back(id4);
    self.msmc->GetAllMasterSceneIDsReplyCB(code, masterSceneIDList);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testGetMasterSceneName
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *masterSceneID = @"masterSceneID1";
    NSString *functionName = @"getMasterSceneName";
    NSString *language = @"en";
    NSString *name = @"testMasterSceneName";
    
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: language];
    [self.dataArray addObject: masterSceneID];
    [self.dataArray addObject: name];
    
    //Call callback method
    std::string msid([masterSceneID UTF8String]);
    std::string lang([language UTF8String]);
    std::string masterSceneName([name UTF8String]);
    self.msmc->GetMasterSceneNameReplyCB(code, msid, lang, masterSceneName);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testSetMasterSceneName
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *masterSceneID = @"masterSceneID1";
    NSString *functionName = @"setMasterSceneName";
    NSString *language = @"en";
    
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: language];
    [self.dataArray addObject: masterSceneID];
    
    //Call callback method
    std::string msid([masterSceneID UTF8String]);
    std::string lang([language UTF8String]);
    self.msmc->SetMasterSceneNameReplyCB(code, msid, lang);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testMasterScenesNameChanged
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    NSString *functionName = @"masterScenesNameChanged";
    NSString *masterSceneID1 = @"masterSceneID1";
    NSString *masterSceneID2 = @"masterSceneID2";
    NSString *masterSceneID3 = @"masterSceneID3";
    NSString *masterSceneID4 = @"masterSceneID4";
    NSArray *masterSceneIDsArray = [[NSArray alloc] initWithObjects: masterSceneID1, masterSceneID2, masterSceneID3, masterSceneID4, nil];
    
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneIDsArray];
    
    //Call callback method
    LSFStringList masterSceneIDList;
    std::string id1([masterSceneID1 UTF8String]);
    masterSceneIDList.push_back(id1);
    std::string id2([masterSceneID2 UTF8String]);
    masterSceneIDList.push_back(id2);
    std::string id3([masterSceneID3 UTF8String]);
    masterSceneIDList.push_back(id3);
    std::string id4([masterSceneID4 UTF8String]);
    masterSceneIDList.push_back(id4);
    self.msmc->MasterScenesNameChangedCB(masterSceneIDList);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testCreateMasterScene
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *masterSceneID = @"masterSceneID1";
    NSString *functionName = @"createMasterScene";
    
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneID];
    
    //Call callback method
    std::string msid([masterSceneID UTF8String]);
    self.msmc->CreateMasterSceneReplyCB(code, msid);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testCreateMasterSceneWithTracking
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];

    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    unsigned int tid = 1234;
    NSNumber *trackingID = [[NSNumber alloc] initWithUnsignedInt: tid];
    NSString *masterSceneID = @"masterSceneID1";
    NSString *functionName = @"createMasterSceneWithTracking";

    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneID];
    [self.dataArray addObject: trackingID];

    //Call callback method
    std::string msid([masterSceneID UTF8String]);
    self.msmc->CreateMasterSceneWithTrackingReplyCB(code, msid, tid);

    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testMasterScenesCreated
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    NSString *functionName = @"masterScenesCreated";
    NSString *masterSceneID1 = @"masterSceneID1";
    NSString *masterSceneID2 = @"masterSceneID2";
    NSString *masterSceneID3 = @"masterSceneID3";
    NSString *masterSceneID4 = @"masterSceneID4";
    NSArray *masterSceneIDsArray = [[NSArray alloc] initWithObjects: masterSceneID1, masterSceneID2, masterSceneID3, masterSceneID4, nil];
    
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneIDsArray];
    
    //Call callback method
    LSFStringList masterSceneIDList;
    std::string id1([masterSceneID1 UTF8String]);
    masterSceneIDList.push_back(id1);
    std::string id2([masterSceneID2 UTF8String]);
    masterSceneIDList.push_back(id2);
    std::string id3([masterSceneID3 UTF8String]);
    masterSceneIDList.push_back(id3);
    std::string id4([masterSceneID4 UTF8String]);
    masterSceneIDList.push_back(id4);
    self.msmc->MasterScenesCreatedCB(masterSceneIDList);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testGetMasterScene
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *masterSceneID = @"masterSceneID1";
    NSString *functionName = @"getMasterScene";
    NSString *sceneID1 = @"sceneID1";
    NSString *sceneID2 = @"sceneID2";
    NSString *sceneID3 = @"sceneID3";
    NSString *sceneID4 = @"sceneID4";
    NSArray *sceneIDsArray = [[NSArray alloc] initWithObjects: sceneID1, sceneID2, sceneID3, sceneID4, nil];
    
    LSFMasterScene *masterScene = [[LSFMasterScene alloc] initWithSceneIDs: sceneIDsArray];
    
    [self.dataArray addObject: sceneIDsArray];
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneID];
    
    //Call callback method
    std::string msid([masterSceneID UTF8String]);
    self.msmc->GetMasterSceneReplyCB(code, msid, *(static_cast<lsf::MasterScene*>(masterScene.handle)));
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testDeleteMasterScene
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *masterSceneID = @"masterSceneID1";
    NSString *functionName = @"deleteMasterScene";
    
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneID];
    
    //Call callback method
    std::string msid([masterSceneID UTF8String]);
    self.msmc->DeleteMasterSceneReplyCB(code, msid);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testMasterScenesDeleted
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    NSString *functionName = @"masterScenesDeleted";
    NSString *masterSceneID1 = @"masterSceneID1";
    NSString *masterSceneID2 = @"masterSceneID2";
    NSString *masterSceneID3 = @"masterSceneID3";
    NSString *masterSceneID4 = @"masterSceneID4";
    NSArray *masterSceneIDsArray = [[NSArray alloc] initWithObjects: masterSceneID1, masterSceneID2, masterSceneID3, masterSceneID4, nil];
    
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneIDsArray];
    
    //Call callback method
    LSFStringList masterSceneIDList;
    std::string id1([masterSceneID1 UTF8String]);
    masterSceneIDList.push_back(id1);
    std::string id2([masterSceneID2 UTF8String]);
    masterSceneIDList.push_back(id2);
    std::string id3([masterSceneID3 UTF8String]);
    masterSceneIDList.push_back(id3);
    std::string id4([masterSceneID4 UTF8String]);
    masterSceneIDList.push_back(id4);
    self.msmc->MasterScenesDeletedCB(masterSceneIDList);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testUpdateMasterScene
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *masterSceneID = @"masterSceneID1";
    NSString *functionName = @"updateMasterScene";
    
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneID];
    
    //Call callback method
    std::string msid([masterSceneID UTF8String]);
    self.msmc->UpdateMasterSceneReplyCB(code, msid);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testMasterScenesUpdated
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    NSString *functionName = @"masterScenesUpdated";
    NSString *masterSceneID1 = @"masterSceneID1";
    NSString *masterSceneID2 = @"masterSceneID2";
    NSString *masterSceneID3 = @"masterSceneID3";
    NSString *masterSceneID4 = @"masterSceneID4";
    NSArray *masterSceneIDsArray = [[NSArray alloc] initWithObjects: masterSceneID1, masterSceneID2, masterSceneID3, masterSceneID4, nil];
    
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneIDsArray];
    
    //Call callback method
    LSFStringList masterSceneIDList;
    std::string id1([masterSceneID1 UTF8String]);
    masterSceneIDList.push_back(id1);
    std::string id2([masterSceneID2 UTF8String]);
    masterSceneIDList.push_back(id2);
    std::string id3([masterSceneID3 UTF8String]);
    masterSceneIDList.push_back(id3);
    std::string id4([masterSceneID4 UTF8String]);
    masterSceneIDList.push_back(id4);
    self.msmc->MasterScenesUpdatedCB(masterSceneIDList);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testApplyMasterScene
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    LSFResponseCode code = LSF_ERR_INVALID;
    NSNumber *responseCode = [[NSNumber alloc] initWithInt: code];
    NSString *masterSceneID = @"masterSceneID1";
    NSString *functionName = @"applyMasterScene";
    
    [self.dataArray addObject: responseCode];
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneID];
    
    //Call callback method
    std::string msid([masterSceneID UTF8String]);
    self.msmc->ApplyMasterSceneReplyCB(code, msid);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

-(void)testMasterScenesApplied
{
    //Ensure array is empty
    [self.dataArray removeAllObjects];
    
    //Populate array with test data
    NSString *functionName = @"masterScenesApplied";
    NSString *masterSceneID1 = @"masterSceneID1";
    NSString *masterSceneID2 = @"masterSceneID2";
    NSString *masterSceneID3 = @"masterSceneID3";
    NSString *masterSceneID4 = @"masterSceneID4";
    NSArray *masterSceneIDsArray = [[NSArray alloc] initWithObjects: masterSceneID1, masterSceneID2, masterSceneID3, masterSceneID4, nil];
    
    [self.dataArray addObject: functionName];
    [self.dataArray addObject: masterSceneIDsArray];
    
    //Call callback method
    LSFStringList masterSceneIDList;
    std::string id1([masterSceneID1 UTF8String]);
    masterSceneIDList.push_back(id1);
    std::string id2([masterSceneID2 UTF8String]);
    masterSceneIDList.push_back(id2);
    std::string id3([masterSceneID3 UTF8String]);
    masterSceneIDList.push_back(id3);
    std::string id4([masterSceneID4 UTF8String]);
    masterSceneIDList.push_back(id4);
    self.msmc->MasterScenesAppliedCB(masterSceneIDList);
    
    //Test the data using NSSet
    NSSet *startData = [[NSSet alloc] initWithArray: self.dataArray];
    NSSet *endData = [[NSSet alloc] initWithArray: [self.msmcdh getCallbackData]];
    BOOL isSetsEqual = [startData isEqualToSet: endData];
    XCTAssertTrue(isSetsEqual, @"Start and end data should be equal");
}

@end
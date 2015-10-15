/******************************************************************************
 * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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

#import "LSFTransitionEffectV2Tests.h"
#import <internal/LSFTransitionEffectV2.h>
#import <alljoyn/Init.h>

@interface LSFTransitionEffectV2Tests()

@property (nonatomic) LSFTransitionEffectV2 *transitionEffect;

@end

@implementation LSFTransitionEffectV2Tests

@synthesize transitionEffect = _transitionEffect;

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    AllJoynInit();
    self.transitionEffect = [[LSFTransitionEffectV2 alloc] init];
}

-(void)tearDown
{
    self.transitionEffect = nil;
    AllJoynShutdown();

    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testNoArgConstructor
{
    //Test LampState
    XCTAssertFalse(self.transitionEffect.lampState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.transitionEffect.lampState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.transitionEffect.lampState.isNull, @"LampState isNull should be true");

    //Test transition period
    XCTAssertTrue((self.transitionEffect.transitionPeriod == 0), @"Transition Period should be zero");

    //Test preset ID
    XCTAssertTrue(([self.transitionEffect.presetID isEqualToString: @""]), @"Preset ID should be an empty string");

    //Test invalid args
    XCTAssertTrue(self.transitionEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testLampStateNoPeriodConstructor
{
    LSFLampState *state = [[LSFLampState alloc] initWithOnOff: YES brightness: 100 hue: 360 saturation: 100 colorTemp: 2000];
    self.transitionEffect = [[LSFTransitionEffectV2 alloc] initWithLampState: state];

    //Test LampState
    XCTAssertTrue(self.transitionEffect.lampState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.transitionEffect.lampState.brightness == state.brightness), @"LampState brightness should be 100");
    XCTAssertTrue((self.transitionEffect.lampState.hue == state.hue), @"LampState hue should be 360");
    XCTAssertTrue((self.transitionEffect.lampState.saturation == state.saturation), @"LampState saturation should be 100");
    XCTAssertTrue((self.transitionEffect.lampState.colorTemp == state.colorTemp), @"LampState colorTemp should be 2000");
    XCTAssertFalse(self.transitionEffect.lampState.isNull, @"LampState isNull should be false");

    //Test transition period
    XCTAssertTrue((self.transitionEffect.transitionPeriod == 0), @"Transition Period should be zero");

    //Test preset ID
    XCTAssertTrue(([self.transitionEffect.presetID isEqualToString: @""]), @"Preset ID should be an empty string");

    //Test invalid args
    XCTAssertFalse(self.transitionEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testLampStateWithPeriodConstructor
{
    unsigned int period = 5000;
    LSFLampState *state = [[LSFLampState alloc] initWithOnOff: YES brightness: 100 hue: 360 saturation: 100 colorTemp: 2000];
    self.transitionEffect = [[LSFTransitionEffectV2 alloc] initWithLampState: state transitionPeriod: period];

    //Test LampState
    XCTAssertTrue(self.transitionEffect.lampState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.transitionEffect.lampState.brightness == state.brightness), @"LampState brightness should be 100");
    XCTAssertTrue((self.transitionEffect.lampState.hue == state.hue), @"LampState hue should be 360");
    XCTAssertTrue((self.transitionEffect.lampState.saturation == state.saturation), @"LampState saturation should be 100");
    XCTAssertTrue((self.transitionEffect.lampState.colorTemp == state.colorTemp), @"LampState colorTemp should be 2000");
    XCTAssertFalse(self.transitionEffect.lampState.isNull, @"LampState isNull should be false");

    //Test transition period
    XCTAssertTrue((self.transitionEffect.transitionPeriod == period), @"Transition Period should be 5000");

    //Test preset ID
    XCTAssertTrue(([self.transitionEffect.presetID isEqualToString: @""]), @"Preset ID should be an empty string");

    //Test invalid args
    XCTAssertFalse(self.transitionEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testPresetNoPeriodConstructor
{
    NSString *presetID = @"testPresetID";
    self.transitionEffect = [[LSFTransitionEffectV2 alloc] initWithPresetID: presetID];

    //Test LampState
    XCTAssertFalse(self.transitionEffect.lampState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.transitionEffect.lampState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.transitionEffect.lampState.isNull, @"LampState isNull should be true");

    //Test transition period
    XCTAssertTrue((self.transitionEffect.transitionPeriod == 0), @"Transition Period should be zero");

    //Test preset ID
    XCTAssertTrue(([self.transitionEffect.presetID isEqualToString: presetID]), @"Preset ID should be equal");

    //Test invalid args
    XCTAssertFalse(self.transitionEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testPresetWithPeriodConstructor
{
    unsigned int period = 5000;
    NSString *presetID = @"testPresetID";
    self.transitionEffect = [[LSFTransitionEffectV2 alloc] initWithPresetID: presetID transitionPeriod: period];

    //Test LampState
    XCTAssertFalse(self.transitionEffect.lampState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.transitionEffect.lampState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.transitionEffect.lampState.isNull, @"LampState isNull should be true");

    //Test transition period
    XCTAssertTrue((self.transitionEffect.transitionPeriod == period), @"Transition Period should be 5000");

    //Test preset ID
    XCTAssertTrue(([self.transitionEffect.presetID isEqualToString: presetID]), @"Preset ID should be equal");

    //Test invalid args
    XCTAssertFalse(self.transitionEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testSetGetLampState
{
    //Test LampState before set
    XCTAssertFalse(self.transitionEffect.lampState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.transitionEffect.lampState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.transitionEffect.lampState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.transitionEffect.lampState.isNull, @"LampState isNull should be true");

    LSFLampState *state = [[LSFLampState alloc] initWithOnOff: YES brightness: 100 hue: 360 saturation: 100 colorTemp: 2000];
    self.transitionEffect.lampState = state;

    //Test LampState after set
    XCTAssertTrue(self.transitionEffect.lampState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.transitionEffect.lampState.brightness == state.brightness), @"LampState brightness should be 100");
    XCTAssertTrue((self.transitionEffect.lampState.hue == state.hue), @"LampState hue should be 360");
    XCTAssertTrue((self.transitionEffect.lampState.saturation == state.saturation), @"LampState saturation should be 100");
    XCTAssertTrue((self.transitionEffect.lampState.colorTemp == state.colorTemp), @"LampState colorTemp should be 2000");
    XCTAssertFalse(self.transitionEffect.lampState.isNull, @"LampState isNull should be false");
}

-(void)testSetGetTransitionPeriod
{
    //Test transition period before set
    XCTAssertTrue((self.transitionEffect.transitionPeriod == 0), @"Transition Period should be zero");

    unsigned int period = 5000;
    self.transitionEffect.transitionPeriod = period;

    //Test transition period after set
    XCTAssertTrue((self.transitionEffect.transitionPeriod == period), @"Transition Period should be 5000");
}

-(void)testSetGetPresetID
{
    //Test preset ID before set
    XCTAssertTrue(([self.transitionEffect.presetID isEqualToString: @""]), @"Preset ID should be an empty string");

    NSString *presetID = @"testPresetID";
    self.transitionEffect.presetID = presetID;

    //Test preset ID after set
    XCTAssertTrue(([self.transitionEffect.presetID isEqualToString: presetID]), @"Preset ID should be equal");
}

@end
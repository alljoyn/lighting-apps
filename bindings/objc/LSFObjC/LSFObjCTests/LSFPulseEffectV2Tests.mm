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

#import "LSFPulseEffectV2Tests.h"
#import <internal/LSFPulseEffectV2.h>
#import <alljoyn/Init.h>

@interface LSFPulseEffectV2Tests()

@property (nonatomic) LSFPulseEffectV2 *pulseEffect;

@end

@implementation LSFPulseEffectV2Tests

@synthesize pulseEffect = _pulseEffect;

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.

    AllJoynInit();
    self.pulseEffect = [[LSFPulseEffectV2 alloc] init];
}

-(void)tearDown
{
    self.pulseEffect = nil;
    AllJoynShutdown();

    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testNoArgConstructor
{
    //Test fromLampState
    XCTAssertFalse(self.pulseEffect.fromState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.fromState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.pulseEffect.fromState.isNull, @"LampState isNull should be true");

    //Test pulse period
    XCTAssertTrue((self.pulseEffect.pulsePeriod == 0), @"Pulse Period should be zero");

    //Test pulse duration
    XCTAssertTrue((self.pulseEffect.pulseDuration == 0), @"Pulse Duration should be zero");

    //Test pulse num pulses
    XCTAssertTrue((self.pulseEffect.numPulses == 0), @"Num pulses should be zero");

    //Test toLampState
    XCTAssertFalse(self.pulseEffect.toState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.toState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.pulseEffect.toState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.pulseEffect.toState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.pulseEffect.toState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.pulseEffect.toState.isNull, @"LampState isNull should be true");

    //Test from preset ID
    XCTAssertTrue(([self.pulseEffect.fromPreset isEqualToString: @""]), @"Preset ID should be an empty string");

    //Test to preset ID
    XCTAssertTrue(([self.pulseEffect.toPreset isEqualToString: @""]), @"Preset ID should be an empty string");

    //Test invalid args
    XCTAssertTrue(self.pulseEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testNoFromLampStateConstructor
{
    LSFLampState *toState = [[LSFLampState alloc] initWithOnOff: YES brightness: 100 hue: 360 saturation: 100 colorTemp: 2000];
    unsigned int pulsePeriod = 1000;
    unsigned int pulseDuration = 2000;
    unsigned int numPulses = 5;
    self.pulseEffect = [[LSFPulseEffectV2 alloc] initWithToLampState: toState period: pulsePeriod duration: pulseDuration numPulses: numPulses];

    //Test fromLampState
    XCTAssertFalse(self.pulseEffect.fromState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.fromState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.pulseEffect.fromState.isNull, @"LampState isNull should be true");

    //Test pulse period
    XCTAssertTrue((self.pulseEffect.pulsePeriod == pulsePeriod), @"Pulse Period should be 1000");

    //Test pulse duration
    XCTAssertTrue((self.pulseEffect.pulseDuration == pulseDuration), @"Pulse Duration should be 2000");

    //Test pulse num pulses
    XCTAssertTrue((self.pulseEffect.numPulses == numPulses), @"Num pulses should be 5");

    //Test toLampState
    XCTAssertTrue(self.pulseEffect.toState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.toState.brightness == toState.brightness), @"LampState brightness should be 100");
    XCTAssertTrue((self.pulseEffect.toState.hue == toState.hue), @"LampState hue should be 360");
    XCTAssertTrue((self.pulseEffect.toState.saturation == toState.saturation), @"LampState saturation should be 100");
    XCTAssertTrue((self.pulseEffect.toState.colorTemp == toState.colorTemp), @"LampState colorTemp should be 2000");
    XCTAssertFalse(self.pulseEffect.toState.isNull, @"LampState isNull should be false");

    //Test from preset ID
    XCTAssertTrue(([self.pulseEffect.fromPreset isEqualToString: @""]), @"Preset ID should be an empty string");

    //Test to preset ID
    XCTAssertTrue(([self.pulseEffect.toPreset isEqualToString: @""]), @"Preset ID should be an empty string");

    //Test invalid args
    XCTAssertFalse(self.pulseEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testFromLampStateConstructor
{
    LSFLampState *fromState = [[LSFLampState alloc] initWithOnOff: YES brightness: 50 hue: 180 saturation: 50 colorTemp: 2000];
    LSFLampState *toState = [[LSFLampState alloc] initWithOnOff: YES brightness: 100 hue: 360 saturation: 100 colorTemp: 2000];
    unsigned int pulsePeriod = 1000;
    unsigned int pulseDuration = 2000;
    unsigned int numPulses = 5;
    self.pulseEffect = [[LSFPulseEffectV2 alloc] initWithToLampState: toState period: pulsePeriod duration: pulseDuration numPulses: numPulses fromLampState: fromState];

    //Test fromLampState
    XCTAssertTrue(self.pulseEffect.fromState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.fromState.brightness == fromState.brightness), @"LampState brightness should be 50");
    XCTAssertTrue((self.pulseEffect.fromState.hue == fromState.hue), @"LampState hue should be 180");
    XCTAssertTrue((self.pulseEffect.fromState.saturation == fromState.saturation), @"LampState saturation should be 50");
    XCTAssertTrue((self.pulseEffect.fromState.colorTemp == fromState.colorTemp), @"LampState colorTemp should be 2000");
    XCTAssertFalse(self.pulseEffect.fromState.isNull, @"LampState isNull should be false");

    //Test pulse period
    XCTAssertTrue((self.pulseEffect.pulsePeriod == pulsePeriod), @"Pulse Period should be 1000");

    //Test pulse duration
    XCTAssertTrue((self.pulseEffect.pulseDuration == pulseDuration), @"Pulse Duration should be 2000");

    //Test pulse num pulses
    XCTAssertTrue((self.pulseEffect.numPulses == numPulses), @"Num pulses should be 5");

    //Test toLampState
    XCTAssertTrue(self.pulseEffect.toState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.toState.brightness == toState.brightness), @"LampState brightness should be 100");
    XCTAssertTrue((self.pulseEffect.toState.hue == toState.hue), @"LampState hue should be 360");
    XCTAssertTrue((self.pulseEffect.toState.saturation == toState.saturation), @"LampState saturation should be 100");
    XCTAssertTrue((self.pulseEffect.toState.colorTemp == toState.colorTemp), @"LampState colorTemp should be 2000");
    XCTAssertFalse(self.pulseEffect.toState.isNull, @"LampState isNull should be false");

    //Test from preset ID
    XCTAssertTrue(([self.pulseEffect.fromPreset isEqualToString: @""]), @"Preset ID should be an empty string");

    //Test to preset ID
    XCTAssertTrue(([self.pulseEffect.toPreset isEqualToString: @""]), @"Preset ID should be an empty string");

    //Test invalid args
    XCTAssertFalse(self.pulseEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testNoFromPresetConstructor
{
    NSString *toPresetID = @"toPresetID";
    unsigned int pulsePeriod = 1000;
    unsigned int pulseDuration = 2000;
    unsigned int numPulses = 5;
    self.pulseEffect = [[LSFPulseEffectV2 alloc] initWithToPreset: toPresetID period: pulsePeriod duration: pulseDuration numPulses: numPulses];

    //Test fromLampState
    XCTAssertFalse(self.pulseEffect.fromState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.fromState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.pulseEffect.fromState.isNull, @"LampState isNull should be true");

    //Test pulse period
    XCTAssertTrue((self.pulseEffect.pulsePeriod == pulsePeriod), @"Pulse Period should be 1000");

    //Test pulse duration
    XCTAssertTrue((self.pulseEffect.pulseDuration == pulseDuration), @"Pulse Duration should be 2000");

    //Test pulse num pulses
    XCTAssertTrue((self.pulseEffect.numPulses == numPulses), @"Num pulses should be 5");

    //Test toLampState
    XCTAssertFalse(self.pulseEffect.fromState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.fromState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.pulseEffect.fromState.isNull, @"LampState isNull should be true");

    //Test from preset ID
    XCTAssertTrue(([self.pulseEffect.fromPreset isEqualToString: @"CURRENT_STATE"]), @"Preset ID should be current state");

    //Test to preset ID
    XCTAssertTrue(([self.pulseEffect.toPreset isEqualToString: toPresetID]), @"Preset ID should be equal");

    //Test invalid args
    XCTAssertFalse(self.pulseEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testFromPresetConstructor
{
    NSString *fromPresetID = @"fromPresetID";
    NSString *toPresetID = @"toPresetID";
    unsigned int pulsePeriod = 1000;
    unsigned int pulseDuration = 2000;
    unsigned int numPulses = 5;
    self.pulseEffect = [[LSFPulseEffectV2 alloc] initWithToPreset: toPresetID period: pulsePeriod duration: pulseDuration numPulses: numPulses fromPreset: fromPresetID];

    //Test fromLampState
    XCTAssertFalse(self.pulseEffect.fromState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.fromState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.pulseEffect.fromState.isNull, @"LampState isNull should be true");

    //Test pulse period
    XCTAssertTrue((self.pulseEffect.pulsePeriod == pulsePeriod), @"Pulse Period should be 1000");

    //Test pulse duration
    XCTAssertTrue((self.pulseEffect.pulseDuration == pulseDuration), @"Pulse Duration should be 2000");

    //Test pulse num pulses
    XCTAssertTrue((self.pulseEffect.numPulses == numPulses), @"Num pulses should be 5");

    //Test toLampState
    XCTAssertFalse(self.pulseEffect.fromState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.fromState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.pulseEffect.fromState.isNull, @"LampState isNull should be true");

    //Test from preset ID
    XCTAssertTrue(([self.pulseEffect.fromPreset isEqualToString: fromPresetID]), @"Preset ID should be equal");

    //Test to preset ID
    XCTAssertTrue(([self.pulseEffect.toPreset isEqualToString: toPresetID]), @"Preset ID should be equal");

    //Test invalid args
    XCTAssertFalse(self.pulseEffect.invalidArgs, @"Invalid Args should be set to true");
}

-(void)testSetGetFromLampState
{
    //Test LampState before set
    XCTAssertFalse(self.pulseEffect.fromState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.fromState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.pulseEffect.fromState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.pulseEffect.fromState.isNull, @"LampState isNull should be true");

    LSFLampState *fromState = [[LSFLampState alloc] initWithOnOff: YES brightness: 100 hue: 360 saturation: 100 colorTemp: 2000];
    self.pulseEffect.fromState = fromState;

    //Test LampState after set
    XCTAssertTrue(self.pulseEffect.fromState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.fromState.brightness == fromState.brightness), @"LampState brightness should be 100");
    XCTAssertTrue((self.pulseEffect.fromState.hue == fromState.hue), @"LampState hue should be 360");
    XCTAssertTrue((self.pulseEffect.fromState.saturation == fromState.saturation), @"LampState saturation should be 100");
    XCTAssertTrue((self.pulseEffect.fromState.colorTemp == fromState.colorTemp), @"LampState colorTemp should be 2000");
    XCTAssertFalse(self.pulseEffect.fromState.isNull, @"LampState isNull should be false");
}

-(void)testSetGetPulsePeriod
{
    //Test pulse period before set
    XCTAssertTrue((self.pulseEffect.pulsePeriod == 0), @"Pulse Period should be zero");

    unsigned int pulsePeriod = 1000;
    self.pulseEffect.pulsePeriod = pulsePeriod;

    //Test pulse period after set
    XCTAssertTrue((self.pulseEffect.pulsePeriod == pulsePeriod), @"Pulse Period should be 1000");
}

-(void)testSetGetPulseDuration
{
    //Test pulse duration before set
    XCTAssertTrue((self.pulseEffect.pulseDuration == 0), @"Pulse Duration should be zero");

    unsigned int pulseDuration = 2000;
    self.pulseEffect.pulseDuration = pulseDuration;

    //Test pulse period after set
    XCTAssertTrue((self.pulseEffect.pulseDuration == pulseDuration), @"Pulse Duration should be 2000");
}

-(void)testSetGetNumPulses
{
    //Test pulse num pulses before set
    XCTAssertTrue((self.pulseEffect.numPulses == 0), @"Num pulses should be zero");

    unsigned int numPulses = 5;
    self.pulseEffect.numPulses = numPulses;

    //Test pulse num pulses after set
    XCTAssertTrue((self.pulseEffect.numPulses == numPulses), @"Num pulses should be 5");
}

-(void)testSetGetToLampState
{
    //Test LampState before set
    XCTAssertFalse(self.pulseEffect.toState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.toState.brightness == 0), @"LampState brightness should be zero");
    XCTAssertTrue((self.pulseEffect.toState.hue == 0), @"LampState hue should be zero");
    XCTAssertTrue((self.pulseEffect.toState.saturation == 0), @"LampState saturation should be zero");
    XCTAssertTrue((self.pulseEffect.toState.colorTemp == 0), @"LampState colorTemp should be zero");
    XCTAssertTrue(self.pulseEffect.toState.isNull, @"LampState isNull should be true");

    LSFLampState *toState = [[LSFLampState alloc] initWithOnOff: YES brightness: 100 hue: 360 saturation: 100 colorTemp: 2000];
    self.pulseEffect.toState = toState;

    //Test LampState after set
    XCTAssertTrue(self.pulseEffect.toState.onOff, @"LampState power should be off");
    XCTAssertTrue((self.pulseEffect.toState.brightness == toState.brightness), @"LampState brightness should be 100");
    XCTAssertTrue((self.pulseEffect.toState.hue == toState.hue), @"LampState hue should be 360");
    XCTAssertTrue((self.pulseEffect.toState.saturation == toState.saturation), @"LampState saturation should be 100");
    XCTAssertTrue((self.pulseEffect.toState.colorTemp == toState.colorTemp), @"LampState colorTemp should be 2000");
    XCTAssertFalse(self.pulseEffect.toState.isNull, @"LampState isNull should be false");
}

-(void)testSetGetFromPreset
{
    //Test from preset ID before set
    XCTAssertTrue(([self.pulseEffect.fromPreset isEqualToString: @""]), @"Preset ID should be an empty string");

    NSString *fromPresetID = @"fromPresetID";
    self.pulseEffect.fromPreset = fromPresetID;

    //Test from preset ID after set
    XCTAssertTrue(([self.pulseEffect.fromPreset isEqualToString: fromPresetID]), @"Preset ID should be equal");
}

-(void)testSetGetToPreset
{
    //Test to preset ID before set
    XCTAssertTrue(([self.pulseEffect.toPreset isEqualToString: @""]), @"Preset ID should be an empty string");

    NSString *toPresetID = @"toPresetID";
    self.pulseEffect.toPreset = toPresetID;

    //Test from preset ID after set
    XCTAssertTrue(([self.pulseEffect.toPreset isEqualToString: toPresetID]), @"Preset ID should be equal");
}

@end
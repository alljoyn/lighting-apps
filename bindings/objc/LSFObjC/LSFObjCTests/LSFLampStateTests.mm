/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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

#import "LSFLampStateTests.h"
#import <internal/LSFLampState.h>

@interface LSFLampStateTests()

@property (nonatomic) LSFLampState *lampState;

@end

@implementation LSFLampStateTests

@synthesize lampState = _lampState;

-(void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.lampState = [[LSFLampState alloc] init];
}

-(void)tearDown
{
    self.lampState = nil;
    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testConstructor
{
    BOOL onOff = YES;
    unsigned int brightnessData = 100;
    unsigned int hueData = 360;
    unsigned int saturationData = 100;
    unsigned int colorTempData = 20000;

    self.lampState = [[LSFLampState alloc] initWithOnOff: onOff brightness: brightnessData hue: hueData saturation: saturationData colorTemp: colorTempData];

    XCTAssertTrue(self.lampState.onOff, @"OnOff field should be on");
    XCTAssertTrue((self.lampState.brightness == brightnessData), @"Brightness should be equal to 100");
    XCTAssertTrue((self.lampState.hue == hueData), @"Hue should be equal to 360");
    XCTAssertTrue((self.lampState.saturation == saturationData), @"Saturation should be equal to 100");
    XCTAssertTrue((self.lampState.colorTemp == colorTempData), @"ColorTemp should be equal to 20000");
}

-(void)testOnOff
{
    XCTAssertFalse(self.lampState.onOff, @"OnOff field should be off initially");
    
    //Test turn on
    self.lampState.onOff = YES;
    XCTAssertTrue(self.lampState.onOff, @"OnOff field should be on");
    
    //Test turn off
    self.lampState.onOff = NO;
    XCTAssertFalse(self.lampState.onOff, @"OnOff field should be off");
}

-(void)testBrightness
{
    XCTAssertTrue((self.lampState.brightness == 0), @"Brightness should be zero initially");
    
    unsigned int brightnessData = 100;
    self.lampState.brightness = brightnessData;
    XCTAssertTrue((self.lampState.brightness == brightnessData), @"Brightness should be equal to 100");
    
    brightnessData = 50;
    self.lampState.brightness = brightnessData;
    XCTAssertTrue((self.lampState.brightness == brightnessData), @"Brightness should be equal to 50");
}

-(void)testHue
{
    XCTAssertTrue((self.lampState.hue == 0), @"Hue should be zero initially");
    
    unsigned int hueData = 100;
    self.lampState.hue = hueData;
    XCTAssertTrue((self.lampState.hue == hueData), @"Hue should be equal to 100");
    
    hueData = 50;
    self.lampState.hue = hueData;
    XCTAssertTrue((self.lampState.hue == hueData), @"Hue should be equal to 50");
}

-(void)testSaturation
{
    XCTAssertTrue((self.lampState.saturation == 0), @"Saturation should be zero initially");
    
    unsigned int saturationData = 100;
    self.lampState.saturation = saturationData;
    XCTAssertTrue((self.lampState.saturation == saturationData), @"Saturation should be equal to 100");
    
    saturationData = 50;
    self.lampState.saturation = saturationData;
    XCTAssertTrue((self.lampState.saturation == saturationData), @"Saturation should be equal to 50");
}

-(void)testColorTemp
{
    XCTAssertTrue((self.lampState.colorTemp == 0), @"Color Temp should be zero initially");
    
    unsigned int colorTempData = 100;
    self.lampState.colorTemp = colorTempData;
    XCTAssertTrue((self.lampState.colorTemp == colorTempData), @"Color Temp should be equal to 100");
    
    colorTempData = 50;
    self.lampState.colorTemp = colorTempData;
    XCTAssertTrue((self.lampState.colorTemp == colorTempData), @"Color Temp should be equal to 50");
}

-(void)testIsNull
{
    XCTAssertTrue(self.lampState.isNull, @"IsNull should be true initially");

    self.lampState.isNull = NO;
    XCTAssertFalse(self.lampState.isNull, @"IsNull should be false");

    self.lampState.isNull = YES;
    XCTAssertTrue(self.lampState.isNull, @"IsNull should be true");
}

@end
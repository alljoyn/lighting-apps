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

#import "LSFPulseEffectTutorialViewController.h"
#import "LSFSDKLightingDirector.h"
#import "LSFSDKLightingController.h"
#import "LSFSDKLightingControllerConfigurationBase.h"
#import "LSFSDKAllLightingItemDelegateBase.h"
#import "LSFSDKMyLampState.h"

/*
 * Global Lighting event delegate. Responsible for handling any callbacks that
 * the user is interested in acting on.
 */
@interface MyLightingDelegate : LSFSDKAllLightingItemDelegateBase

@property (nonatomic, strong) LSFSDKTrackingID *groupCreationID;
@property (nonatomic, strong) NSString *tutorialGroupID;

@end

@implementation MyLightingDelegate

@synthesize groupCreationID = _groupCreationID;
@synthesize tutorialGroupID = _tutorialGroupID;

-(id)init
{
    self = [super init];

    if (self)
    {
        self.groupCreationID = nil;
        self.tutorialGroupID = nil;
    }

    return self;
}

-(void)onGroupInitializedWithTrackingID:(LSFSDKTrackingID *)trackingID andGroup:(LSFSDKGroup *)group
{
    // STEP 4: Using the Group initialized callback as a trigger, create a Pulse Effect
    if (trackingID != nil && self.groupCreationID != nil && group != nil && trackingID.value == self.groupCreationID.value)
    {
        // Save the ID of the Group; to be used later
        self.tutorialGroupID = [group theID];

        // Pulse Effect parameters
        LSFSDKColor *pulseFromColor = [LSFSDKColor green];
        LSFSDKColor *pulseToColor = [LSFSDKColor blue];
        Power pulsePowerState = ON;
        unsigned int period = 1000;
        unsigned int duration = 500;
        unsigned int numPulses = 10;
        LSFSDKMyLampState *fromState = [[LSFSDKMyLampState alloc] initWithPower: pulsePowerState color: pulseFromColor];
        LSFSDKMyLampState *toState = [[LSFSDKMyLampState alloc] initWithPower: pulsePowerState color: pulseToColor];

        // boilerplate code, alter parameters above to change effect color, length, etc.
        [[LSFSDKLightingDirector getLightingDirector] createPulseEffectWithFromState: fromState toState: toState period: period duration: duration count: numPulses name: @"TutorialPulseEffect"];
    }
}

-(void)onGroupError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onGroupError - Error Name = %@", error.name);
}

-(void)onPulseEffectInitializedWithTrackingID:(LSFSDKTrackingID *)trackingID andPulseEffect:(LSFSDKPulseEffect *)pulseEffect
{
    // STEP 5: Using the Pulse Effect initialized callback as a trigger, apply the Pulse Effect to the
    // Group created in STEP 4
    if (self.tutorialGroupID != nil)
    {
        [pulseEffect applyToGroupMember: [[LSFSDKLightingDirector getLightingDirector] getGroupWithID: self.tutorialGroupID]];
    }
}

-(void)onPulseEffectError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onPulseEffectError - Error Name = %@", error.name);
}

@end //End private class

static unsigned int CONTROLLER_CONNECTION_DELAY = 5000;

@interface LSFPulseEffectTutorialViewController ()

@property (nonatomic, strong) LSFSDKLightingDirector *lightingDirector;
@property (nonatomic, strong) MyLightingDelegate *myLightingDelegate;
@property (nonatomic, strong) LSFSDKLightingControllerConfigurationBase *config;

@end

@implementation LSFPulseEffectTutorialViewController

@synthesize versionLabel = _versionLabel;
@synthesize lightingDirector = _lightingDirector;
@synthesize myLightingDelegate = _myLightingDelegate;
@synthesize config = _config;

-(void)viewDidLoad
{
    [super viewDidLoad];

    //Display the version number
    NSMutableString *appVersion = [NSMutableString stringWithFormat: @"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [appVersion appendString: [NSString stringWithFormat: @".%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]];
    [self.versionLabel setText: appVersion];

    // STEP 1: Initialize a lighting controller with default configuration
    self.config = [[LSFSDKLightingControllerConfigurationBase alloc]initWithKeystorePath: @"Documents"];
    LSFSDKLightingController *lightingController = [LSFSDKLightingController getLightingController];
    [lightingController initializeWithControllerConfiguration: self.config];
    [lightingController start];

    // STEP 2: Instantiate the lighting director and wait for the connection, register a global delegate to
    // handle Lighting events
    self.myLightingDelegate = [[MyLightingDelegate alloc] init];
    self.lightingDirector = [LSFSDKLightingDirector getLightingDirector];
    [self.lightingDirector addDelegate: self.myLightingDelegate];
    [self.lightingDirector postOnNextControllerConnectionWithDelay: CONTROLLER_CONNECTION_DELAY delegate: self];
    [self.lightingDirector start];
}

-(void)dealloc
{
    if (self.lightingDirector)
    {
        [self.lightingDirector stop];
        self.lightingDirector = nil;
    }
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * LSFSDKNextControllerConnectionDelegate implementation
 */
-(void)onNextControllerConnection
{
    // STEP 3: Create a Group consisting of all connected lamps
    NSArray *lamps = [self.lightingDirector lamps];
    self.myLightingDelegate.groupCreationID = [[LSFSDKLightingDirector getLightingDirector] createGroupWithMembers: lamps groupName: @"TutorialGroup"];
}

@end
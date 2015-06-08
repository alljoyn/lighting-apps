/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFPulseEffectTutorialViewController.h"
#import "LSFSDKLightingDirector.h"
#import "LSFSDKAllCollectionAdapter.h"
#import "LSFSDKMyLampState.h"

/*
 * Global Lighting event listener. Responsible for handling any callbacks that
 * the user is interested in acting on.
 */
@interface MyLightingDelegate : LSFSDKAllCollectionAdapter

@property (nonatomic, strong) LSFTrackingID *groupCreationID;
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

-(void)onGroupInitializedWithTrackingID:(LSFTrackingID *)trackingID andGroup:(LSFSDKGroup *)group
{
    if (trackingID != nil && self.groupCreationID != nil && group != nil && trackingID.value == self.groupCreationID.value)
    {
        // Save the ID of the Group; to be used later
        self.tutorialGroupID = [group theID];

        // STEP 3: Use the Group creation event as a trigger to create the PulseEffect
        LSFSDKColor *pulseFromColor = [LSFSDKColor green];
        LSFSDKColor *pulseToColor = [LSFSDKColor blue];
        Power pulsePowerState = ON;
        unsigned int period = 1000;
        unsigned int duration = 500;
        unsigned int numPulses = 10;

        // boilerplate code, alter parameters above to change effect color, length, etc.
        LSFSDKMyLampState *fromState = [[LSFSDKMyLampState alloc] initWithPower: pulsePowerState color: pulseFromColor];
        LSFSDKMyLampState *toState = [[LSFSDKMyLampState alloc] initWithPower: pulsePowerState color: pulseToColor];
        [[LSFSDKLightingDirector getLightingDirector] createPulseEffectWithFromState: fromState toState: toState period: period duration: duration count: numPulses name: @"TutorialPulseEffect" delegate: nil];
    }
}

-(void)onGroupError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onGroupError - Error Name = %@", error.name);
}

-(void)onPulseEffectInitializedWithTrackingID:(LSFTrackingID *)trackingID andPulseEffect:(LSFSDKPulseEffect *)pulseEffect
{
    // STEP4: Apply the PulseEffect
    if (self.tutorialGroupID != nil)
    {
        [pulseEffect applyToGroupMember: [[LSFSDKLightingDirector getLightingDirector] getGroupWithID: self.tutorialGroupID]];
    }
}

-(void)onPulseEffectError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onGroupError - Error Name = %@", error.name);
}

@end //End private class

static unsigned int CONTROLLER_CONNECTION_DELAY = 5000;

@interface LSFPulseEffectTutorialViewController ()

@property (nonatomic, strong) LSFSDKLightingDirector *lightingDirector;
@property (nonatomic, strong) MyLightingDelegate *myLightingDelegate;

@end

@implementation LSFPulseEffectTutorialViewController

@synthesize versionLabel = _versionLabel;
@synthesize lightingDirector = _lightingDirector;
@synthesize myLightingDelegate = _myLightingDelegate;

-(void)viewDidLoad
{
    [super viewDidLoad];

    //Display the version number
    NSMutableString *appVersion = [NSMutableString stringWithFormat: @"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [appVersion appendString: [NSString stringWithFormat: @".%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]];
    [self.versionLabel setText: appVersion];

    // Instantiate the director and wait for the connection
    self.lightingDirector = [LSFSDKLightingDirector getLightingDirector];

    // STEP 1: Register a global delegate to handle Lighting events and Controller connection
    self.myLightingDelegate = [[MyLightingDelegate alloc] init];
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
    // STEP 2: Create a Group consisting of all connected lamps
    NSArray *lamps = [self.lightingDirector lamps];
    self.myLightingDelegate.groupCreationID = [[LSFSDKLightingDirector getLightingDirector] createGroupWithMembers: lamps groupName: @"TutorialGroup" delegate: nil];
}

@end
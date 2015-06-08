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

#import "LSFSceneTutorialViewController.h"
#import "LSFSDKLightingDirector.h"
#import "LSFSDKMyLampState.h"
#import "LSFSDKAllCollectionAdapter.h"

//Private inner classes that serve as one-shot delegate for the various objects
@interface MyLightingDelegate : LSFSDKAllCollectionAdapter

@end

@implementation MyLightingDelegate

-(void)onPulseEffectInitializedWithTrackingID: (LSFTrackingID *)trackingID andPulseEffect: (LSFSDKPulseEffect *)pulseEffect
{
    // STEP 3B: Create SceneElement with newly created PulseEffect
    NSArray *members = [[LSFSDKLightingDirector getLightingDirector] lamps];
    [[LSFSDKLightingDirector getLightingDirector] createSceneElementWithEffect: pulseEffect groupMembers: members name: @"TutorialSceneElement" delegate: self];
}

-(void)onPulseEffectError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onPulseEffectError - Error Name = %@", error.name);
}

-(void)onSceneElementInitializedWithTrackingID: (LSFTrackingID *)trackingID andSceneElement: (LSFSDKSceneElement *)sceneElement
{
    // STEP 3C: Create Scene using newly created SceneElement
    NSArray *sceneElements = [NSArray arrayWithObjects: sceneElement, nil];
    [[LSFSDKLightingDirector getLightingDirector] createSceneWithSceneElements: sceneElements name: @"TutorialScene" delegate: self];
}

-(void)onSceneElementError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onSceneElementError - Error Name = %@", error.name);
}

-(void)onSceneInitializedWithTrackingID: (LSFTrackingID *)trackingID andScene: (LSFSDKScene *)scene
{
    // STEP 4: Apply The scene
    [scene apply];
}

-(void)onSceneError:(LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onSceneError - Error Name = %@", error.name);
}

@end //End private inner classes

static unsigned int CONTROLLER_CONNECTION_DELAY = 5000;

@interface LSFSceneTutorialViewController ()

@property (nonatomic, strong) LSFSDKLightingDirector *lightingDirector;
@property (nonatomic, strong) MyLightingDelegate *myLightingDelegate;

@end

@implementation LSFSceneTutorialViewController

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

    // Instantiate the director and create the object we will use as the one-shot delegate
    self.lightingDirector = [LSFSDKLightingDirector getLightingDirector];
    self.myLightingDelegate = [[MyLightingDelegate alloc] init];

    // STEP 1: Register a listener for when the Controller connects and start the LightingDirector
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
    // STEP 2: Define all parameters used in creating a Scene.
    LSFSDKColor *pulseFromColor = [LSFSDKColor green];
    LSFSDKColor *pulseToColor = [LSFSDKColor blue];
    Power pulsePowerState = ON;
    unsigned int period = 1000;
    unsigned int duration = 500;
    unsigned int numPulses = 10;

    // STEP 3: Start Scene creation process, creating all intermediate objects necessary along the way.
    // boilerplate code, alter parameters in STEP 2 to change effect color, length, etc.

    // STEP 3A: Create PulseEffect
    LSFSDKMyLampState *fromState = [[LSFSDKMyLampState alloc] initWithPower: pulsePowerState color: pulseFromColor];
    LSFSDKMyLampState *toState = [[LSFSDKMyLampState alloc] initWithPower: pulsePowerState color: pulseToColor];
    [[LSFSDKLightingDirector getLightingDirector] createPulseEffectWithFromState: fromState toState: toState period: period duration: duration count: numPulses name: @"TutorialPulseEffect" delegate: self.myLightingDelegate];
}

@end
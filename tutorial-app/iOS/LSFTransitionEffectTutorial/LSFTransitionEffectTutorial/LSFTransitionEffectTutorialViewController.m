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

#import "LSFTransitionEffectTutorialViewController.h"
#import "LSFSDKLightingDirector.h"
#import "LSFSDKTransitionEffectAdapter.h"
#import "LSFSDKMyLampState.h"

//Private inner class that serves as the TransitionEffect one-shot delegate
@interface MyTransitionEffectDelegate : LSFSDKTransitionEffectAdapter

@end

@implementation MyTransitionEffectDelegate

-(void)onTransitionEffectInitializedWithTrackingID: (LSFTrackingID *)trackingID andTransitionEffect: (LSFSDKTransitionEffect *)transitionEffect
{
    // STEP 3: Apply the transition effect
    for (LSFSDKLamp *lamp in [[LSFSDKLightingDirector getLightingDirector] lamps])
    {
        [transitionEffect applyToGroupMember: lamp];
    }
}

-(void)onTransitionEffectError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onTransitionEffectError - ErrorName = %@", error.name);
}

@end //End private inner class

static unsigned int CONTROLLER_CONNECTION_DELAY = 5000;

@interface LSFTransitionEffectTutorialViewController()

@property (nonatomic, strong) LSFSDKLightingDirector *lightingDirector;

@end

@implementation LSFTransitionEffectTutorialViewController

@synthesize versionLabel = _versionLabel;
@synthesize lightingDirector = _lightingDirector;

-(void)viewDidLoad
{
    [super viewDidLoad];

    //Display the version number
    NSMutableString *appVersion = [NSMutableString stringWithFormat: @"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [appVersion appendString: [NSString stringWithFormat: @".%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]];
    [self.versionLabel setText: appVersion];

    // Instantiate the director and wait for the connection
    self.lightingDirector = [LSFSDKLightingDirector getLightingDirector];

    // STEP 1: Register a delegate for when the Controller connects and start the LightingDirector
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
    // STEP 2: Create a TransitionEffect and listen for events using a one-shot Listener
    MyTransitionEffectDelegate *myTransitionEffectDelegate = [[MyTransitionEffectDelegate alloc] init];
    LSFSDKMyLampState *myLampState = [[LSFSDKMyLampState alloc] initWithPower: ON color: [LSFSDKColor red]];
    [[LSFSDKLightingDirector getLightingDirector] createTransitionEffectWithLampState: myLampState duration: 5000 name: @"TutorialTransition" delegate: myTransitionEffectDelegate];
}

@end
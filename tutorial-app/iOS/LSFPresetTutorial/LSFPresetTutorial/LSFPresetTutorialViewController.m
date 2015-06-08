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

#import "LSFPresetTutorialViewController.h"
#import "LSFSDKLightingDirector.h"
#import "LSFSDKAllCollectionAdapter.h"

/*
 * Global Lighting event listener that is responsible for handling any callbacks that
 * the user is interested in acting on.
 */
@interface MyLightingDelegate : LSFSDKAllCollectionAdapter

// Intentionally left blank

@end

@implementation MyLightingDelegate

-(void)onLampInitialized: (LSFSDKLamp *)lamp
{
     // STEP 2: Use the discovery of the Lamp as a trigger for creating a Preset. We define a
     // preset that changes the Lamp to the color red.
    [[LSFSDKLightingDirector getLightingDirector] createPresetWithPower: ON color: [LSFSDKColor red] presetName: @"TutorialPreset" delegate: nil];
}

-(void)onLampError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onLampError - ErrorName = %@", error.name);
}

-(void)onPresetInitializedWithTrackingID: (LSFTrackingID *)trackingID andPreset: (LSFSDKPreset *)preset
{
    // STEP 3: After the Preset is created, apply the Preset to all lamps on the network
    for (LSFSDKLamp *lamp in [[LSFSDKLightingDirector getLightingDirector] lamps])
    {
        [preset applyToGroupMember: lamp];
    }
}

-(void)onPresetError: (LSFSDKLightingItemErrorEvent *)error
{
    NSLog(@"onPresetError - ErrorName = %@", error.name);
}

@end //End private class

@interface LSFPresetTutorialViewController ()

@property (nonatomic, strong) LSFSDKLightingDirector *lightingDirector;

@end

@implementation LSFPresetTutorialViewController

@synthesize versionLabel = _versionLabel;
@synthesize lightingDirector = _lightingDirector;

-(void)viewDidLoad
{
    [super viewDidLoad];

    // Display the version number
    NSMutableString *appVersion = [NSMutableString stringWithFormat: @"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [appVersion appendString: [NSString stringWithFormat: @".%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]];
    [self.versionLabel setText: appVersion];

    // Instantiate the director
    self.lightingDirector = [LSFSDKLightingDirector getLightingDirector];

    // STEP 1: Register a global listener to handle lighting events and start the lighting director
    MyLightingDelegate *lightingDelegate = [[MyLightingDelegate alloc] init];
    [self.lightingDirector addDelegate: lightingDelegate];
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

@end
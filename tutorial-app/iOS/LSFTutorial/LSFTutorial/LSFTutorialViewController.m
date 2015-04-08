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

#import "LSFTutorialViewController.h"
#import "LSFLightingDirector.h"
#import "LSFLamp.h"
#import "LSFGroup.h"
#import "LSFLightingScene.h"

@interface LSFTutorialViewController ()

@property (nonatomic, strong) LSFLightingDirector *lightingDirector;

@end

@implementation LSFTutorialViewController

@synthesize versionLabel = _versionLabel;
@synthesize lightingDirector = _lightingDirector;

-(void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableString *appVersion = [NSMutableString stringWithFormat: @"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    [appVersion appendString: [NSString stringWithFormat: @".%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]]];
    [self.versionLabel setText: appVersion];

    self.lightingDirector = [[LSFLightingDirector alloc] init];
    [self.lightingDirector postOnNextControllerConnection: self];
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
 * Some_Callback_Delegate implementation
 */
-(void)onNextControllerConnection
{
    NSLog(@"LSFTutorialViewController - onNextControllerConnection() executing");

    // Lamp operations
    NSArray *lamps = [self.lightingDirector getLamps];

    for (LSFLamp *lamp in lamps)
    {
        [lamp turnOn];
    }

    [NSThread sleepForTimeInterval: 2.0];

    for (LSFLamp *lamp in lamps)
    {
        [lamp turnOff];
    }

    [NSThread sleepForTimeInterval: 2.0];

    for (int i = 0; i < lamps.count; i++)
    {
        LSFLamp *lamp = [lamps objectAtIndex: i];
        [lamp setColorWithHue: 180 saturation: 100 brightness: 50 andColorTemp: 4000];
    }

    // Group operations
    NSArray *groups = [self.lightingDirector getGroups];

    for (LSFGroup *group in groups)
    {
        [group turnOn];
    }

    [NSThread sleepForTimeInterval: 2.0];

    for (LSFGroup *group in groups)
    {
        [group turnOff];
    }

    [NSThread sleepForTimeInterval: 2.0];

    for (LSFGroup *group in groups)
    {
        [group setColorWithHue: 280 saturation: 100 brightness: 100 andColorTemp: 4000];
    }

    [NSThread sleepForTimeInterval: 2.0];

    // Scene operations
    NSArray *scenes = [self.lightingDirector getScenes];

    for (int i = 0; i < scenes.count; i++)
    {
        LSFLightingScene *scene = [scenes objectAtIndex: i];
        [scene apply];
    }
}

@end
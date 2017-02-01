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

#import "LSFTransitionEffectV2TableViewController.h"
#import "LSFEffectV2NumericPropertyViewController.h"
#import "LSFSelectPresetTableViewController.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>

@interface LSFTransitionEffectV2TableViewController ()

@end

@implementation LSFTransitionEffectV2TableViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];

    [self updatePresetButtonTitle: self.presetButton];

    self.durationLabel.text = [NSString stringWithFormat:@"%@ seconds", [@(self.pendingEffect.duration / 1000.0) stringValue]];

    if (!self.pendingEffect.theID)
    {
        self.pendingEffect.name = [TRANSITION_NAME_PREFIX stringByAppendingString: [LSFUtilityFunctions generateRandomHexStringWithLength: 16]];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return (section == 0) ? [NSString stringWithFormat: @"Select the properties that %@ will transition to", [LSFUtilityFunctions memberStringForPendingSceneElement: self.pendingSceneElement]] : @"";
}

-(IBAction)doneButtonPressed:(id)sender
{
    NSLog(@"Done Button Pressed for TransitionEffect");
    [super doneButtonPressed: sender];
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(IBAction)onSliderTouchUpInside: (UISlider *)slider
{
    [super onSliderTouchUpInside: slider];
    [self updatePresetButtonTitle: self.presetButton];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"TransitionDuration"])
    {
        LSFEffectV2NumericPropertyViewController *enpvc = [segue destinationViewController];
        enpvc.pendingEffect = self.pendingEffect;
        enpvc.effectType = TRANSITION;
        enpvc.effectProperty = DURATION;
    }
    else if ([segue.identifier isEqualToString: @"TransitionPreset"])
    {
        // store the latest slider state into the pending effect
        self.pendingEffect.state = [self getSlidersState];

        LSFSelectPresetTableViewController *sptvc = [segue destinationViewController];
        sptvc.state = self.pendingEffect.state;
    }
}

@end
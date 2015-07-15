/******************************************************************************
 * Copyright (c) AllSeen Alliance. All rights reserved.
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

#import "LSFPresetEffectV2TableViewController.h"
#import <LSFSDKLightingDirector.h>

@interface LSFPresetEffectV2TableViewController ()

@end

@implementation LSFPresetEffectV2TableViewController

-(IBAction)doneButtonPressed:(id)sender
{
    NSLog(@"Done Button Pressed for Preset");

    [super doneButtonPressed: sender];

    LSFSDKMyLampState *presetState = self.pendingEffect.state;

    [[LSFSDKLightingDirector getLightingDirector] createPresetWithPower: presetState.power color: presetState.color presetName: self.pendingEffect.name];

    [self dismissViewControllerAnimated: YES completion: nil];
}

@end

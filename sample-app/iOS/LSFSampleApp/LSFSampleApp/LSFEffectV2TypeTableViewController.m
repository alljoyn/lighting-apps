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

#import "LSFEffectV2TypeTableViewController.h"
#import "LSFEffectV2PropertiesTableViewController.h"
#import "LSFPresetEffectV2TableViewController.h"
#import "LSFTransitionEffectV2TableViewController.h"
#import "LSFPulseEffectV2TableViewController.h"

@interface LSFEffectV2TypeTableViewController ()

@end

@implementation LSFEffectV2TypeTableViewController

@synthesize pendingScene = _pendingScene;
@synthesize pendingSceneElement = _pendingSceneElement;
@synthesize pendingEffect = _pendingEffect;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];

    if (self.pendingEffect.theID)
    {
        self.selectedIndexPath = [NSIndexPath indexPathForRow: self.pendingEffect.type inSection: 0];
        [self nextButtonPressed: nil];
    }
}

-(void)buildTable
{
    [self.data addObject: @"Preset"];
    [self.data addObject: @"Transition"];
    [self.data addObject: @"Pulse"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"EffectType" forIndexPath:indexPath];

    if (self.selectedIndexPath == nil && indexPath.row == 0)
    {
        self.selectedIndexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    NSString *effectType = [self.data objectAtIndex: [indexPath row]];
    cell.textLabel.text = effectType;

    if ([effectType isEqualToString: @"Preset"])
    {
        cell.imageView.image = [UIImage imageNamed: @"list_constant_icon.png"];
    }
    else if ([effectType isEqualToString: @"Transition"])
    {
        cell.imageView.image = [UIImage imageNamed: @"list_transition_icon.png"];
    }
    else if ([effectType isEqualToString: @"Pulse"])
    {
        cell.imageView.image = [UIImage imageNamed: @"list_pulse_icon.png"];
    }

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Select the Effect type";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *identifier = segue.identifier;
    LSFEffectV2PropertiesTableViewController *etvc = [segue destinationViewController];
    etvc.pendingSceneElement = self.pendingSceneElement;
    etvc.pendingScene = self.pendingScene;
    etvc.pendingEffect = self.pendingEffect;

    if ([identifier isEqualToString: @"TransitionEffect"])
    {
        etvc.pendingEffect.duration = 5000;
    }
    else if ([identifier isEqualToString: @"PulseEffect"])
    {
        etvc.pendingEffect.duration = 500;
    }
}

-(IBAction)nextButtonPressed:(id)sender
{
    NSLog(@"%s", __FUNCTION__);
    switch (self.selectedIndexPath.row)
    {
        case 0:
            self.pendingEffect.type = PRESET;
            [self performSegueWithIdentifier: @"PresetEffect" sender: self];
            break;
        case 1:
            self.pendingEffect.type = TRANSITION;
            [self performSegueWithIdentifier: @"TransitionEffect" sender: self];
            break;
        case 2:
            self.pendingEffect.type = PULSE;
            [self performSegueWithIdentifier: @"PulseEffect" sender: self];
            break;
    }
}

-(IBAction)cancelButtonPressed: (id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
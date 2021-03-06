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

#import "LSFSceneElementEffectPropertiesViewController.h"
#import "LSFTransitionEffectTableViewController.h"
#import "LSFPulseEffectTableViewController.h"
#import <LSFSDKLightingDirector.h>

@interface LSFSceneElementEffectPropertiesViewController ()

-(void)leaderModelChangedNotificationReceived: (NSNotification *)notification;
-(void)sceneRemovedNotificationReceived: (NSNotification *)notification;
-(void)alertSceneDeleted: (LSFSDKScene *)scene;
-(BOOL)checkIfValueExceedsMaximum: (unsigned long long)value;
-(void)showErrorMessage;

@end

@implementation LSFSceneElementEffectPropertiesViewController

@synthesize sceneID = _sceneID;
@synthesize effectProperty = _effectProperty;
@synthesize tedm = _tedm;
@synthesize pedm = _pedm;
@synthesize durationTextField = _durationTextField;
@synthesize effectSender = _effectSender;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];
    [self.durationTextField becomeFirstResponder];

    //Set scenes notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneRemovedNotificationReceived:) name: @"LSFSceneRemovedNotification" object: nil];

    switch (self.effectProperty)
    {
        case TransitionDuration:
            self.durationTextField.placeholder = @"Enter transition duration in seconds";
            break;
        case PulseDuration:
            self.durationTextField.placeholder = @"Enter pulse duration in seconds";
            break;
        case PulsePeriod:
            self.durationTextField.placeholder = @"Enter pulse period in seconds";
            break;
        case PulseNumPulses:
        {
            self.durationTextField.placeholder = @"Enter number of pulses";
            self.durationTextField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        }
    }
}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];

    //Clear scenes notification handler
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * Notification Handlers
 */
-(void)leaderModelChangedNotificationReceived:(NSNotification *)notification
{
    LSFSDKController *leaderModel = [notification.userInfo valueForKey: @"leader"];
    if (![leaderModel connected])
    {
        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

-(void)sceneRemovedNotificationReceived:(NSNotification *)notification
{
    LSFSDKScene *scene = [notification.userInfo valueForKey: @"scene"];

    if ([self.sceneID isEqualToString: scene.theID])
    {
        [self alertSceneDeleted: scene];
    }
}

-(void)alertSceneDeleted: (LSFSDKScene *)scene
{
    [self dismissViewControllerAnimated: NO completion: nil];

    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Scene Not Found"
                                                        message: [NSString stringWithFormat: @"The scene \"%@\" no longer exists.", [scene name]]
                                                       delegate: nil
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];
    });
}

/*
 * Done Button Event Handler
 */
-(IBAction)doneButtonPressed: (id)sender
{
    [self.durationTextField resignFirstResponder];

    switch (self.effectProperty)
    {
        case TransitionDuration:
        {
            if (![self checkIfValueExceedsMaximum: ([self.durationTextField.text doubleValue] * 1000.0)])
            {
                self.tedm.duration = ([self.durationTextField.text doubleValue] * 1000.0);
            }
            else
            {
                return;
            }
            break;
        }
        case PulseDuration:
        {
            if (![self checkIfValueExceedsMaximum: ([self.durationTextField.text doubleValue] * 1000.0)])
            {
                self.pedm.duration = ([self.durationTextField.text doubleValue] * 1000.0);
            }
            else
            {
                return;
            }
            break;
        }
        case PulsePeriod:
        {
            if (![self checkIfValueExceedsMaximum: ([self.durationTextField.text doubleValue] * 1000.0)])
            {
                unsigned int pulsePeriod = ([self.durationTextField.text doubleValue] * 1000.0);
                self.pedm.period = pulsePeriod;
            }
            else
            {
                return;
            }
            break;
        }
        case PulseNumPulses:
        {
            if (![self checkIfValueExceedsMaximum: strtoull([self.durationTextField.text UTF8String], NULL, 0)])
            {
                self.pedm.numPulses = ((unsigned int)strtoull([self.durationTextField.text UTF8String], NULL, 0));
            }
            else
            {
                return;
            }
            break;
        }
    }

    [self.durationTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated: YES];
}

/*
 * Private Functions
 */
-(BOOL)checkIfValueExceedsMaximum: (unsigned long long)value
{
    if (value > 4294967295)
    {
        [self showErrorMessage];
        return YES;
    }
    else
    {
        return NO;
    }
}

-(void)showErrorMessage
{
    NSString *field;

    switch (self.effectProperty)
    {
        case TransitionDuration:
            field = @"transition duration";
            break;
        case PulseDuration:
            field = @"pulse duration";
            break;
        case PulsePeriod:
            field = @"pulse period";
            break;
        case PulseNumPulses:
            field = @"number of pulses";
            break;
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error"
                                                    message: [NSString stringWithFormat: @"Value entered for %@ is too large", field]
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

@end
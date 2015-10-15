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

#import "LSFLightsCreatePresetViewController.h"
#import "LSFUtilityFunctions.h"
#import "LSFLightInfoTableViewController.h"
#import <LSFSDKLightingDirector.h>

@interface LSFLightsCreatePresetViewController ()

@property (nonatomic) BOOL doneButtonPressed;

-(void)leaderModelChangedNotificationReceived:(NSNotification *)notification;
-(void)lampRemovedNotificationReceived: (NSNotification *)notification;
-(void)deleteLampWithID: (NSString *)lampID andName: (NSString *)lampName;

@end

@implementation LSFLightsCreatePresetViewController

@synthesize lampID = _lampID;
@synthesize presetNameTextField = _presetNameTextField;
@synthesize doneButtonPressed = _doneButtonPressed;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];

    int numPresets = (int) [[[LSFSDKLightingDirector getLightingDirector] presets] count];

    [self.presetNameTextField becomeFirstResponder];
    self.presetNameTextField.text = [NSString stringWithFormat: @"Preset %i", ++numPresets];
    self.doneButtonPressed = NO;

    //Set lamps notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(lampRemovedNotificationReceived:) name: @"LSFLampRemovedNotification" object: nil];

}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];

    //Clear lamps notification handler
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

-(void)lampRemovedNotificationReceived: (NSNotification *)notification
{
    LSFSDKLamp *lamp = [notification.userInfo valueForKey: @"lamp"];

    if ([self.lampID isEqualToString: [lamp theID]])
    {
        [self deleteLampWithID: [lamp theID] andName: [lamp name]];
    }
}

-(void)deleteLampWithID: (NSString *)lampID andName: (NSString *)lampName
{
    if ([self.lampID isEqualToString: lampID])
    {
        [self.navigationController popToRootViewControllerAnimated: YES];

        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Connection Lost"
                                                            message: [NSString stringWithFormat: @"Unable to connect to \"%@\".", lampName]
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        });
    }
}

/*
 * UITextFieldDelegate Implementation
 */
-(BOOL)textFieldShouldReturn: (UITextField *)textField
{

    if (![LSFUtilityFunctions checkNameLength: self.presetNameTextField.text entity: @"Preset Name"])
    {
        return NO;
    }

    if (![LSFUtilityFunctions checkWhiteSpaces: self.presetNameTextField.text entity: @"Preset Name"])
    {
        return NO;
    }

    BOOL nameMatchFound = [[[[LSFSDKLightingDirector getLightingDirector] presets] valueForKeyPath: @"name"] containsObject: self.presetNameTextField.text];
    
    if (!nameMatchFound)
    {
        self.doneButtonPressed = YES;
        [textField resignFirstResponder];

        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            LSFSDKLamp *lamp = [[LSFSDKLightingDirector getLightingDirector] getLampWithID: self.lampID];
            [[LSFSDKLightingDirector getLightingDirector] createPresetWithPower: [lamp getPower] color: [lamp getColor] presetName: self.presetNameTextField.text];
        });
        
        return YES;
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Duplicate Name"
                                                    message: [NSString stringWithFormat: @"Warning: there is already a preset named \"%@.\" Although it's possible to use the same name for more than one preset, it's better to give each preset a unique name.\n\nKeep duplicate preset name \"%@\"?", self.presetNameTextField.text, self.presetNameTextField.text]
                                                   delegate: self
                                          cancelButtonTitle: @"NO"
                                          otherButtonTitles: @"YES", nil];
    [alert show];

    return NO;
}

-(void)textFieldDidEndEditing: (UITextField *)textField
{
    if (self.doneButtonPressed)
    {
        //[self.navigationController popViewControllerAnimated: YES];

        for (UIViewController *vc in self.navigationController.viewControllers)
        {
            if ([vc isKindOfClass: [LSFLightInfoTableViewController class]])
            {
                [self.navigationController popToViewController: (LSFLightInfoTableViewController *)vc animated: YES];
            }
        }
    }
}

/*
 * UIAlertViewDelegate implementation
 */
-(void)alertView: (UIAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex: 0 animated: NO];
    }
    
    if (buttonIndex == 1)
    {
        [alertView dismissWithClickedButtonIndex: 1 animated: NO];
        
        self.doneButtonPressed = YES;
        [self.presetNameTextField resignFirstResponder];

        dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
            LSFSDKLamp *lamp = [[LSFSDKLightingDirector getLightingDirector] getLampWithID: self.lampID];
            [[LSFSDKLightingDirector getLightingDirector] createPresetWithPower: [lamp getPower] color: [lamp getColor] presetName: self.presetNameTextField.text];
        });
    }
}

@end
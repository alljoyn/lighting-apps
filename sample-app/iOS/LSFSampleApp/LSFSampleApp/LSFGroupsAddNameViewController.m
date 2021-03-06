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

#import "LSFGroupsAddNameViewController.h"
#import "LSFGroupsAddLampsTableViewController.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>

@interface LSFGroupsAddNameViewController ()

@property (nonatomic) BOOL doneButtonPressed;

-(void)leaderModelChangedNotificationReceived: (NSNotification *)notification;

@end

@implementation LSFGroupsAddNameViewController

@synthesize groupNameTextField = _groupNameTextField;
@synthesize doneButtonPressed = _doneButtonPressed;

-(void)viewDidLoad
{
    [super viewDidLoad];

    [self.groupNameTextField becomeFirstResponder];
    self.doneButtonPressed = NO;
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];

    //Set notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];

    //Hide toolbar because it is not needed
    [self.navigationController.toolbar setHidden: YES];
}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];

    //Clear notification handler
    [[NSNotificationCenter defaultCenter] removeObserver: self];

    //Unhide toolbar because it is not needed
    [self.navigationController.toolbar setHidden: NO];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * Notification handlers
 */
-(void)leaderModelChangedNotificationReceived:(NSNotification *)notification
{
    LSFSDKController *leaderModel = [notification.userInfo valueForKey: @"leader"];
    if (![leaderModel connected])
    {
        [self dismissViewControllerAnimated: YES completion: nil];
    }
}

/*
 * UITextFieldDelegate implementation
 */
-(BOOL)textFieldShouldReturn: (UITextField *)textField
{
    if ([self.groupNameTextField.text isEqualToString: @""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"No Group Name"
                                                        message: @"You need to provide a group name in order to proceed."
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];

        return NO;
    }

    if (![LSFUtilityFunctions checkNameLength: self.groupNameTextField.text entity: @"Group Name"])
    {
        return NO;
    }

    if (![LSFUtilityFunctions checkWhiteSpaces:self.groupNameTextField.text entity: @"Group Name"])
    {
        return NO;
    }

    BOOL nameMatchFound = [[[[LSFSDKLightingDirector getLightingDirector] groups] valueForKey: @"name"] containsObject: self.groupNameTextField.text];

    if (!nameMatchFound)
    {
        self.doneButtonPressed = YES;
        [textField resignFirstResponder];

        return YES;
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Duplicate Name"
                                                    message: [NSString stringWithFormat: @"Warning: there is already a group named \"%@.\" Although it's possible to use the same name for more than one group, it's better to give each group a unique name.\n\nKeep duplicate group name \"%@\"?", self.groupNameTextField.text, self.groupNameTextField.text]
                                                   delegate: self
                                          cancelButtonTitle: @"NO"
                                          otherButtonTitles: @"YES", nil];
    [alert show];

    return NO;
}

/*
 * UIAlertViewDelegate implementation
 */
-(void)alertView: (UIAlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex: 0 animated: YES];
    }

    if (buttonIndex == 1)
    {
        [alertView dismissWithClickedButtonIndex: 1 animated: NO];

        self.doneButtonPressed = YES;
        [self.groupNameTextField resignFirstResponder];

        [self performSegueWithIdentifier: @"ChooseGroupLamps" sender: nil];
    }
}

/*
 * Cancel Button Handler
 */
-(IBAction)cancelGroupCreate: (id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

/*
 * Next Button Handler
 */
-(IBAction)nextButtonPressed: (id)sender
{
    if ([self.groupNameTextField.text isEqualToString: @""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"No Group Name"
                                                        message: @"You need to provide a group name in order to proceed."
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];

        return;
    }

    if (![LSFUtilityFunctions checkNameLength: self.groupNameTextField.text entity: @"Group Name"])
    {
        return;
    }

    if (![LSFUtilityFunctions checkWhiteSpaces:self.groupNameTextField.text entity: @"Group Name"])
    {
        return;
    }

    BOOL nameMatchFound = [[[[LSFSDKLightingDirector getLightingDirector] groups] valueForKey: @"name"] containsObject: self.groupNameTextField.text];

    if (!nameMatchFound)
    {
        self.doneButtonPressed = YES;
        [self.groupNameTextField resignFirstResponder];

        [self performSegueWithIdentifier: @"ChooseGroupLamps" sender: nil];

        return;
    }

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Duplicate Name"
                                                    message: [NSString stringWithFormat: @"Warning: there is already a group named \"%@.\" Although it's possible to use the same name for more than one group, it's better to give each group a unique name.\n\nKeep duplicate group name \"%@\"?", self.groupNameTextField.text, self.groupNameTextField.text]
                                                   delegate: self
                                          cancelButtonTitle: @"NO"
                                          otherButtonTitles: @"YES", nil];
    [alert show];
}

/*
 * Segue Methods
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"ChooseGroupLamps"])
    {
        LSFGroupsAddLampsTableViewController *galtvc = [segue destinationViewController];
        galtvc.groupName = [NSString stringWithFormat: @"%@", self.groupNameTextField.text];
    }
}

@end
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

#import "LSFScenesEnterNameViewController.h"
#import "LSFScenesCreateSceneElementsTableViewController.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>

@interface LSFScenesEnterNameViewController ()

-(void)leaderModelChangedNotificationReceived:(NSNotification *)notification;

@end

@implementation LSFScenesEnterNameViewController

@synthesize sceneModel = _sceneModel;
@synthesize nameTextField = _nameTextField;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];
    [self.nameTextField becomeFirstResponder];
    [self.navigationController.toolbar setHidden: YES];

    //Set notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];
}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];
    [self.navigationController.toolbar setHidden: NO];

    //Clear notification handler
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * Notification Handler
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
    [textField resignFirstResponder];
    return YES;
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
        [self.nameTextField resignFirstResponder];
        [self performSegueWithIdentifier: @"SceneElements" sender: self];
    }
}

/*
 * Cancel Button Handler
 */
-(IBAction)cancelButtonPressed: (id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

/*
 * Next Button Handler
 */
-(IBAction)nextButtonPressed: (id)sender
{
    if ([self.nameTextField.text isEqualToString: @""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"No Scene Name"
                                                        message: @"You need to provide a scene name in order to proceed."
                                                       delegate: self
                                              cancelButtonTitle: @"OK"
                                              otherButtonTitles: nil];
        [alert show];

        return;
    }
    else if (![LSFUtilityFunctions checkNameLength: self.nameTextField.text entity: @"Scene Name"])
    {
        return;
    }
    else if (![LSFUtilityFunctions checkWhiteSpaces:self.nameTextField.text entity: @"Scene Name"])
    {
        return;
    }
    else if ([self checkForDuplicateName: self.nameTextField.text])
    {
        return;
    }
    else
    {
        [self performSegueWithIdentifier: @"SceneElements" sender: self];
    }
}

/*
 * Override checkForDuplicateName function
 */
-(BOOL)checkForDuplicateName: (NSString *)name
{
    BOOL duplicate = [[[[LSFSDKLightingDirector getLightingDirector] scenes] valueForKeyPath: @"name"] containsObject: name];

    if (duplicate)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Duplicate Name"
                                                        message: [NSString stringWithFormat: @"Warning: there is already a scene named \"%@.\" Although it's possible to use the same name for more than one scene, it's better to give each scene a unique name.\n\nKeep duplicate scene name \"%@\"?", name, name]
                                                       delegate: self
                                              cancelButtonTitle: @"NO"
                                              otherButtonTitles: @"YES", nil];
        [alert show];
    }

    return duplicate;
}

/*
 * Segue Methods
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.sceneModel.name = self.nameTextField.text;

    if ([segue.identifier isEqualToString: @"SceneElements"])
    {
        LSFScenesCreateSceneElementsTableViewController *scsetvc = [segue destinationViewController];
        scsetvc.sceneModel = self.sceneModel;
    }
}

@end
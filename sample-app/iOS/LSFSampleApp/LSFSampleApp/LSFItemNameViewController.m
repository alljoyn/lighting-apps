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
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFItemNameViewController.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>

@interface LSFItemNameViewController ()

@end

@implementation LSFItemNameViewController

@synthesize entity = _entity;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.nameTextField becomeFirstResponder];
    [self.navigationController.toolbar setHidden: YES];

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];

    self.entity = @"";
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}


-(IBAction)cancelButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

-(IBAction)nextButtonPressed:(id)sender
{
    // Override in subclass if necessary
    NSLog(@"Next button pressed");
}

-(BOOL)validateNameAgainst: (NSArray *)names
{
    NSString *name = self.nameTextField.text;

    return  [LSFUtilityFunctions checkNameEmpty: name entity: self.entity]      &&
            [LSFUtilityFunctions checkNameLength: name entity: self.entity]     &&
            [LSFUtilityFunctions checkWhiteSpaces: name entity: self.entity]    &&
            ![self checkForDuplicateNameAgainst: names];
}

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
        [self doSegue];
    }
}

-(void)doSegue
{
    // meant to be overriden
}


-(BOOL)checkForDuplicateNameAgainst: (NSArray *)names
{
    NSString *name = self.nameTextField.text;

    BOOL duplicate = [names containsObject: name];

    if (duplicate)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Duplicate Name"
                                                  message: [NSString stringWithFormat: @"Warning: there is already a %1$@ named \"%2$@.\" Although it's possible to use the same name for more than one %1$@, it's better to give each %1$@ a unique name.\n\nKeep duplicate %1$@ name \"%2$@\"?", self.entity, name]
                                                 delegate: self
                                        cancelButtonTitle: @"NO"
                                        otherButtonTitles: @"YES", nil];
        [alert show];
    }

    return duplicate;
}

-(void)leaderModelChangedNotificationReceived:(NSNotification *)notification
{
    LSFSDKController *leaderModel = [notification.userInfo valueForKey: @"leader"];
    if (![leaderModel connected])
    {
        [self dismissViewControllerAnimated: YES completion: nil];
        [self.navigationController popToRootViewControllerAnimated: YES];
    }
}

@end
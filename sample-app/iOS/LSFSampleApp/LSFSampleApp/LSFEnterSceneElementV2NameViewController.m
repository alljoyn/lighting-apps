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

#import "LSFEnterSceneElementV2NameViewController.h"
#import "LSFSceneElementV2MembersTableViewController.h"
#import <LSFSDKLightingDirector.h>

@interface LSFEnterSceneElementV2NameViewController ()

@property (nonatomic) BOOL keyDonePressed;

@end

@implementation LSFEnterSceneElementV2NameViewController

@synthesize pendingSceneElement = _pendingSceneElement;
@synthesize keyDonePressed = _keyDonePressed;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.entity = @"Scene Element";
    self.keyDonePressed = NO;

    if (self.pendingSceneElement != nil)
    {
        self.nameTextField.text = self.pendingSceneElement.name;
    }
    else
    {
        self.pendingSceneElement = [[LSFPendingSceneElement alloc] init];
    }
}

-(IBAction)nextButtonPressed:(id)sender
{
    [super nextButtonPressed: sender];

    self.pendingSceneElement.name = self.nameTextField.text;

    if ([self validateNameAgainst: [[[LSFSDKLightingDirector getLightingDirector] sceneElements] valueForKeyPath: @"name"]])
    {
        [self doSegue];
    }
}

-(void)doSegue
{
    if (self.pendingSceneElement.theID == nil)
    {
        [self performSegueWithIdentifier: @"SceneElementMembers" sender: self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"SceneElementMembers"])
    {
        LSFSceneElementV2MembersTableViewController *scmvc = [segue destinationViewController];
        scmvc.pendingSceneElement = self.pendingSceneElement;
        scmvc.hasNextButton = YES;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.pendingSceneElement != nil)
    {
        if ([self validateNameAgainst: [[[LSFSDKLightingDirector getLightingDirector] sceneElements] valueForKeyPath: @"name"]])
        {
            self.pendingSceneElement.name = self.nameTextField.text;
            LSFSDKSceneElement *sceneElement = [[LSFSDKLightingDirector getLightingDirector] getSceneElementWithID: self.pendingSceneElement.theID];
            [sceneElement rename: self.pendingSceneElement.name];

            self.keyDonePressed = YES;
            [textField resignFirstResponder];
            return YES;
        }

        return NO;
    }
    else
    {
        return YES;
    }
}

- (IBAction)nameDidEndEditing:(id)sender
{
    // Only used when editing the name of an existing scene
    if (self.keyDonePressed)
    {
        [self.navigationController popViewControllerAnimated: YES];
    }
}

@end

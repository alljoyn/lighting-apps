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

#import "LSFEnterSceneV2NameTableViewController.h"
#import "LSFScenesV2Members.h"
#import "LSFPendingSceneV2.h"
#import <LSFSDKLightingDirector.h>

@interface LSFEnterSceneV2NameTableViewController ()

@property (nonatomic) BOOL keyDonePressed;

@end

@implementation LSFEnterSceneV2NameTableViewController

@synthesize pendingScene = _pendingScene;
@synthesize keyDonePressed = _keyDonePressed;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.keyDonePressed = NO;
    self.entity = @"Scene";

    if (self.pendingScene != nil)
    {
        self.nameTextField.text = self.pendingScene.name;
    }
    else
    {
        self.pendingScene = [[LSFPendingSceneV2 alloc] init];
    }
}

-(IBAction)nextButtonPressed:(id)sender
{
    [super nextButtonPressed: sender];

    self.pendingScene.name = self.nameTextField.text;

    if ([self validateNameAgainst: [[[LSFSDKLightingDirector getLightingDirector] scenes] valueForKeyPath: @"name"]])
    {
        [self doSegue];
    }
}

-(void)doSegue
{
    if (self.pendingScene.theID == nil)
    {
        [self performSegueWithIdentifier: @"SceneV2Members" sender: self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"SceneV2Members"])
    {
        LSFScenesV2Members *smvc = [segue destinationViewController];
        smvc.pendingScene = self.pendingScene;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.pendingScene.theID != nil)
    {
        if ([self validateNameAgainst: [[[LSFSDKLightingDirector getLightingDirector] scenes] valueForKeyPath: @"name"]])
        {
            self.pendingScene.name = self.nameTextField.text;
            LSFSDKScene *scene = [[LSFSDKLightingDirector getLightingDirector] getSceneWithID: self.pendingScene.theID];
            [scene rename: self.pendingScene.name];

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

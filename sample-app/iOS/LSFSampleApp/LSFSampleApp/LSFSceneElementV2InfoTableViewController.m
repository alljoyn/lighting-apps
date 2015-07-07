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

#import "LSFSceneElementV2InfoTableViewController.h"
#import "LSFSceneElementV2MembersTableViewController.h"
#import "LSFEffectsV2TableViewController.h"
#import "LSFEnterSceneElementV2NameViewController.h"
#import <LSFSDKLightingDirector.h>

@interface LSFSceneElementV2InfoTableViewController ()

@end

@implementation LSFSceneElementV2InfoTableViewController

@synthesize pendingSceneElement = _pendingSceneElement;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(leaderModelChangedNotificationReceived:) name: @"LSFContollerLeaderModelChange" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneElementChangedNotificationReceived:) name: @"LSFSceneElementChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneElementRemovedNotificationReceived:) name: @"LSFSceneElementRemovedNotification" object: nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;

    if (indexPath.section == 0)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: nil];
        cell.textLabel.text = @"Scene Element Name";
        cell.detailTextLabel.text = self.pendingSceneElement.name;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 1)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: nil];
        cell.textLabel.text = @"Lamps and Groups in the Scene Element";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 2)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleValue1 reuseIdentifier: nil];
        cell.textLabel.text = @"Scene Element Effect";

        cell.detailTextLabel.text = [self.pendingSceneElement.effect name];

        if ([self.pendingSceneElement.effect isKindOfClass: [LSFSDKPreset class]])
        {
            cell.imageView.image = [UIImage imageNamed: @"list_constant_icon.png"];
        }
        else if ([self.pendingSceneElement.effect isKindOfClass: [LSFSDKTransitionEffect class]])
        {
           cell.imageView.image = [UIImage imageNamed: @"list_transition_icon.png"];
        }
        else if ([self.pendingSceneElement.effect isKindOfClass: [LSFSDKPulseEffect class]])
        {
            cell.imageView.image = [UIImage imageNamed: @"list_pulse_icon.png"];
        }

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        [self performSegueWithIdentifier: @"ChangeSceneElementName" sender: nil];
    }
    else if (indexPath.section == 1)
    {
        [self performSegueWithIdentifier: @"ChangeSceneElementMembers" sender: nil];
    }
    else if (indexPath.section == 2)
    {
        [self performSegueWithIdentifier: @"ChangeSceneElementEffect" sender: nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"ChangeSceneElementMembers"])
    {
        UINavigationController *nc = (UINavigationController *)[segue destinationViewController];
        LSFSceneElementV2MembersTableViewController *semtvc = (LSFSceneElementV2MembersTableViewController *)nc.topViewController;
        semtvc.pendingSceneElement = self.pendingSceneElement;
        semtvc.allowCancel = YES;
        semtvc.hasDoneButton = YES;
    }
    else if ([segue.identifier isEqualToString: @"ChangeSceneElementEffect"])
    {
        UINavigationController *nc = (UINavigationController *)[segue destinationViewController];
        LSFEffectsV2TableViewController *semtvc = (LSFEffectsV2TableViewController *)nc.topViewController;
        semtvc.pendingSceneElement = self.pendingSceneElement;
        semtvc.allowCancel = YES;
    }
   else if ([segue.identifier isEqualToString: @"ChangeSceneElementName"])
   {
       LSFEnterSceneElementV2NameViewController *senvc = [segue destinationViewController];
       senvc.pendingSceneElement = self.pendingSceneElement;
   }
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

-(void)sceneElementChangedNotificationReceived: (NSNotification *)notification
{
    LSFSDKSceneElement *sceneElement = [notification.userInfo valueForKey: @"sceneElement"];

    if ([sceneElement.theID isEqualToString: self.pendingSceneElement.theID])
    {
        self.pendingSceneElement.name = sceneElement.name;
        self.pendingSceneElement.members = [NSMutableArray arrayWithArray: [sceneElement getGroups]];
        [self.pendingSceneElement.members addObjectsFromArray: [sceneElement getLamps]];
        self.pendingSceneElement.effect = [sceneElement getEffect];

        [self.tableView reloadData];
    }
}

-(void)sceneElementRemovedNotificationReceived: (NSNotification *)notification
{
    LSFSDKSceneElement *sceneElement = [notification.userInfo valueForKey: @"sceneElement"];

    if ([sceneElement.theID isEqualToString: self.pendingSceneElement.theID])
    {
        [self dismissViewControllerAnimated: YES completion: nil];

        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Scene Element Not Found"
                                                            message: [NSString stringWithFormat: @"The scene element \"%@\" no longer exists.", [sceneElement name]]
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        });
    }
}

@end

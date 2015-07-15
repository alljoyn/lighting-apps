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

#import "LSFEffectsV2TableViewController.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>
#import <LSFSDKEffect.h>

@interface LSFEffectsV2TableViewController ()

@end

@implementation LSFEffectsV2TableViewController

@synthesize pendingSceneElement = _pendingSceneElement;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];

    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(effectChanged:) name: @"LSFPresetChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(effectRemoved:) name: @"LSFPresetRemovedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(effectChanged:) name: @"LSFTransitionEffectChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(effectRemoved:) name: @"LSFTransitionEffectRemovedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(effectChanged:) name: @"LSFPulseEffectChangedNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(effectRemoved:) name: @"LSFPulseEffectRemovedNotification" object: nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target: self
                                  action: @selector(plusButtonPressed)];

    self.navigationItem.rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObjectsFromArray: @[addButton]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

-(void)buildTable
{
    if (!self.pendingSceneElement.hasEffect)
    {
        self.data = [NSMutableArray arrayWithArray: [LSFUtilityFunctions sortLightingItemsByName: [[LSFSDKLightingDirector getLightingDirector] presets]]];
    }
    else
    {
        self.data = [NSMutableArray arrayWithArray: [LSFUtilityFunctions sortLightingItemsByName: [[LSFSDKLightingDirector getLightingDirector] effects]]];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"Effect" forIndexPath:indexPath];
    id<LSFSDKEffect> effect = [self.data objectAtIndex: [indexPath row]];

    cell.textLabel.text = [effect name];

    if ([effect isKindOfClass: [LSFSDKPreset class]])
    {
        cell.imageView.image = [UIImage imageNamed: @"list_constant_icon.png"];
    }
    else if ([effect isKindOfClass: [LSFSDKTransitionEffect class]])
    {
        cell.imageView.image = [UIImage imageNamed: @"list_transition_icon.png"];
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed: @"list_pulse_icon.png"];
    }

    if (self.selectedIndexPath == nil && indexPath.row == 0 && self.pendingSceneElement.effect.theID == nil)
    {
        self.selectedIndexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else if ([self.pendingSceneElement.effect.theID isEqualToString: effect.theID])
    {
        self.selectedIndexPath = indexPath;
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }

    return cell;
}

-(BOOL)tableView: (UITableView *)tableView canEditRowAtIndexPath: (NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        id<LSFSDKEffect> effect = [self.data objectAtIndex: indexPath.row];
        NSArray *names = [self isEffectInSceneElement: effect.theID];
        if (names.count > 0)
        {
            NSMutableString *nameString = [[NSMutableString alloc] init];

            for (int i = 0; i < names.count; i++)
            {
                [nameString appendString: [NSString stringWithFormat: @"\"%@\", ", [names objectAtIndex: i]]];

                if (i == (names.count - 2))
                {
                    [nameString appendString: @"and "];
                }
            }

            [nameString deleteCharactersInRange: NSMakeRange(nameString.length - 2, 2)];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Can't Delete Effect"
                                                            message: [NSString stringWithFormat: @"The effect \"%@\" is being used by the following scene elements: %@. It cannot be deleted until it is removed from those scene elements, or those scene elements are deleted.", effect.name, nameString]
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            [self.data removeObjectAtIndex: indexPath.row];

            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

            dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
                [effect deleteItem];
            });
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat: @"Choose an effect for %@", self.pendingSceneElement.name];
}

-(void)editButtonPressed
{
    NSLog(@"%s %@", __FUNCTION__, @"edit button pressed");
}

-(void)plusButtonPressed
{
    NSLog(@"%s %@", __FUNCTION__, @"plus button pressed");
    [self performSegueWithIdentifier: @"CreateEffectV2" sender: self];
}

-(IBAction)doneButtonPressed:(id)sender
{
    NSLog(@"%s %@", __FUNCTION__, @"done button pressed");
    self.pendingSceneElement.effect = [self.data objectAtIndex: self.selectedIndexPath.row];

    if (self.pendingSceneElement.theID == nil)
    {
        [[LSFSDKLightingDirector getLightingDirector] createSceneElementWithEffect: self.pendingSceneElement.effect groupMembers: self.pendingSceneElement.members name: self.pendingSceneElement.name];
    }
    else
    {
        LSFSDKSceneElement *element = [[LSFSDKLightingDirector getLightingDirector] getSceneElementWithID: self.pendingSceneElement.theID];
        [element modifyWithEffect: self.pendingSceneElement.effect groupMembers: self.pendingSceneElement.members];
    }

    [self dismissViewControllerAnimated: YES completion: nil];
}

-(id<LSFSDKEffect>)getEffectFromNotification: (NSNotification *)notification
{
    id<LSFSDKEffect> effect = [notification.userInfo valueForKey: @"preset"];

    if (effect == nil)
    {
        effect = [notification.userInfo valueForKey: @"transitionEffect"];
    }

    if (effect == nil)
    {
        effect = [notification.userInfo valueForKey: @"pulseEffect"];
    }

    return effect;
}

-(void)effectChanged: (NSNotification *)notification
{

    id<LSFSDKEffect> effect = [self getEffectFromNotification: notification];

    @synchronized(self.data)
    {
        if (![self.data containsObject: effect])
        {
            [self.data addObject: effect];
        }

        [self.tableView reloadData];
    }
}

-(void)effectRemoved: (NSNotification *)notification
{

    id<LSFSDKEffect> effect = [self getEffectFromNotification: notification];

    @synchronized(self.data)
    {
        if ([self.data containsObject: effect])
        {
            [self.data removeObject: effect];
            [self.tableView reloadData];
        }
    }
}

-(NSArray *)isEffectInSceneElement: (NSString *)effectID
{
    NSMutableArray *names = [[NSMutableArray alloc] init];

    id<LSFSDKEffect> effect = [[LSFSDKLightingDirector getLightingDirector] getEffectWithID: effectID];
    for (LSFSDKSceneElement *element in [[LSFSDKLightingDirector getLightingDirector] sceneElements])
    {
        if ([element hasEffect: effect])
        {
            [names addObject: [NSString stringWithString: element.name]];
        }
    }

    return names;
}

@end

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

#import "LSFEffectV2TypeTableViewController.h"
#import "LSFEnterEffectV2NameViewController.h"

@interface LSFEffectV2TypeTableViewController ()

@end

@implementation LSFEffectV2TypeTableViewController

@synthesize pendingEffect = _pendingEffect;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.pendingEffect = [[LSFPendingEffect alloc] init];
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
    if ([segue.identifier isEqualToString: @"EffectV2Name"])
    {
        LSFEnterEffectV2NameViewController *eenvc = [segue destinationViewController];
        eenvc.pendingEffect = self.pendingEffect;
    }
}

-(IBAction)nextButtonPressed:(id)sender
{
    switch (self.selectedIndexPath.row)
    {
        case 0:
            self.pendingEffect.type = PRESET;
            break;
        case 1:
            self.pendingEffect.type = TRANSITION;
            break;
        case 2:
            self.pendingEffect.type = PULSE;
            break;
    }

    [self performSegueWithIdentifier: @"EffectV2Name" sender: self];
}

-(IBAction)cancelButtonPressed: (id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end

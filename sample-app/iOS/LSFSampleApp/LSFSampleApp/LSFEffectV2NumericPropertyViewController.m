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

#import "LSFEffectV2NumericPropertyViewController.h"

@interface LSFEffectV2NumericPropertyViewController ()

@end

@implementation LSFEffectV2NumericPropertyViewController

@synthesize pendingEffect = _pendingEffect;
@synthesize effectType = _effectType;
@synthesize effectProperty = _effectProperty;

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.propertyTextField becomeFirstResponder];

    [self populatePropertyField];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)doneButtonPressed:(id)sender
{
    switch (self.effectProperty)
    {
        case DURATION:
        {
            if (![self checkIfValueExceedsMaximum: ([self.propertyTextField.text doubleValue] * 1000.0)])
            {
                self.pendingEffect.duration = ([self.propertyTextField.text doubleValue] * 1000.0);
            }
            else
            {
                return;
            }
            break;
        }
        case PERIOD:
        {
            if (![self checkIfValueExceedsMaximum: ([self.propertyTextField.text doubleValue] * 1000.0)])
            {
                unsigned int pulsePeriod = ([self.propertyTextField.text doubleValue] * 1000.0);
                self.pendingEffect.period = pulsePeriod;
            }
            else
            {
                return;
            }
            break;
        }
        case NUM_PULSES:
        {
            if (![self checkIfValueExceedsMaximum: strtoull([self.propertyTextField.text UTF8String], NULL, 0)])
            {
                self.pendingEffect.pulses = ((unsigned int)strtoull([self.propertyTextField.text UTF8String], NULL, 0));
            }
            else
            {
                return;
            }
            break;
        }
        default:
            NSLog(@"Invalid property type for text field");
            return;
    }

    [self.propertyTextField resignFirstResponder];
    [self.navigationController popViewControllerAnimated: YES];
}

-(void)populatePropertyField
{
    switch (self.effectProperty)
    {
        case DURATION:
            if (self.effectType == TRANSITION)
            {
                self.propertyTextField.placeholder = @"Enter transition duration in seconds";
            }
            else
            {
                self.propertyTextField.placeholder = @"Enter pulse duration in seconds";
            }
            break;
        case PERIOD:
            self.propertyTextField.placeholder = @"Enter pulse period in seconds";
            break;
        case NUM_PULSES:
        {
            self.propertyTextField.placeholder = @"Enter number of pulses";
            self.propertyTextField.keyboardType = UIKeyboardTypeNumberPad;
            break;
        }
        default:
            NSLog(@"EffectProperty is not of a numeric type");
            break;
    }
}

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
        case DURATION:
            if (self.effectType == TRANSITION)
            {
                field = @"transition duration";
            }
            else
            {
                field = @"pulse duration";
            }
            break;
        case PERIOD:
            field = @"pulse period";
            break;
        case NUM_PULSES:
            field = @"number of pulses";
        default:
            NSLog(@"EffectProperty is not of a numeric type");
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
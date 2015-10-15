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

#import "LSFEffectV2PropertiesTableViewController.h"

@interface LSFPulseEffectV2TableViewController : LSFEffectV2PropertiesTableViewController

@property (weak, nonatomic) IBOutlet UIButton *presetButton;
@property (weak, nonatomic) IBOutlet UISwitch *startPropertiesSwitch;

@property (weak, nonatomic) IBOutlet UIButton *endPresetButton;
@property (weak, nonatomic) IBOutlet UIImageView *endColorIndicatorImage;

@property (weak, nonatomic) IBOutlet UISlider *endBrightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *endHueSlider;
@property (weak, nonatomic) IBOutlet UISlider *endSaturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *endColorTempSlider;

@property (weak, nonatomic) IBOutlet UIButton *endBrightnessSliderButton;
@property (weak, nonatomic) IBOutlet UIButton *endHueSliderButton;
@property (weak, nonatomic) IBOutlet UIButton *endSaturationSliderButton;
@property (weak, nonatomic) IBOutlet UIButton *endColorTempSliderButton;

@property (weak, nonatomic) IBOutlet UILabel *endBrightnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *endHueLabel;
@property (weak, nonatomic) IBOutlet UILabel *endSaturationLabel;
@property (weak, nonatomic) IBOutlet UILabel *endColorTempLabel;

@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;
@property (weak, nonatomic) IBOutlet UILabel *numPulsesLabel;


-(IBAction)startPropertiesSwitchValueChanged: (id)sender;

-(IBAction)endBrightnessSliderValueChanged: (UISlider *)sender;
-(IBAction)endHueSliderValueChanged: (UISlider *)sender;
-(IBAction)endSaturationSliderValueChanged: (UISlider *)sender;
-(IBAction)endColorTempSliderValueChanged: (UISlider *)sender;

@end
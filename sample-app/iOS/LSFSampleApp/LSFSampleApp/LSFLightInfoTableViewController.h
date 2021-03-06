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

#import <UIKit/UIKit.h>

@interface LSFLightInfoTableViewController : UITableViewController

@property (nonatomic, strong) NSString *lampID;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UISwitch *powerSwitch;
@property (nonatomic, weak) IBOutlet UIButton *presetButton;
@property (nonatomic, weak) IBOutlet UISlider *brightnessSlider;
@property (nonatomic, weak) IBOutlet UIButton *brightnessSliderButton;
@property (nonatomic, weak) IBOutlet UILabel *brightnessLabel;
@property (nonatomic, weak) IBOutlet UISlider *hueSlider;
@property (nonatomic, weak) IBOutlet UIButton *hueSliderButton;
@property (nonatomic, weak) IBOutlet UILabel *hueLabel;
@property (nonatomic, weak) IBOutlet UISlider *saturationSlider;
@property (nonatomic, weak) IBOutlet UIButton *saturationSliderButton;
@property (nonatomic, weak) IBOutlet UILabel *saturationLabel;
@property (nonatomic, weak) IBOutlet UISlider *colorTempSlider;
@property (nonatomic, weak) IBOutlet UIButton *colorTempSliderButton;
@property (nonatomic, weak) IBOutlet UILabel *colorTempLabel;
@property (nonatomic, weak) IBOutlet UILabel *lumensLabel;
@property (nonatomic, weak) IBOutlet UILabel *energyUsageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *colorIndicatorImage;

-(IBAction)powerSwitchPressed: (UISwitch *)sender;
-(IBAction)brightnessSliderValueChanged: (UISlider *)sender;
-(IBAction)brightnessSliderTouchedWhileDisabled: (UIButton *)sender;
-(IBAction)brightnessSliderTouchUpInside:(id)sender;
-(IBAction)brightnessSliderTouchUpOutside:(id)sender;
-(IBAction)hueSliderValueChanged: (UISlider *)sender;
-(IBAction)hueSliderTouchedWhileDisabled: (UIButton *)sender;
-(IBAction)hueSliderTouchUpInside:(id)sender;
-(IBAction)hueSliderTouchUpOutside:(id)sender;
-(IBAction)saturationSliderValueChanged: (UISlider *)sender;
-(IBAction)saturationSliderTouchedWhileDisabled: (UIButton *)sender;
-(IBAction)saturationSliderTouchUpInside:(id)sender;
-(IBAction)saturationSliderTouchUpOutside:(id)sender;
-(IBAction)colorTempSliderValueChanged: (UISlider *)sender;
-(IBAction)colorTempSliderTouchedWhileDisabled: (UIButton *)sender;
-(IBAction)colorSliderTouchUpInside:(id)sender;
-(IBAction)colorSliderTouchUpOutside:(id)sender;

@end
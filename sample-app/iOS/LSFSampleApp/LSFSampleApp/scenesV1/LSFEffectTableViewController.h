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
#ifdef LSF_SCENES_V1_MODULE

#import <UIKit/UIKit.h>
#import <LSFSDKPreset.h>
#import <LSFSDKColor.h>
#import <LSFSDKPower.h>
#import <model/LSFSceneDataModel.h>

@interface LSFEffectTableViewController : UITableViewController

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
@property (weak, nonatomic) IBOutlet UIImageView *colorIndicatorImage;

-(IBAction)brightnessSliderValueChanged: (UISlider *)sender;
-(IBAction)brightnessSliderTouchUpInside:(UISlider *)sender;
-(IBAction)brightnessSliderTouchUpOutside:(UISlider *)sender;
-(IBAction)brightnessSliderTouchedWhileDisabled: (UIButton *)sender;
-(IBAction)hueSliderValueChanged: (UISlider *)sender;
-(IBAction)hueSliderTouchUpInside:(UISlider *)sender;
-(IBAction)hueSliderTouchUpOutside:(UISlider *)sender;
-(IBAction)hueSliderTouchedWhileDisabled: (UIButton *)sender;
-(IBAction)saturationSliderValueChanged: (UISlider *)sender;
-(IBAction)saturationSliderTouchUpInside:(UISlider *)sender;
-(IBAction)saturationSliderTouchUpOutside:(UISlider *)sender;
-(IBAction)saturationSliderTouchedWhileDisabled: (UIButton *)sender;
-(IBAction)colorTempSliderValueChanged: (UISlider *)sender;
-(IBAction)colorTempSliderTouchUpInside:(UISlider *)sender;
-(IBAction)colorTempSliderTouchUpOutside:(UISlider *)sender;
-(IBAction)colorTempSliderTouchedWhileDisabled: (UIButton *)sender;
-(void)updatePresetButtonTitle: (UIButton*)presetButton;
-(void)updateColorIndicator;
-(BOOL)checkIfPreset: (LSFSDKPreset *)preset matchesPower: (Power)power andColor: (LSFSDKColor *) color;
-(NSString *)buildSectionTitleString: (LSFSceneElementDataModel *)sceneElement;

@end

#endif
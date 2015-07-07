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

#import <UIKit/UIKit.h>
#import "LSFPendingEffect.h"

@interface LSFEffectV2PropertiesTableViewController : UITableViewController

@property (nonatomic, strong) LSFPendingEffect *pendingEffect;

@property (weak, nonatomic) IBOutlet UIImageView *colorIndicatorImage;

@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;
@property (weak, nonatomic) IBOutlet UISlider *hueSlider;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *colorTempSlider;

@property (weak, nonatomic) IBOutlet UIButton *brightnessSliderButton;
@property (weak, nonatomic) IBOutlet UIButton *hueSliderButton;
@property (weak, nonatomic) IBOutlet UIButton *saturationSliderButton;
@property (weak, nonatomic) IBOutlet UIButton *colorTempSliderButton;

@property (weak, nonatomic) IBOutlet UILabel *brightnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *hueLabel;
@property (weak, nonatomic) IBOutlet UILabel *saturationLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorTempLabel;

-(void)updateColorIndicator;
-(void)updatePresetButtonTitle: (UIButton*)presetButton;
-(void)updateSlider: (UISlider *)slider withValue: (int)value;
-(void)checkSaturationValue;

-(void)onSliderTapped: (UIGestureRecognizer *)gr;
-(IBAction)onSliderTouchUpInside: (UISlider *)slider;

-(IBAction)brightnessSliderValueChanged: (UISlider *)sender;
-(IBAction)brightnessSliderTouchDisabled: (UIButton *)sender;

-(IBAction)hueSliderValueChanged: (UISlider *)sender;
-(IBAction)hueSliderTouchDisabled: (UIButton *)sender;

-(IBAction)saturationSliderValueChanged: (UISlider *)sender;
-(IBAction)saturationSliderTouchDisabled: (UIButton *)sender;

-(IBAction)colorTempSliderValueChanged: (UISlider *)sender;
-(IBAction)colorTempSliderTouchDisabled: (UIButton *)sender;

-(IBAction)doneButtonPressed:(id)sender;

enum EffectV2Type {
    PRESET,
    TRANSITION,
    PULSE
};

enum EffectV2Property {
    STATE,
    DURATION,
    PERIOD,
    NUM_PULSES
};

@end

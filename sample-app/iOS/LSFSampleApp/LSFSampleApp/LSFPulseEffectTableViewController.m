/******************************************************************************
 * Copyright (c) 2014, AllSeen Alliance. All rights reserved.
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

#import "LSFPulseEffectTableViewController.h"
#import "LSFSceneElementEffectPropertiesViewController.h"
#import "LSFPulseEffectDataModel.h"
#import "LSFConstants.h"
#import "LSFAllJoynManager.h"
#import "LSFUtilityFunctions.h"
#import "LSFScenesPresetsTableViewController.h"
#import "LSFConstants.h"
#import "LSFPresetModelContainer.h"
#import "LSFPresetModel.h"
#import "LSFEnums.h"

@interface LSFPulseEffectTableViewController ()

-(void)controllerNotificationReceived: (NSNotification *)notification;
-(void)sceneNotificationReceived: (NSNotification *)notification;
-(void)deleteScenesWithIDs: (NSArray *)sceneIDs andNames: (NSArray *)sceneNames;
-(void)presetNotificationReceived: (NSNotification *)notification;
-(void)endBrightnessSliderTapped: (UIGestureRecognizer *)gr;
-(void)endHueSliderTapped: (UIGestureRecognizer *)gr;
-(void)endSaturationSliderTapped: (UIGestureRecognizer *)gr;
-(void)endColorTempSliderTapped: (UIGestureRecognizer *)gr;
-(void)showWarning;
-(LSFLampState *)getCurrentScaledLampState;

@end

@implementation LSFPulseEffectTableViewController

@synthesize startPropertiesSwitch = _startPropertiesSwitch;
@synthesize endPresetButton = _endPresetButton;
@synthesize endBrightnessSlider = _endBrightnessSlider;
@synthesize endBrightnessButton = _endBrightnessButton;
@synthesize endBrightnessLabel = _endBrightnessLabel;
@synthesize endHueSlider = _endHueSlider;
@synthesize endHueButton = _endHueButton;
@synthesize endHueLabel = _endHueLabel;
@synthesize endSaturationSlider = _endSaturationSlider;
@synthesize endSaturationButton = _endSaturationButton;
@synthesize endSaturationLabel = _endSaturationLabel;
@synthesize endColorTempSlider = _endColorTempSlider;
@synthesize endColorTempButton = _endColorTempButton;
@synthesize endColorTempLabel = _endColorTempLabel;
@synthesize durationLabel = _durationLabel;
@synthesize periodLabel = _periodLabel;
@synthesize numPulsesLabel = _numPulsesLabel;
@synthesize sceneModel = _sceneModel;
@synthesize pedm = _pedm;
@synthesize shouldUpdateSceneAndDismiss = _shouldUpdateSceneAndDismiss;


-(void)viewDidLoad
{
    [super viewDidLoad];

    UITapGestureRecognizer *endBrightnessTGR = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(endBrightnessSliderTapped:)];
    [self.endBrightnessSlider addGestureRecognizer: endBrightnessTGR];
    [self.endBrightnessSlider setThumbImage: [UIImage imageNamed: @"power_slider_normal_icon.png"] forState: UIControlStateNormal];
    [self.endBrightnessSlider setThumbImage: [UIImage imageNamed: @"power_slider_pressed_icon.png"] forState: UIControlStateHighlighted];

    UITapGestureRecognizer *endHueTGR = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(endHueSliderTapped:)];
    [self.endHueSlider addGestureRecognizer: endHueTGR];
    [self.endHueSlider setThumbImage: [UIImage imageNamed: @"power_slider_normal_icon.png"] forState: UIControlStateNormal];
    [self.endHueSlider setThumbImage: [UIImage imageNamed: @"power_slider_pressed_icon.png"] forState: UIControlStateHighlighted];

    UITapGestureRecognizer *endSaturationTGR = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(endSaturationSliderTapped:)];
    [self.endSaturationSlider addGestureRecognizer: endSaturationTGR];
    [self.endSaturationSlider setThumbImage: [UIImage imageNamed: @"power_slider_normal_icon.png"] forState: UIControlStateNormal];
    [self.endSaturationSlider setThumbImage: [UIImage imageNamed: @"power_slider_pressed_icon.png"] forState: UIControlStateHighlighted];

    UITapGestureRecognizer *endColorTempTGR = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(endColorTempSliderTapped:)];
    [self.endColorTempSlider addGestureRecognizer: endColorTempTGR];
    [self.endColorTempSlider setThumbImage: [UIImage imageNamed: @"power_slider_normal_icon.png"] forState: UIControlStateNormal];
    [self.endColorTempSlider setThumbImage: [UIImage imageNamed: @"power_slider_pressed_icon.png"] forState: UIControlStateHighlighted];

    self.endColorIndicatorImage.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.endColorIndicatorImage.layer.shouldRasterize = YES;
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];

    //Set notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(controllerNotificationReceived:) name: @"ControllerNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneNotificationReceived:) name: @"SceneNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(presetNotificationReceived:) name: @"PresetNotification" object: nil];

    NSLog(@"LSFPulseEffectTableViewController - viewWillAppear() executing");
    NSLog(@"Power = %@", self.pedm.state.onOff ? @"On" : @"Off");
    NSLog(@"Brightness = %u", self.pedm.state.brightness);
    NSLog(@"Hue = %u", self.pedm.state.hue);
    NSLog(@"Saturation = %u", self.pedm.state.saturation);
    NSLog(@"Color Temp = %u", self.pedm.state.colorTemp);
    NSLog(@"End Power = %@", self.pedm.endState.onOff ? @"On" : @"Off");
    NSLog(@"End Brightness = %u", self.pedm.endState.brightness);
    NSLog(@"End Hue = %u", self.pedm.endState.hue);
    NSLog(@"End Saturation = %u", self.pedm.endState.saturation);
    NSLog(@"End Color Temp = %u", self.pedm.endState.colorTemp);
    NSLog(@"Capability = [%@, %@, %@]", self.pedm.capability.dimmable ? @"Dimmable" : @"Not Dimmable", self.pedm.capability.color ? @"Color" : @"No Color", self.pedm.capability.temp ? @"Variable Color Temp" : @"No Variable Color Temp");
    NSLog(@"Color Temp Min = %u", self.pedm.colorTempMin);
    NSLog(@"Color Temp Max = %u", self.pedm.colorTempMax);

    LSFConstants *constants = [LSFConstants getConstants];

    if (self.pedm != nil)
    {

        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
        [fmt setPositiveFormat: @"0.########"];

        self.durationLabel.text = [NSString stringWithFormat: @"%@ seconds", [fmt stringFromNumber: [NSNumber numberWithDouble: ((double)self.pedm.duration / 1000.0)]]];
        self.periodLabel.text = [NSString stringWithFormat: @"%@ seconds", [fmt stringFromNumber: [NSNumber numberWithDouble: ((double)self.pedm.period / 1000.0)]]];
        self.numPulsesLabel.text = [NSString stringWithFormat: @"%u", self.pedm.numPulses];

        if (self.pedm.state.isNull)
        {
            self.startPropertiesSwitch.on = YES;

            self.brightnessSlider.enabled = NO;
            self.hueSlider.enabled = NO;
            self.saturationSlider.enabled = NO;
            self.colorTempSlider.enabled = NO;

            self.brightnessLabel.text = @"N/A";
            self.hueLabel.text = @"N/A";
            self.saturationLabel.text = @"N/A";
            self.colorTempLabel.text = @"N/A";

            self.brightnessSliderButton.enabled = YES;
            self.hueSliderButton.enabled = YES;
            self.saturationSliderButton.enabled = YES;
            self.colorTempSliderButton.enabled = YES;
        }
        else
        {
            if (self.pedm.capability.dimmable >= SOME)
            {
                unsigned int brightness = [constants unscaleLampStateValue: self.pedm.state.brightness withMax: 100];
                self.brightnessSlider.value = brightness;
                self.brightnessSlider.enabled = YES;
                self.brightnessLabel.text = [NSString stringWithFormat: @"%u%%", brightness];
                self.brightnessSliderButton.enabled = NO;
            }
            else
            {
                self.brightnessSlider.value = 0;
                self.brightnessSlider.enabled = NO;
                self.brightnessLabel.text = @"N/A";
                self.brightnessSliderButton.enabled = YES;
            }

            if (self.pedm.capability.color >= SOME)
            {
                unsigned int hue = [constants unscaleLampStateValue: self.pedm.state.hue withMax: 360];
                self.hueSlider.value = hue;

                if (self.pedm.state.saturation == 0)
                {
                    self.hueSlider.enabled = NO;
                    self.hueLabel.text = @"N/A";
                    self.hueSliderButton.enabled = YES;
                }
                else
                {
                    self.hueSlider.enabled = YES;
                    self.hueLabel.text = [NSString stringWithFormat: @"%u°", hue];
                    self.hueSliderButton.enabled = NO;
                }

                unsigned int saturation = [constants unscaleLampStateValue: self.pedm.state.saturation withMax: 100];
                self.saturationSlider.value = saturation;
                self.saturationSlider.enabled = YES;
                self.saturationLabel.text = [NSString stringWithFormat: @"%u%%", saturation];
                self.saturationSliderButton.enabled = NO;
            }
            else
            {
                self.hueSlider.value = 0;
                self.hueSlider.enabled = NO;
                self.hueLabel.text = @"N/A";
                self.hueSliderButton.enabled = YES;

                self.saturationSlider.value = 0;
                self.saturationSlider.enabled = NO;
                self.saturationLabel.text = @"N/A";
                self.saturationSliderButton.enabled = YES;
            }

            if (self.pedm.capability.temp >= SOME)
            {
                if (self.pedm.state.saturation == 100)
                {
                    self.colorTempSlider.value = [constants unscaleColorTemp: self.pedm.state.colorTemp];
                    self.colorTempSlider.enabled = NO;
                    self.colorTempLabel.text = @"N/A";
                    self.colorTempSliderButton.enabled = YES;
                }
                else
                {
                    self.colorTempSlider.value = [constants unscaleColorTemp: self.pedm.state.colorTemp];
                    self.colorTempSlider.enabled = YES;
                    self.colorTempLabel.text = [NSString stringWithFormat: @"%iK", [constants unscaleColorTemp: self.pedm.state.colorTemp]];
                    self.colorTempSliderButton.enabled = NO;
                }

                self.colorTempSlider.minimumValue = self.pedm.colorTempMin;
                self.colorTempSlider.maximumValue = self.pedm.colorTempMax;
            }
            else
            {
                unsigned int colorTemp = self.pedm.colorTempMin;
                self.colorTempSlider.value = colorTemp;
                self.colorTempSlider.enabled = NO;
                self.colorTempLabel.text = @"N/A";
                self.colorTempSlider.minimumValue = self.pedm.colorTempMin;
                self.colorTempSlider.maximumValue = self.pedm.colorTempMax;
                //NSLog(@"Color Temp Slider - Min = %i; Max = %i", (int)self.colorTempSlider.minimumValue, (int)self.colorTempSlider.maximumValue);
                self.colorTempSliderButton.enabled = YES;
            }
            
            [self checkSaturationValueForStartState];
        }

        if (self.pedm.capability.dimmable >= SOME)
        {
            unsigned int endBrightness = [constants unscaleLampStateValue: self.pedm.endState.brightness withMax: 100];
            self.endBrightnessSlider.value = endBrightness;
            self.endBrightnessSlider.enabled = YES;
            self.endBrightnessLabel.text = [NSString stringWithFormat: @"%u%%", endBrightness];
            self.endBrightnessButton.enabled = NO;
        }
        else
        {
            self.endBrightnessSlider.value = 0;
            self.endBrightnessSlider.enabled = NO;
            self.endBrightnessLabel.text = @"N/A";
            self.endBrightnessButton.enabled = YES;
        }

        if (self.pedm.capability.color >= SOME)
        {
            unsigned int endHue = [constants unscaleLampStateValue: self.pedm.endState.hue withMax: 360];
            self.endHueSlider.value = endHue;

            if (self.pedm.endState.saturation == 0)
            {
                self.endHueSlider.enabled = NO;
                self.endHueLabel.text = @"N/A";
                self.endHueButton.enabled = YES;
            }
            else
            {
                self.endHueSlider.enabled = YES;
                self.endHueLabel.text = [NSString stringWithFormat: @"%u°", endHue];
                self.endHueButton.enabled = NO;
            }

            unsigned int endSaturation = [constants unscaleLampStateValue: self.pedm.endState.saturation withMax: 100];
            self.endSaturationSlider.value = endSaturation;
            self.endSaturationSlider.enabled = YES;
            self.endSaturationLabel.text = [NSString stringWithFormat: @"%u%%", endSaturation];
            self.endSaturationButton.enabled = NO;
        }
        else
        {
            self.endHueSlider.value = 0;
            self.endHueSlider.enabled = NO;
            self.endHueLabel.text = @"N/A";
            self.endHueButton.enabled = YES;

            self.endSaturationSlider.value = 0;
            self.endSaturationSlider.enabled = NO;
            self.endSaturationLabel.text = @"N/A";
            self.endSaturationButton.enabled = YES;
        }

        if (self.pedm.capability.temp >= SOME)
        {
            if (self.pedm.endState.saturation == 100)
            {
                self.endColorTempSlider.value = [constants unscaleColorTemp: self.pedm.endState.colorTemp];
                self.endColorTempSlider.enabled = NO;
                self.endColorTempLabel.text = @"N/A";
                self.endColorTempButton.enabled = YES;
            }
            else
            {
                self.endColorTempSlider.value = [constants unscaleColorTemp: self.pedm.endState.colorTemp];
                self.endColorTempSlider.enabled = YES;
                self.endColorTempLabel.text = [NSString stringWithFormat: @"%iK", [constants unscaleColorTemp: self.pedm.endState.colorTemp]];
                self.endColorTempButton.enabled = NO;
            }

            self.endColorTempSlider.minimumValue = self.pedm.colorTempMin;
            self.endColorTempSlider.maximumValue = self.pedm.colorTempMax;
        }
        else
        {
            unsigned int colorTemp = self.pedm.colorTempMin;
            self.endColorTempSlider.value = colorTemp;
            self.endColorTempSlider.enabled = NO;
            self.endColorTempLabel.text = @"N/A";
            self.endColorTempSlider.minimumValue = self.pedm.colorTempMin;
            self.endColorTempSlider.maximumValue = self.pedm.colorTempMax;
            //NSLog(@"Color Temp Slider - Min = %i; Max = %i", (int)self.colorTempSlider.minimumValue, (int)self.colorTempSlider.maximumValue);
            self.endColorTempButton.enabled = YES;
        }

        [self checkSaturationValueForEndState];
    }

    unsigned int brightness = [constants unscaleLampStateValue: self.pedm.state.brightness withMax: 100];
    unsigned int hue = [constants unscaleLampStateValue: self.pedm.state.hue withMax: 360];
    unsigned int saturation = [constants unscaleLampStateValue: self.pedm.state.saturation withMax: 100];
    unsigned int colorTemp = [constants unscaleColorTemp: self.pedm.state.colorTemp];

    LSFLampState *lStartState = [[LSFLampState alloc] initWithOnOff: self.pedm.state.onOff brightness: brightness hue: hue saturation: saturation colorTemp:colorTemp];

    [LSFUtilityFunctions colorIndicatorSetup: self.colorIndicatorImage withDataState: lStartState andCapabilityData: self.pedm.capability];

    brightness = [constants unscaleLampStateValue: self.pedm.endState.brightness withMax: 100];
    hue = [constants unscaleLampStateValue: self.pedm.endState.hue withMax: 360];
    saturation = [constants unscaleLampStateValue: self.pedm.endState.saturation withMax: 100];
    colorTemp = [constants unscaleColorTemp: self.pedm.endState.colorTemp];

    LSFLampState *lEndState = [[LSFLampState alloc] initWithOnOff: YES brightness: brightness hue: hue saturation: saturation colorTemp: colorTemp];
    [LSFUtilityFunctions colorIndicatorSetup: self.endColorIndicatorImage withDataState: lEndState andCapabilityData: self.pedm.capability];

    [self presetButtonSetup: self.presetButton state: self.pedm.state];
    [self presetButtonSetup: self.endPresetButton state: self.pedm.endState];
}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];

    //Clear groups notification handler
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * ControllerNotification Handler
 */
-(void)controllerNotificationReceived: (NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSNumber *controllerStatus = [userInfo valueForKey: @"status"];

    if (controllerStatus.intValue == Disconnected)
    {
        [self dismissViewControllerAnimated: NO completion: nil];
    }
}

/*
 * SceneNotification Handler
 */
-(void)sceneNotificationReceived: (NSNotification *)notification
{
    NSNumber *callbackOp = [notification.userInfo valueForKey: @"operation"];
    NSArray *sceneIDs = [notification.userInfo valueForKey: @"sceneIDs"];
    NSArray *sceneNames = [notification.userInfo valueForKey: @"sceneNames"];

    if ([sceneIDs containsObject: self.sceneModel.theID])
    {
        switch (callbackOp.intValue)
        {
            case SceneDeleted:
                [self deleteScenesWithIDs: sceneIDs andNames: sceneNames];
                break;
            default:
                break;
        }
    }
}

-(void)deleteScenesWithIDs: (NSArray *)sceneIDs andNames: (NSArray *)sceneNames
{
    if ([sceneIDs containsObject: self.sceneModel.theID])
    {
        int index = [sceneIDs indexOfObject: self.sceneModel.theID];

        [self dismissViewControllerAnimated: NO completion: nil];

        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Scene Not Found"
                                                            message: [NSString stringWithFormat: @"The scene \"%@\" no longer exists.", [sceneNames objectAtIndex: index]]
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        });
    }
}

/*
 * PresetNotification Handler
 */
-(void)presetNotificationReceived: (NSNotification *)notification
{
    [self updatePresetButtonTitle: self.presetButton];
    [self presetButtonSetup: self.endPresetButton state: [self getCurrentScaledLampState]];
}

/*
 * Table View Data Source Methods
 */
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [NSString stringWithFormat: @"Select the start and end properties that %@ will cycle through", [LSFUtilityFunctions buildSectionTitleString: self.pedm]];
    }

    return @"";
}

/*
 * Various event handlers
 */
-(IBAction)endBrightnessSliderValueChanged: (UISlider *)sender
{
    NSString *endBrightnessText = [NSString stringWithFormat: @"%i%%", (uint32_t)sender.value];
    self.endBrightnessLabel.text = endBrightnessText;
}

-(IBAction)endBrightnessSliderTouchUpInside: (UISlider *)sender
{
    [self presetButtonSetup: self.endPresetButton state: [self getCurrentScaledLampState]];
    [self updateEndColorIndicator];
}

-(IBAction)endBrightnessSliderTouchUpOutside: (UISlider *)sender
{
    [self presetButtonSetup: self.endPresetButton state: [self getCurrentScaledLampState]];
    [self updateEndColorIndicator];
}

-(IBAction)endHueSliderValueChanged: (UISlider *)sender
{
    NSString *endHueText = [NSString stringWithFormat: @"%i°", (uint32_t)sender.value];
    self.endHueLabel.text = endHueText;
}

-(IBAction)endHueSliderTouchUpInside: (UISlider *)sender
{
    [self presetButtonSetup: self.endPresetButton state: [self getCurrentScaledLampState]];
    [self updateEndColorIndicator];
}

-(IBAction)endHueSliderTouchUpOutside: (UISlider *)sender
{
    [self presetButtonSetup: self.endPresetButton state: [self getCurrentScaledLampState]];
    [self updateEndColorIndicator];
}

-(IBAction)endSaturationSliderValueChanged: (UISlider *)sender
{
    NSString *endSaturationText = [NSString stringWithFormat: @"%i%%", (uint32_t)sender.value];
    self.endSaturationLabel.text = endSaturationText;
    [self checkSaturationValueForEndState];
}

-(IBAction)endSaturationSliderTouchUpInside: (UISlider *)sender
{
    [self presetButtonSetup: self.endPresetButton state: [self getCurrentScaledLampState]];
    [self updateEndColorIndicator];
    [self checkSaturationValueForEndState];
}

-(IBAction)endSaturationSliderTouchUpOutside: (UISlider *)sender
{
    [self presetButtonSetup: self.endPresetButton state: [self getCurrentScaledLampState]];
    [self updateEndColorIndicator];
    [self checkSaturationValueForEndState];
}

-(IBAction)endColorTempSliderValueChanged: (UISlider *)sender
{
    NSString *endColorTempText = [NSString stringWithFormat: @"%iK", (uint32_t)sender.value];
    self.endColorTempLabel.text = endColorTempText;
}

-(IBAction)endColorTempSliderTouchUpInside: (UISlider *)sender
{
    [self presetButtonSetup: self.endPresetButton state: [self getCurrentScaledLampState]];
    [self updateEndColorIndicator];
}

-(IBAction)endColorTempSliderTouchUpOutside: (UISlider *)sender
{
    [self presetButtonSetup: self.endPresetButton state: [self getCurrentScaledLampState]];
    [self updateEndColorIndicator];
}

-(IBAction)startPropertiesSwitchValueChanged: (UISwitch *)sender
{
    if (sender.on)
    {
        self.brightnessSlider.enabled = NO;
        self.hueSlider.enabled = NO;
        self.saturationSlider.enabled = NO;
        self.colorTempSlider.enabled = NO;

        self.brightnessLabel.text = @"N/A";
        self.hueLabel.text = @"N/A";
        self.saturationLabel.text = @"N/A";
        self.colorTempLabel.text = @"N/A";

        self.brightnessSliderButton.enabled = YES;
        self.hueSliderButton.enabled = YES;
        self.saturationSliderButton.enabled = YES;
        self.colorTempSliderButton.enabled = YES;
    }
    else
    {
        if (self.pedm.capability.dimmable >= SOME)
        {
            self.brightnessSlider.enabled = YES;
            self.brightnessLabel.text = [NSString stringWithFormat: @"%i%%", (uint32_t)self.brightnessSlider.value];
            self.brightnessSliderButton.enabled = NO;
        }
        else
        {
            self.brightnessSlider.enabled = NO;
            self.brightnessLabel.text = @"N/A";
            self.brightnessSliderButton.enabled = YES;
        }

        if (self.pedm.capability.color >= SOME)
        {
            self.hueSlider.enabled = YES;
            self.hueLabel.text = [NSString stringWithFormat: @"%i°", (uint32_t)self.hueSlider.value];
            self.hueSliderButton.enabled = NO;

            self.saturationSlider.enabled = YES;
            self.saturationLabel.text = [NSString stringWithFormat: @"%i%%", (uint32_t)self.saturationSlider.value];
            self.saturationSliderButton.enabled = NO;
        }
        else
        {
            self.hueSlider.enabled = NO;
            self.hueLabel.text = @"N/A";
            self.hueSliderButton.enabled = YES;

            self.saturationSlider.enabled = NO;
            self.saturationLabel.text = @"N/A";
            self.saturationSliderButton.enabled = YES;
        }

        if (self.pedm.capability.temp >= SOME)
        {
            self.colorTempSlider.enabled = YES;
            self.colorTempLabel.text = [NSString stringWithFormat: @"%iK", (uint32_t)self.colorTempSlider.value];
            self.colorTempSliderButton.enabled = NO;
        }
        else
        {
            self.colorTempSlider.enabled = NO;
            self.colorTempLabel.text = @"N/A";
            self.colorTempSliderButton.enabled = YES;
        }

        [self checkSaturationValueForStartState];
    }
}

-(IBAction)startBrightnessSliderTouchedWhileDisabled: (UIButton *)sender
{
    if (self.startPropertiesSwitch.on)
    {
        [self showWarning];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"This Lamp is not able to change its brightness." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(IBAction)startHueSliderTouchedWhileDisabled: (UIButton *)sender
{
    if (self.startPropertiesSwitch.on)
    {
        [self showWarning];
    }
    else
    {
        if (self.pedm.capability.color == NONE)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"This Lamp is not able to change its hue." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            [self showHueAlert];
        }
    }
}

-(IBAction)startSaturationSliderTouchedWhileDisabled: (UIButton *)sender
{
    if (self.startPropertiesSwitch.on)
    {
        [self showWarning];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"This Lamp is not able to change its saturation." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [alert show];
    }
}

-(IBAction)startColorTempSliderTouchedWhileDisabled: (UIButton *)sender
{
    if (self.startPropertiesSwitch.on)
    {
        [self showWarning];
    }
    else
    {
        if (self.pedm.capability.color == NONE)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"This Lamp is not able to change its color temp." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            [self showColorTempAlert];
        }
    }
}

-(IBAction)endBrightnessSliderTouchedWhileDisabled: (UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"This Lamp is not able to change its brightness." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [alert show];
}

-(IBAction)endHueSliderTouchedWhileDisabled: (UIButton *)sender
{
    if (self.pedm.capability.color == NONE)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"This Lamp is not able to change its hue." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [self showHueAlert];
    }
}

-(IBAction)endSaturationSliderTouchedWhileDisabled: (UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"This Lamp is not able to change its saturation." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
    [alert show];
}

-(IBAction)endColorTempSliderTouchedWhileDisabled: (UIButton *)sender
{
    if (self.pedm.capability.color == NONE)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"This Lamp is not able to change its color temp." delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [self showColorTempAlert];
    }
}

-(IBAction)doneButtonPressed: (id)sender
{
    LSFConstants *constants = [LSFConstants getConstants];

    //Get Lamp State
    if (!self.startPropertiesSwitch.on)
    {
        unsigned int scaledBrightness = [constants scaleLampStateValue: (uint32_t)self.brightnessSlider.value withMax: 100];
        unsigned int scaledHue = [constants scaleLampStateValue: (uint32_t)self.hueSlider.value withMax: 360];
        unsigned int scaledSaturation = [constants scaleLampStateValue: (uint32_t)self.saturationSlider.value withMax: 100];
        unsigned int scaledColorTemp = [constants scaleColorTemp: (uint32_t)self.colorTempSlider.value];

        if (self.pedm.capability.dimmable == NONE && self.pedm.capability.color == NONE && self.pedm.capability.temp == NONE)
        {
            self.pedm.state.onOff = YES;
            self.pedm.state.brightness = [constants scaleLampStateValue: 100 withMax: 100];
        }
        else
        {
//            if (scaledBrightness == 0)
//            {
//                self.pedm.state.onOff = NO;
//            }
//            else
//            {
//                self.pedm.state.onOff = YES;
//            }

            self.pedm.state.onOff = YES;
            self.pedm.state.brightness = scaledBrightness;
        }

        self.pedm.state.hue = scaledHue;
        self.pedm.state.saturation = scaledSaturation;
        self.pedm.state.colorTemp = scaledColorTemp;
        self.pedm.state.isNull = NO;
    }
    else
    {
        self.pedm.state = [[LSFLampState alloc] init];
    }

    unsigned int scaledEndBrightness = [constants scaleLampStateValue: (uint32_t)self.endBrightnessSlider.value withMax: 100];
    unsigned int scaledEndHue = [constants scaleLampStateValue: (uint32_t)self.endHueSlider.value withMax: 360];
    unsigned int scaledEndSaturation = [constants scaleLampStateValue: (uint32_t)self.endSaturationSlider.value withMax: 100];
    unsigned int scaledEndColorTemp = [constants scaleColorTemp: (uint32_t)self.endColorTempSlider.value];

    if (self.pedm.capability.dimmable == NONE && self.pedm.capability.color == NONE && self.pedm.capability.temp == NONE)
    {
        self.pedm.endState.onOff = YES;
        self.pedm.endState.brightness = [constants scaleLampStateValue: 100 withMax: 100];
    }
    else
    {
//        if (scaledEndBrightness == 0)
//        {
//            self.pedm.state.onOff = NO;
//        }
//        else
//        {
//            self.pedm.state.onOff = YES;
//        }

        self.pedm.endState.onOff = YES;
        self.pedm.endState.brightness = scaledEndBrightness;
    }

    self.pedm.endState.hue = scaledEndHue;
    self.pedm.endState.saturation = scaledEndSaturation;
    self.pedm.endState.colorTemp = scaledEndColorTemp;

    [self.sceneModel updatePulseEffect: self.pedm];

    if (self.shouldUpdateSceneAndDismiss)
    {
        LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
        [ajManager.lsfSceneManager updateSceneWithID: self.sceneModel.theID withScene: [self.sceneModel toScene]];
    }
    
    [self dismissViewControllerAnimated: YES completion: nil];
}

/*
 * Override public function from LSFEffectTableViewController
 */
-(void)updateColorIndicator
{
    LSFLampState *lstate = [[LSFLampState alloc] initWithOnOff:YES brightness: self.brightnessSlider.value hue: self.hueSlider.value saturation: self.saturationSlider.value colorTemp: self.colorTempSlider.value];
    [LSFUtilityFunctions colorIndicatorSetup: self.colorIndicatorImage withDataState: lstate andCapabilityData: self.pedm.capability];
}

/*
 * Private functions
 */
-(void)updateEndColorIndicator
{
    LSFLampState *lstate = [[LSFLampState alloc] initWithOnOff: YES brightness: self.endBrightnessSlider.value hue: self.endHueSlider.value saturation: self.endSaturationSlider.value colorTemp: self.endColorTempSlider.value];
    [LSFUtilityFunctions colorIndicatorSetup: self.endColorIndicatorImage withDataState: lstate andCapabilityData: self.pedm.capability];
}

-(void)endBrightnessSliderTapped: (UIGestureRecognizer *)gr
{
    UISlider *s = (UISlider *)gr.view;

    if (s.highlighted)
    {
        //tap on thumb, let slider deal with it
        return;
    }

    CGPoint pt = [gr locationInView: s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = round(s.minimumValue + delta);

    NSString *endBrightnessText = [NSString stringWithFormat: @"%i%%", (uint32_t)value];
    self.endBrightnessLabel.text = endBrightnessText;
    self.endBrightnessSlider.value = value;

    [self updateEndColorIndicator];

    LSFLampState *currState = [[LSFLampState alloc] initWithOnOff: YES brightness: self.endBrightnessSlider.value hue: self.endHueSlider.value saturation: self.endSaturationSlider.value colorTemp: self.endColorTempSlider.value];
    [self presetButtonSetup: self.endPresetButton state:currState];
}

-(void)endHueSliderTapped: (UIGestureRecognizer *)gr
{
    UISlider *s = (UISlider *)gr.view;

    if (s.highlighted)
    {
        //tap on thumb, let slider deal with it
        return;
    }

    CGPoint pt = [gr locationInView: s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = round(s.minimumValue + delta);

    NSString *endHueText = [NSString stringWithFormat: @"%i°", (uint32_t)value];
    self.endHueLabel.text = endHueText;
    self.endHueSlider.value = value;

    [self updateEndColorIndicator];

    LSFLampState *currState = [[LSFLampState alloc] initWithOnOff: YES brightness: self.endBrightnessSlider.value hue: self.endHueSlider.value saturation: self.endSaturationSlider.value colorTemp: self.endColorTempSlider.value];
    [self presetButtonSetup: self.endPresetButton state:currState];
}

-(void)endSaturationSliderTapped: (UIGestureRecognizer *)gr
{
    UISlider *s = (UISlider *)gr.view;

    if (s.highlighted)
    {
        //tap on thumb, let slider deal with it
        return;
    }

    CGPoint pt = [gr locationInView: s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = round(s.minimumValue + delta);

    NSString *endSaturationText = [NSString stringWithFormat: @"%i%%", (uint32_t)value];
    self.endSaturationLabel.text = endSaturationText;
    self.endSaturationSlider.value = value;

    [self updateEndColorIndicator];

    LSFLampState *currState = [[LSFLampState alloc] initWithOnOff: YES brightness: self.endBrightnessSlider.value hue: self.endHueSlider.value saturation: self.endSaturationSlider.value colorTemp: self.endColorTempSlider.value];
    [self presetButtonSetup: self.endPresetButton state:currState];
    [self checkSaturationValueForEndState];
}

-(void)endColorTempSliderTapped: (UIGestureRecognizer *)gr
{
    UISlider *s = (UISlider *)gr.view;

    if (s.highlighted)
    {
        //tap on thumb, let slider deal with it
        return;
    }

    CGPoint pt = [gr locationInView: s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = round(s.minimumValue + delta);

    NSString *endColorTempText = [NSString stringWithFormat: @"%iK", (uint32_t)value];
    self.endColorTempLabel.text = endColorTempText;
    self.endColorTempSlider.value = value;

    [self updateEndColorIndicator];


    LSFLampState *currState = [[LSFLampState alloc] initWithOnOff: YES brightness: self.endBrightnessSlider.value hue: self.endHueSlider.value saturation: self.endSaturationSlider.value colorTemp: self.endColorTempSlider.value];
    [self presetButtonSetup: self.endPresetButton state:currState];
}

-(void)showWarning
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error"
                                                    message: @"You must switch the start properties switch off if you want to specify a start state."
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

-(void)presetButtonSetup:(UIButton *)presetButton state:(LSFLampState*)state
{
    LSFPresetModelContainer *container = [LSFPresetModelContainer getPresetModelContainer];
    NSArray *presets = [container.presetContainer allValues];

    NSMutableArray *presetsArray = [[NSMutableArray alloc] init];
    BOOL presetMatched = NO;
    for (LSFPresetModel *data in presets)
    {
        BOOL matchesPreset = [self checkIfLampState: state matchesPreset: data];

        if (matchesPreset)
        {
            [presetsArray addObject: data.name];
            presetMatched = YES;
        }
    }

    if (presetMatched)
    {
        NSArray *sortedArray = [presetsArray sortedArrayUsingSelector: @selector(localizedCaseInsensitiveCompare:)];
        NSMutableString *presetsMatched = [[NSMutableString alloc] init];

        for (NSString *presetName in sortedArray)
        {
            [presetsMatched appendString: [NSString stringWithFormat:@"%@, ", presetName]];
        }

        [presetsMatched deleteCharactersInRange: NSMakeRange(presetsMatched.length - 2, 2)];
        [presetButton setTitle: presetsMatched forState: UIControlStateNormal];
    }
    else
    {
        [presetButton setTitle: @"Save New Preset" forState: UIControlStateNormal];
    }
}

-(BOOL)checkIfLampState: (LSFLampState *) state matchesPreset: (LSFPresetModel *)data
{
    BOOL returnValue = NO;

    if ((state.brightness == data.state.brightness) && (state.hue == data.state.hue) && (state.saturation == data.state.saturation) && (state.colorTemp == data.state.colorTemp)) // not checking state.onOff
    {
        returnValue = YES;
    }

    return returnValue;
}

-(LSFLampState *)getCurrentScaledLampState
{
    LSFConstants *constants = [LSFConstants getConstants];

    unsigned int scaledBrightness = [constants scaleLampStateValue: (uint32_t)self.endBrightnessSlider.value withMax: 100];
    unsigned int scaledHue = [constants scaleLampStateValue: (uint32_t)self.endHueSlider.value withMax: 360];
    unsigned int scaledSaturation = [constants scaleLampStateValue: (uint32_t)self.endSaturationSlider.value withMax: 100];
    unsigned int scaledColorTemp = [constants scaleColorTemp: (uint32_t)self.endColorTempSlider.value];

    return [[LSFLampState alloc] initWithOnOff: (scaledBrightness == 0 ? NO : YES) brightness: scaledBrightness hue: scaledHue saturation: scaledSaturation colorTemp: scaledColorTemp];
}

/*
 * Segue Methods
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LSFConstants *constants = [LSFConstants getConstants];

    //Get start Lamp State
    unsigned int startScaledBrightness = [constants scaleLampStateValue: (uint32_t)self.brightnessSlider.value withMax: 100];
    unsigned int startScaledHue = [constants scaleLampStateValue: (uint32_t)self.hueSlider.value withMax: 360];
    unsigned int startScaledSaturation = [constants scaleLampStateValue: (uint32_t)self.saturationSlider.value withMax: 100];
    unsigned int startScaledColorTemp = [constants scaleColorTemp: (uint32_t)self.colorTempSlider.value];

    LSFLampState* startScaledLampState = [[LSFLampState alloc] initWithOnOff: (startScaledBrightness == 0 ? NO : YES) brightness:startScaledBrightness hue:startScaledHue saturation:startScaledSaturation colorTemp:startScaledColorTemp];

    //Get end Lamp State
    unsigned int endScaledBrightness = [constants scaleLampStateValue: (uint32_t)self.endBrightnessSlider.value withMax: 100];
    unsigned int endScaledHue = [constants scaleLampStateValue: (uint32_t)self.endHueSlider.value withMax: 360];
    unsigned int endScaledSaturation = [constants scaleLampStateValue: (uint32_t)self.endSaturationSlider.value withMax: 100];
    unsigned int endScaledColorTemp = [constants scaleColorTemp: (uint32_t)self.endColorTempSlider.value];

    LSFLampState* endScaledLampState = [[LSFLampState alloc] initWithOnOff: (endScaledBrightness == 0 ? NO : YES) brightness:endScaledBrightness hue:endScaledHue saturation:endScaledSaturation colorTemp:endScaledColorTemp];

    if ([segue.destinationViewController isKindOfClass:[LSFSceneElementEffectPropertiesViewController class]])
    {
        LSFSceneElementEffectPropertiesViewController *seepvc = [segue destinationViewController];
        seepvc.pedm = self.pedm;

        if ([segue.identifier isEqualToString: @"PulseDuration"])
        {
            seepvc.effectProperty = PulseDuration;
        }
        else if ([segue.identifier isEqualToString: @"PulsePeriod"])
        {
            seepvc.effectProperty = PulsePeriod;
        }
        else if ([segue.identifier isEqualToString: @"PulseNumPulses"])
        {
            seepvc.effectProperty = PulseNumPulses;
        }

        seepvc.lampState = startScaledLampState;
        seepvc.endLampState = endScaledLampState;
        seepvc.effectSender = self;
        seepvc.sceneID = self.sceneModel.theID;
    }
    else if ([segue.destinationViewController isKindOfClass:[LSFScenesPresetsTableViewController class]])
    {
        LSFScenesPresetsTableViewController *sptvc = [segue destinationViewController];

        if ([segue.identifier isEqualToString: @"ScenePresetsStart"])
        {
            sptvc.lampState = startScaledLampState;
        }
        else if ([segue.identifier isEqualToString: @"ScenePresetsStop"])
        {
            sptvc.lampState = endScaledLampState;
            sptvc.endStateFlag = YES;
        }

        sptvc.effectSender = self;
        sptvc.sceneID = self.sceneModel.theID;
    }
}

-(void)checkSaturationValueForStartState
{
    LSFConstants *constants = [LSFConstants getConstants];

    if (self.pedm.capability.color >= SOME && self.pedm.capability.temp >= SOME)
    {
        if (self.saturationSlider.value == 0)
        {
            self.hueSlider.enabled = NO;
            self.hueLabel.text = @"N/A";
            self.hueSliderButton.enabled = YES;
        }
        else
        {
            self.hueSlider.enabled = YES;
            self.hueSliderButton.enabled = NO;
            unsigned int hue = [constants unscaleLampStateValue: self.pedm.state.hue withMax: 360];
            self.hueLabel.text = [NSString stringWithFormat: @"%i°", hue];
        }

        if (self.saturationSlider.value == 100)
        {
            self.colorTempSlider.enabled = NO;
            self.colorTempLabel.text = @"N/A";
            self.colorTempSliderButton.enabled = YES;
        }
        else
        {
            self.colorTempSlider.enabled = YES;
            self.colorTempSliderButton.enabled = NO;
            unsigned int colorTemp = [constants unscaleColorTemp: self.pedm.state.colorTemp];
            self.colorTempLabel.text = [NSString stringWithFormat: @"%iK", colorTemp];
        }
    }
}

-(void)checkSaturationValueForEndState
{
    LSFConstants *constants = [LSFConstants getConstants];

    if (self.pedm.capability.color >= SOME && self.pedm.capability.temp >= SOME)
    {
        if (self.endSaturationSlider.value == 0)
        {
            self.endHueSlider.enabled = NO;
            self.endHueLabel.text = @"N/A";
            self.endHueButton.enabled = YES;
        }
        else
        {
            self.endHueSlider.enabled = YES;
            self.endHueButton.enabled = NO;
            unsigned int endHue = [constants unscaleLampStateValue: self.pedm.endState.hue withMax: 360];
            self.endHueLabel.text = [NSString stringWithFormat: @"%i°", endHue];
        }

        if (self.endSaturationSlider.value == 100)
        {
            self.endColorTempSlider.enabled = NO;
            self.endColorTempLabel.text = @"N/A";
            self.endColorTempButton.enabled = YES;
        }
        else
        {
            self.endColorTempSlider.enabled = YES;
            self.endColorTempButton.enabled = NO;
            unsigned int endColorTemp = [constants unscaleColorTemp: self.pedm.state.colorTemp];
            self.endColorTempLabel.text = [NSString stringWithFormat: @"%iK", endColorTemp];
        }
    }
}

-(void)showHueAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error"
                                                    message: @"Hue has no effect when saturation is zero. Set saturation to greater than zero to enable the hue slider."
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

-(void)showColorTempAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error"
                                                    message: @"Color temperature has no effect when saturation is 100%. Set saturation to less than 100% to enable the color temperature slider."
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

@end
/******************************************************************************
 *  *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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

#import "LSFTransitionEffectTableViewController.h"
#import "LSFSceneElementEffectPropertiesViewController.h"
#import "LSFTransitionEffectDataModel.h"
#import "LSFConstants.h"
#import "LSFAllJoynManager.h"
#import "LSFUtilityFunctions.h"
#import "LSFScenesPresetsTableViewController.h"
#import "LSFPresetModelContainer.h"
#import "LSFPresetModel.h"
#import "LSFEnums.h"

@interface LSFTransitionEffectTableViewController ()

-(void)controllerNotificationReceived: (NSNotification *)notification;
-(void)sceneNotificationReceived: (NSNotification *)notification;
-(void)deleteScenesWithIDs: (NSArray *)sceneIDs andNames: (NSArray *)sceneNames;

@end

@implementation LSFTransitionEffectTableViewController

@synthesize durationLabel = _durationLabel;
@synthesize colorIndicatorImage = _colorIndicatorImage;
@synthesize tedm = _tedm;
@synthesize sceneModel = _sceneModel;
@synthesize shouldUpdateSceneAndDismiss = _shouldUpdateSceneAndDismiss;

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];

    //Set notification handler
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(controllerNotificationReceived:) name: @"ControllerNotification" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(sceneNotificationReceived:) name: @"SceneNotification" object: nil];

    NSLog(@"LSFTransitionEffectTableViewController - viewWillAppear() executing");
    NSLog(@"Power = %@", self.tedm.state.onOff ? @"On" : @"Off");
    NSLog(@"Brightness = %u", self.tedm.state.brightness);
    NSLog(@"Hue = %u", self.tedm.state.hue);
    NSLog(@"Saturation = %u", self.tedm.state.saturation);
    NSLog(@"Color Temp = %u", self.tedm.state.colorTemp);
    NSLog(@"Capability = [%@, %@, %@]", self.tedm.capability.dimmable ? @"Dimmable" : @"Not Dimmable", self.tedm.capability.color ? @"Color" : @"No Color", self.tedm.capability.temp ? @"Variable Color Temp" : @"No Variable Color Temp");
    NSLog(@"Color Temp Min = %u", self.tedm.colorTempMin);
    NSLog(@"Color Temp Max = %u", self.tedm.colorTempMax);

    LSFConstants *constants = [LSFConstants getConstants];

    if (self.tedm != nil)
    {
        if (self.tedm.capability.dimmable >= SOME)
        {
            unsigned int brightness = [constants unscaleLampStateValue: self.tedm.state.brightness withMax: 100];
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

        if (self.tedm.capability.color >= SOME)
        {
            unsigned int hue = [constants unscaleLampStateValue: self.tedm.state.hue withMax: 360];
            self.hueSlider.value = hue;

            if (self.tedm.state.saturation == 0)
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

            unsigned int saturation = [constants unscaleLampStateValue: self.tedm.state.saturation withMax: 100];
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

        if (self.tedm.capability.temp >= SOME)
        {
            if (self.tedm.state.saturation == 100)
            {
                self.colorTempSlider.value = [constants unscaleColorTemp: self.tedm.state.colorTemp];
                self.colorTempSlider.enabled = NO;
                self.colorTempLabel.text = @"N/A";
                self.colorTempSliderButton.enabled = YES;
            }
            else
            {
                self.colorTempSlider.value = [constants unscaleColorTemp: self.tedm.state.colorTemp];
                self.colorTempSlider.enabled = YES;
                self.colorTempLabel.text = [NSString stringWithFormat: @"%iK", [constants unscaleColorTemp: self.tedm.state.colorTemp]];
                self.colorTempSliderButton.enabled = NO;
            }

            self.colorTempSlider.minimumValue = self.tedm.colorTempMin;
            self.colorTempSlider.maximumValue = self.tedm.colorTempMax;
        }
        else
        {
            unsigned int colorTemp = self.tedm.colorTempMin;
            self.colorTempSlider.value = colorTemp;
            self.colorTempSlider.enabled = NO;
            self.colorTempLabel.text = @"N/A";
            self.colorTempSlider.minimumValue = self.tedm.colorTempMin;
            self.colorTempSlider.maximumValue = self.tedm.colorTempMax;
            //NSLog(@"Color Temp Slider - Min = %i; Max = %i", (int)self.colorTempSlider.minimumValue, (int)self.colorTempSlider.maximumValue);
            self.colorTempSliderButton.enabled = YES;
        }
    }

    NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
    [fmt setPositiveFormat: @"0.########"];
    self.durationLabel.text = [NSString stringWithFormat: @"%@ seconds", [fmt stringFromNumber: [NSNumber numberWithDouble: ((double)self.tedm.duration / 1000.0)]]];

    LSFLampState *lstate = [[LSFLampState alloc] initWithOnOff:YES brightness: self.brightnessSlider.value hue: self.hueSlider.value saturation: self.saturationSlider.value colorTemp: self.colorTempSlider.value];
    [LSFUtilityFunctions colorIndicatorSetup: self.colorIndicatorImage withDataState: lstate andCapabilityData: self.tedm.capability];

    [self presetButtonSetup: self.tedm.state];
}

-(void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear: animated];

    //Clear scenes notification handler
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
 * Table View Data Source Methods
 */
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [NSString stringWithFormat: @"Set the properties that %@ will transition to", [LSFUtilityFunctions buildSectionTitleString: self.tedm]];
    }

    return @"";
}

/*
 * Button event handler
 */
-(IBAction)doneButtonPressed: (id)sender
{
    LSFConstants *constants = [LSFConstants getConstants];

    //Get Lamp State
    unsigned int scaledBrightness = [constants scaleLampStateValue: (uint32_t)self.brightnessSlider.value withMax: 100];
    unsigned int scaledHue = [constants scaleLampStateValue: (uint32_t)self.hueSlider.value withMax: 360];
    unsigned int scaledSaturation = [constants scaleLampStateValue: (uint32_t)self.saturationSlider.value withMax: 100];
    unsigned int scaledColorTemp = [constants scaleColorTemp: (uint32_t)self.colorTempSlider.value];

    if (self.tedm.capability.dimmable == NONE && self.tedm.capability.color == NONE && self.tedm.capability.temp == NONE)
    {
        self.tedm.state.onOff = YES;
        self.tedm.state.brightness = [constants scaleLampStateValue: 100 withMax: 100];
    }
    else
    {
//        if (scaledBrightness == 0)
//        {
//            self.tedm.state.onOff = NO;
//        }
//        else
//        {
//            self.tedm.state.onOff = YES;
//        }

        self.tedm.state.onOff = YES;
        self.tedm.state.brightness = scaledBrightness;
    }

    self.tedm.state.hue = scaledHue;
    self.tedm.state.saturation = scaledSaturation;
    self.tedm.state.colorTemp = scaledColorTemp;

    [self.sceneModel updateTransitionEffect: self.tedm];

    if (self.shouldUpdateSceneAndDismiss)
    {
        LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
        [ajManager.lsfSceneManager updateSceneWithID: self.sceneModel.theID withScene: [self.sceneModel toScene]];
    }

    [self dismissViewControllerAnimated: YES completion: nil];
}

/*
 * Segue Methods
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    LSFConstants *constants = [LSFConstants getConstants];

    //Get Lamp State
    unsigned int scaledBrightness = [constants scaleLampStateValue: (uint32_t)self.brightnessSlider.value withMax: 100];
    unsigned int scaledHue = [constants scaleLampStateValue: (uint32_t)self.hueSlider.value withMax: 360];
    unsigned int scaledSaturation = [constants scaleLampStateValue: (uint32_t)self.saturationSlider.value withMax: 100];
    unsigned int scaledColorTemp = [constants scaleColorTemp: (uint32_t)self.colorTempSlider.value];

    if (scaledBrightness == 0)
    {
        self.tedm.state.onOff = NO;
    }

    LSFLampState* scaledLampState = [[LSFLampState alloc] initWithOnOff: self.tedm.state.onOff brightness:scaledBrightness hue:scaledHue saturation:scaledSaturation colorTemp:scaledColorTemp];

    if ([segue.identifier isEqualToString: @"TransitionDuration"])
    {
        LSFSceneElementEffectPropertiesViewController *seepvc = [segue destinationViewController];
        seepvc.tedm = self.tedm;
        seepvc.effectProperty = TransitionDuration;
        seepvc.lampState = scaledLampState;
        seepvc.effectSender = self;
        seepvc.sceneID = self.sceneModel.theID;
    }
    else if ([segue.identifier isEqualToString: @"ScenePresets"])
    {
        LSFScenesPresetsTableViewController *sptvc = [segue destinationViewController];
        sptvc.lampState = scaledLampState;
        sptvc.effectSender = self;
        sptvc.sceneID = self.sceneModel.theID;
    }
}

-(void)presetButtonSetup: (LSFLampState*)state
{
    LSFPresetModelContainer *container = [LSFPresetModelContainer getPresetModelContainer];
    NSArray *presets = [container.presetContainer allValues];

    BOOL presetMatched = NO;
    for (LSFPresetModel *data in presets)
    {
        BOOL matchesPreset = [self checkIfLampState: state matchesPreset: data];

        if (matchesPreset)
        {
            [self.presetButton setTitle: data.name forState: UIControlStateNormal];
            presetMatched = YES;
        }
    }

    if (!presetMatched)
    {
        [self.presetButton setTitle: @"Save New Preset" forState: UIControlStateNormal];
    }
}

-(BOOL)checkIfLampState: (LSFLampState *) state matchesPreset: (LSFPresetModel *)data
{
    BOOL returnValue = NO;

    if ((state.onOff == data.state.onOff) && (state.brightness == data.state.brightness) && (state.hue == data.state.hue) && (state.saturation == data.state.saturation) && (state.colorTemp == data.state.colorTemp))
    {
        returnValue = YES;
    }

    return returnValue;
}

/*
 * Override public function from LSFEffectTableViewController
 */
-(void)updateColorIndicator
{
    LSFLampState *lstate = [[LSFLampState alloc] initWithOnOff:YES brightness: self.brightnessSlider.value hue: self.hueSlider.value saturation: self.saturationSlider.value colorTemp: self.colorTempSlider.value];
    [LSFUtilityFunctions colorIndicatorSetup: self.colorIndicatorImage withDataState: lstate andCapabilityData: self.tedm.capability];
}

-(IBAction)hueSliderTouchedWhileDisabled: (UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"" delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];

    if (self.tedm.capability.color == NONE)
    {
        alert.message = @"This Lamp is not able to change its hue.";
    }
    else
    {
        alert.message = @"Hue has no effect when saturation is zero. Set saturation to greater than zero to enable the hue slider.";
    }

    [alert show];
}

-(IBAction)colorTempSliderTouchedWhileDisabled: (UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Error" message: @"" delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil];

    if (self.tedm.capability.color == NONE)
    {
        alert.message = @"This Lamp is not able to change its color temp.";
    }
    else
    {
        alert.message = @"Color temperature has no effect when saturation is 100%. Set saturation to less than 100% to enable the color temperature slider.";
    }

    [alert show];
}

@end
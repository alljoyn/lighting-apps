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

#import "LSFHelperPresetManagerCallback.h"
#import "LSFAllJoynManager.h"
#import "LSFPresetModelContainer.h"
#import "LSFDispatchQueue.h"
#import "LSFSDKPreset.h"
#import "LSFConstants.h"

@interface LSFHelperPresetManagerCallback()

@property (nonatomic, strong) dispatch_queue_t queue;

-(void)updateUI;
-(void)updatePresetID: (NSString *)presetID;
-(void)updatePresetName: (NSString *)name forPresetID: (NSString *)presetID;
-(void)updatePresetWithID: (NSString *)presetID andState:(LSFLampState *)preset;
-(void)removePresetWithID: (NSString *)presetID;
-(void)removePresetsWithIDs: (NSArray *)presetIDs;
-(void)updateDefaultLampState: (LSFLampState *)defaultLampState;

@end

@implementation LSFHelperPresetManagerCallback

@synthesize queue = _queue;

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.queue = [[LSFDispatchQueue getDispatchQueue] queue];
    }
    
    return self;
}

/*
 * Implementation of LSFPresetManagerCallbackDelegate
 */
-(void)getPresetReplyWithCode: (LSFResponseCode)rc presetID: (NSString *)presetID andPreset: (LSFLampState *)preset
{
    //NSLog(@"Get preset callback executing. Preset ID = %@. LSFResponse Code = %u", presetID, rc);
    dispatch_async(self.queue, ^{
        [self updatePresetWithID: presetID andState: preset];
    });
}

-(void)getAllPresetIDsReplyWithCode: (LSFResponseCode)rc andPresetIDs: (NSArray *)presetIDs
{
    //NSLog(@"Get all Preset IDs callback executing");
    LSFPresetManager *presetManager = [[LSFAllJoynManager getAllJoynManager] lsfPresetManager];
    
    dispatch_async(self.queue, ^{
        for (NSString *presetID in presetIDs)
        {
            //NSLog(@"%@", presetID);
            [self updatePresetID: presetID];
            [presetManager getPresetNameWithID: presetID];
            [presetManager getPresetWithID: presetID];
        }
    });
}

-(void)getPresetNameReplyWithCode: (LSFResponseCode)rc presetID: (NSString *)presetID language: (NSString *)language andPresetName: (NSString *)presetName
{
    //NSLog(@"Get preset name callback executing. Name = %@. LSFResponse Code = %u", presetName, rc);
    dispatch_async(self.queue, ^{
        [self updatePresetName: presetName forPresetID: presetID];
    });
}

-(void)getPresetVersionReplyWithCode: (LSFResponseCode)rc presetID: (NSString *)presetID andPresetVersion: (unsigned int)version
{
    //TODO - implement
}

-(void)setPresetNameReplyWithCode: (LSFResponseCode)rc presetID: (NSString *)presetID andLanguage: (NSString *)language
{
    //NSLog(@"Set preset name callback executing. PresetID = %@. Language = %@. Response Code = %i", presetID, language, rc);
    dispatch_async(self.queue, ^{
        [[[LSFAllJoynManager getAllJoynManager] lsfPresetManager] getPresetNameWithID: presetID];
    });
}

-(void)presetsNameChanged: (NSArray *)presetIDs
{
    //NSLog(@"Set preset names changed callback executing.");
    dispatch_async(self.queue, ^{
        LSFPresetManager *presetManager = [[LSFAllJoynManager getAllJoynManager] lsfPresetManager];
        
        for (NSString *presetID in presetIDs)
        {
            [presetManager getPresetNameWithID: presetID];
        }
    });
}

-(void)createPresetReplyWithCode: (LSFResponseCode)rc andPresetID: (NSString *)presetID
{
    //NSLog(@"Create preset callback executing. PresetID = %@. Response Code = %i", presetID, rc);
    dispatch_async(self.queue, ^{
        if (rc == LAMP_OK)
        {
            LSFPresetManager *presetManager = [[LSFAllJoynManager getAllJoynManager] lsfPresetManager];
            [self updatePresetID: presetID];
            [presetManager getPresetNameWithID: presetID];
            [presetManager getPresetWithID: presetID];
        }
    });
}

-(void)createPresetTrackingReplyWithCode: (LSFResponseCode)rc presetID: (NSString *)presetID andTrackingID: (unsigned int)trackingID
{
    //TODO - implement
}

-(void)presetsCreated: (NSArray *)presetIDs
{
    //NSLog(@"Presets created callback executing.");
    dispatch_async(self.queue, ^{
        LSFPresetManager *presetManager = [[LSFAllJoynManager getAllJoynManager] lsfPresetManager];
        for (NSString *presetID in presetIDs)
        {
            [self updatePresetID: presetID];
            [presetManager getPresetNameWithID: presetID];
            [presetManager getPresetWithID: presetID];
        }
    });
}

-(void)updatePresetReplyWithCode: (LSFResponseCode)rc andPresetID: (NSString *)presetID
{
    //NSLog(@"Update preset callback executing. PresetID = %@. Response Code = %i", presetID, rc);
    dispatch_async(self.queue, ^{
        if (rc == LAMP_OK)
        {
            LSFPresetManager *presetManager = [[LSFAllJoynManager getAllJoynManager] lsfPresetManager];
            [self updatePresetID: presetID];
            [presetManager getPresetNameWithID: presetID];
            [presetManager getPresetWithID: presetID];
        }
    });
}

-(void)presetsUpdated: (NSArray *)presetIDs
{
    //NSLog(@"Presets updated callback executing.");
    dispatch_async(self.queue, ^{
        LSFPresetManager *presetManager = [[LSFAllJoynManager getAllJoynManager] lsfPresetManager];
        
        for (NSString *presetID in presetIDs)
        {
            [self updatePresetID: presetID];
            [presetManager getPresetNameWithID: presetID];
            [presetManager getPresetWithID: presetID];
        }
    });
}

-(void)deletePresetReplyWithCode: (LSFResponseCode)rc andPresetID: (NSString *)presetID
{
    //NSLog(@"Delete preset callback executing. PresetID = %@. Response Code = %i", presetID, rc);
    dispatch_async(self.queue, ^{
        [self removePresetWithID: (NSString *)presetID];
    });
}

-(void)presetsDeleted: (NSArray *)presetIDs
{
    //NSLog(@"Presets deleted callback executing.");
    dispatch_async(self.queue, ^{
        [self removePresetsWithIDs: presetIDs];
    });
}

-(void)getDefaultLampStateReplyWithCode: (LSFResponseCode)rc andLampState: (LSFLampState *)defaultLampState
{
    //NSLog(@"Get default lamp state callback executing. Response Code = %i", rc);
    dispatch_async(self.queue, ^{
        [self updateDefaultLampState: defaultLampState];
    });
}

-(void)setDefaultLampStateReplyWithCode: (LSFResponseCode)rc
{
    //NSLog(@"Set default lamp state callback executing. Response Code = %i", rc);
    dispatch_async(self.queue, ^{
        [[[LSFAllJoynManager getAllJoynManager] lsfPresetManager] getDefaultLampState];
    });
}

-(void)defaultLampStateChanged
{
    //NSLog(@"Default lamp state changed callback executing.");
    dispatch_async(self.queue, ^{
        [[[LSFAllJoynManager getAllJoynManager] lsfPresetManager] getDefaultLampState];
    });
}

/*
 * Private function implementations
 */
-(void)updatePresetID: (NSString *)presetID
{
    NSMutableDictionary *presets = [[LSFPresetModelContainer getPresetModelContainer] presetContainer];
    LSFSDKPreset *preset = [presets valueForKey: presetID];

    if (preset == nil)
    {
        preset = [[LSFSDKPreset alloc] initWithPresetID: presetID];
        [presets setValue: preset forKey: presetID];
    }
}

-(void)updatePresetName: (NSString *)name forPresetID: (NSString *)presetID
{
    NSMutableDictionary *presets = [[LSFPresetModelContainer getPresetModelContainer] presetContainer];
    LSFPresetModel *presetModel = [[presets valueForKey: presetID] getPresetDataModel];
    
    if (presetModel != nil)
    {
        presetModel.name = name;
    }
    
    [self updateUI];
}

-(void)updatePresetWithID: (NSString *)presetID andState:(LSFLampState *)preset
{
    NSMutableDictionary *presets = [[LSFPresetModelContainer getPresetModelContainer] presetContainer];
    LSFPresetModel *presetModel = [[presets valueForKey: presetID] getPresetDataModel];
    //LSFConstants *constants = [LSFConstants getConstants];
    
    if (presetModel != nil)
    {
//        presetModel.state.onOff = preset.onOff;
//        presetModel.state.brightness = [constants unscaleLampStateValue: preset.brightness withMax: 100];
//        presetModel.state.hue = [constants unscaleLampStateValue: preset.hue withMax: 360];
//        presetModel.state.saturation = [constants unscaleLampStateValue: preset.saturation withMax: 100];
//        presetModel.state.colorTemp = [constants unscaleColorTemp: preset.colorTemp];
        presetModel.state = preset;
    }
    
    [self updateUI];
}

-(void)removePresetWithID: (NSString *)presetID
{
    NSMutableDictionary *presets = [[LSFPresetModelContainer getPresetModelContainer] presetContainer];
    [presets removeObjectForKey: presetID];
    
    [self updateUI];
}

-(void)removePresetsWithIDs: (NSArray *)presetIDs
{
    NSMutableDictionary *presets = [[LSFPresetModelContainer getPresetModelContainer] presetContainer];
    
    for (NSString *presetID in presetIDs)
    {
        [presets removeObjectForKey: presetID];
    }
    
    [self updateUI];
}

-(void)updateDefaultLampState: (LSFLampState *)defaultLampState
{
    //TODO - implement
}

-(void)updateUI
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName: @"PresetNotification" object: self userInfo: nil];
    });
}

@end

/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
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

#import "LSFSDKPreset.h"
#import "LSFAllJoynManager.h"

@interface LSFSDKPreset()

@property (nonatomic, strong) LSFPresetModel *presetModel;

@end

@implementation LSFSDKPreset

-(id)initWithPresetID: (NSString *)presetID
{
    return [self initWithPresetID: presetID andName: nil];
}

-(id)initWithPresetID: (NSString *)presetID andName: (NSString *)presetName
{
    self = [super init];

    if (self)
    {
        self.presetModel = [[LSFPresetModel alloc] initWithPresetID: presetID andName: presetName];
    }

    return self;
}

-(void)modifyWithPower: (Power)power color: (LSFSDKColor *)color
{
    //TODO - implement
}

-(void)deletePreset
{
    //TODO - implement
}

/*
 * LSFSDKEffect implementation
 */
-(void)applyToGroupMember: (LSFSDKGroupMember *)group
{
    //TODO - implement
}

/*
 * Override base class functions
 */
-(void)setPowerOn: (BOOL)powerOn
{
    //TODO - implement
}

-(void)setColorHsvtWithHue: (unsigned int)hueDegrees saturation: (unsigned int)saturationPercent brightness: (unsigned int)brightnessPercent colorTemp: (unsigned int)colorTempDegrees
{
    //TODO - implement
}

-(void)rename:(NSString *)name
{
    //TODO - implement
}

-(LSFDataModel *)getColorDataModel
{
    return [self getPresetDataModel];
}

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFPresetModel *)getPresetDataModel
{
    return self.presetModel;
}

@end

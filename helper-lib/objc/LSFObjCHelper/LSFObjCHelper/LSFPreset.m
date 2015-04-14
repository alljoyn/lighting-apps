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

#import "LSFPreset.h"
#import "LSFAllJoynManager.h"

@interface LSFPreset()

@property (nonatomic, strong) LSFPresetModel *presetModel;

-(void)applyToLampID: (NSString *)lampID;
-(void)applyToGroupID: (NSString *)groupID;

@end

@implementation LSFPreset

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

-(void)applyToLamp: (LSFLamp *)lamp
{
    [self applyToLampID: [[lamp getLampDataModel] theID]];
}

-(void)applyToGroup: (LSFGroup *)group
{
    [self applyToGroupID: [[group getLampGroupDataModel] theID]];
}

-(void)applyToLampID: (NSString *)lampID
{
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    [ajManager.lsfLampManager transitionLampID: lampID toPresetID: self.presetModel.theID];
}

-(void)applyToGroupID: (NSString *)groupID
{
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    [ajManager.lsfLampGroupManager transitionLampGroupID: groupID toPreset: self.presetModel.theID];
}

-(LSFModel *)getItemDataModel
{
    return [self getPresetDataModel];
}

-(LSFPresetModel *)getPresetDataModel
{
    return self.presetModel;
}

@end

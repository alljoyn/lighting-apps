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

#import <Foundation/Foundation.h>
#import "LSFSDKColorItem.h"
#import "LSFSDKEffect.h"
#import "LSFSDKLampState.h"
#import "LSFSDKPreset.h"
#import "model/LSFPulseEffectDataModelV2.h"

@interface LSFSDKPulseEffect : LSFSDKColorItem <LSFSDKEffect>
{
    @protected LSFPulseEffectDataModelV2 *pulseEffectDataModel;
}

@property (nonatomic) BOOL isStartWithCurrent;
@property (nonatomic, strong) LSFSDKMyLampState * startState;
@property (nonatomic, strong) LSFSDKMyLampState * endState;
@property (nonatomic, strong) LSFSDKPreset * startPreset;
@property (nonatomic, strong) LSFSDKPreset * endPreset;
@property (nonatomic, strong) NSString * startPresetID;
@property (nonatomic, strong) NSString * endPresetID;
@property (nonatomic) unsigned int period;
@property (nonatomic) unsigned int duration;
@property (nonatomic) unsigned int count;

-(instancetype)init NS_UNAVAILABLE;
-(void)modifyFromState: (id<LSFSDKLampState>)fromState toState: (id<LSFSDKLampState>)toState period: (unsigned int)period duration: (unsigned int)duration count: (unsigned int)count;
-(void)deleteItem;
-(BOOL)hasPreset: (LSFSDKPreset *)preset;
-(BOOL)hasPresetWithID: (NSString *)presetID;


/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFPulseEffectDataModelV2 *)getPulseEffectDataModel;

@end

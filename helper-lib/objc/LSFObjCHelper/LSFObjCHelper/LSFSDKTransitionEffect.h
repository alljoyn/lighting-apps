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
#import "model/LSFTransitionEffectDataModelV2.h"

@interface LSFSDKTransitionEffect : LSFSDKColorItem <LSFSDKEffect>
{
    @protected LSFTransitionEffectDataModelV2 *transitionEffectDataModel;
}

@property (nonatomic, strong) LSFSDKPreset *preset;
@property (nonatomic, strong) NSString *presetID;
@property (nonatomic) unsigned int duration;

-(id)initWithTransitionEffectID: (NSString *)transitionEffectID;
-(id)initWithTransitionEffectID: (NSString *)transitionEffectID transitionEffectName: (NSString *)transitionEffectName;
-(void)modify: (id<LSFSDKLampState>)state duration: (unsigned int)duration;
-(void)deleteItem;
-(BOOL)hasPreset: (LSFSDKPreset *)preset;
-(BOOL)hasPresetWithID: (NSString *)presetID;

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFTransitionEffectDataModelV2 *)getTransitionEffectDataModel;

@end
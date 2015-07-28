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

#import <Foundation/Foundation.h>
#import "LSFDataModel.h"

extern const NSString *TRANSITION_EFFECT_DEFAULT_NAME;
extern const unsigned int TRANSITION_EFFECT_DEFAULT_DURATION;

@interface LSFTransitionEffectDataModelV2 : LSFDataModel
{
    @protected BOOL durationInitialized;
}

@property (nonatomic, strong) NSString *presetID;
@property (nonatomic) unsigned int duration;

-(id)init;
-(id)initWithTransitionEffectID: (NSString *)transitionEffectID;
-(id)initWithTransitionEffectID: (NSString *)transitionEffectID andTransitionEffectName: (NSString *)transitionEffectName;
-(BOOL)containsPreset: (NSString *)presetID;

@end
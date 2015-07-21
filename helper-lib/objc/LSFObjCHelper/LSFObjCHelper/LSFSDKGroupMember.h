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

#import "LSFSDKMutableColorItem.h"
#import "LSFSDKEffect.h"

@class LSFSDKPreset;

/**
 * Base class for Lighting items that can be included in a Lighting Group.
 *
 * @warning Client software should not instantiate the LSFSDKGroupMember directly.
 */
@interface LSFSDKGroupMember : LSFSDKMutableColorItem

/**
 * Applies the provided LSFSDKPreset to the current LSFSDKGroupMember.
 *
 * @param preset Preset to apply to the current LSFSDKGroupMember
 */
-(void)applyPreset: (LSFSDKPreset *)preset;

/**
 * Applies the provided LSFSDKEffect to the current LSFSDKGroupMember.
 *
 * @param effect Effect to apply to the current LSFSDKGroupMember
 */
-(void)applyEffect: (id<LSFSDKEffect>)effect;

@end

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
#import <LSFSDKLampDetails.h>
#import "LSFSDKGroupMember.h"
#import "LSFSDKEffect.h"
#import "LSFSDKLampAbout.h"
#import "model/LSFLampModel.h"

@class LSFSDKPreset;

/**
 * An LSFSDKLamp object represents a lamp in the lighting system, and can be used to send commands
 * to it.
 */
@interface LSFSDKLamp : LSFSDKGroupMember
{
    @protected LSFLampModel *lampModel;
}

@property (strong, nonatomic, readonly) LSFSDKLampAbout *about;
@property (strong, nonatomic, readonly) LSFSDKLampDetails *details;
@property (strong, nonatomic, readonly) LSFSDKLampParameters *parameters;
@property (nonatomic, readonly) int colorTempMin;
@property (nonatomic, readonly) int colorTempMax;

-(instancetype)init NS_UNAVAILABLE;

/*
 * Note: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.
 */
-(LSFLampModel *)getLampDataModel;

@end

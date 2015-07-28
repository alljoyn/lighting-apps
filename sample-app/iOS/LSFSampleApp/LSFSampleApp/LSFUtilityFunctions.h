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
#import <LSFSDKCapabilityData.h>
#import <LSFSDKLampDetails.h>
#import <LSFSDKColor.h>
#import <LSFSDKPreset.h>
#import <LSFSDKMyLampState.h>

@interface LSFUtilityFunctions : NSObject

extern NSArray *const LAMP_DETAILS_FIELDS;
extern NSArray *const LAMP_ABOUT_FIELDS;

+(BOOL)checkNameEmpty: (NSString *)name entity: (NSString *)entity;
+(BOOL)checkNameLength: (NSString *)name entity: (NSString *)entity;
+(BOOL)checkWhiteSpaces: (NSString *)name entity: (NSString *)entity;
+(void)colorIndicatorSetup: (UIImageView *)colorIndicatorImage withColor: (LSFSDKColor *) color andCapabilityData: (LSFSDKCapabilityData *)capablity;
+(NSString *)currentWifiSSID;
+(NSArray *)getLampDetailsFields;
+(NSArray *)getLampAboutFields;
+(NSArray *)getSupportedEffects;
+(NSArray *)getEffectImages;
+(NSMutableAttributedString *)getSourceCodeText;
+(NSMutableAttributedString *)getTeamText;
+(NSMutableAttributedString *)getNoticeText;
+(BOOL)preset: (LSFSDKPreset *)preset matchesMyLampState: (LSFSDKMyLampState *)state;
+(NSArray *)sortLightingItemsByName: (NSArray *)items;
+(void)disableActionSheet: (UIActionSheet *)actionSheet buttonAtIndex: (NSInteger)index;

@end

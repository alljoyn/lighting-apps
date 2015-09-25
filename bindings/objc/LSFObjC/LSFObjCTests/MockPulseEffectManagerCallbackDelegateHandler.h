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
#import <internal/LSFPulseEffectManagerCallbackDelegate.h>

@interface MockPulseEffectManagerCallbackDelegateHandler : NSObject <LSFPulseEffectManagerCallbackDelegate>

-(id)init;
-(NSArray *)getCallbackData;

//Delegate methods
-(void)getPulseEffectReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andPulseEffect: (LSFPulseEffectV2 *)pulseEffect;
-(void)applyPulseEffectOnLampsReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andLampIDs: (NSArray *)lampIDs;
-(void)applyPulseEffectOnLampGroupsReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andLampGroupIDs: (NSArray *)lampGroupIDs;
-(void)getAllPulseEffectIDsReplyWithCode: (LSFResponseCode)rc pulseEffectIDs: (NSArray *)pulseEffectIDs;
-(void)getPulseEffectNameReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID language: (NSString *)language andPulseEffectName: (NSString *)pulseEffectName;
-(void)setPulseEffectNameReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andLanguage: (NSString *)language;
-(void)pulseEffectsNameChanged: (NSArray *)pulseEffectIDs;
-(void)createPulseEffectReplyWithCode: (LSFResponseCode)rc pulseEffectID: (NSString *)pulseEffectID andTrackingID: (unsigned int)trackingID;
-(void)pulseEffectsCreated: (NSArray *)pulseEffectIDs;
-(void)updatePulseEffectReplyWithCode: (LSFResponseCode)rc andPulseEffectID: (NSString *)pulseEffectID;
-(void)pulseEffectsUpdated: (NSArray *)pulseEffectIDs;
-(void)deletePulseEffectReplyWithCode: (LSFResponseCode)rc andPulseEffectID: (NSString *)pulseEffectID;
-(void)pulseEffectsDeleted: (NSArray *)pulseEffectIDs;

@end

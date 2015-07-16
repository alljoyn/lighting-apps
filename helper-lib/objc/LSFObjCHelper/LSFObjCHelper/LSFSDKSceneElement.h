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
#import "LSFSDKLightingItem.h"
#import "LSFSDKEffect.h"
#import "LSFSDKGroupMember.h"
#import "LSFSDKDeletableItem.h"
#import "LSFSDKLamp.h"
#import "LSFSDKGroup.h"
#import "model/LSFSceneElementDataModelV2.h"

@interface LSFSDKSceneElement : LSFSDKLightingItem<LSFSDKDeletableItem>
{
    @protected LSFSceneElementDataModelV2 *sceneElementModel;
}

-(instancetype)init NS_UNAVAILABLE;
-(void)apply;
-(void)modifyWithEffect: (id<LSFSDKEffect>)effect groupMembers: (NSArray *)members;
-(void)addMember: (LSFSDKGroupMember *)member;
-(void)removeMember: (LSFSDKGroupMember *)member;
-(NSArray *)getLamps;
-(NSArray *)getGroups;
-(id<LSFSDKEffect>)getEffect;
-(BOOL)hasLampWithID: (NSString *)lampID;
-(BOOL)hasGroupWithID: (NSString *)groupID;
-(BOOL)hasEffectWithID: (NSString *)effectID;
-(BOOL)hasLamp: (LSFSDKLamp *)lamp;
-(BOOL)hasGroup: (LSFSDKGroup *)group;
-(BOOL)hasEffect: (id<LSFSDKEffect>)effect;

/**
 * <b>WARNING: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.</b>
 */
-(LSFSceneElementDataModelV2 *)getSceneElementDataModel;

@end

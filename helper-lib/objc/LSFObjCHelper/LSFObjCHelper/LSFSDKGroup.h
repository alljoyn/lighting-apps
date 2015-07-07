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
#import "LSFSDKGroupMember.h"
#import "LSFSDKPreset.h"
#import "LSFSDKEffect.h"
#import "LSFSDKLamp.h"
#import "model/LSFGroupModel.h"

/**
 * An LSFSDKGroup object represents a set of lamps in the lighting system, and can be used to send the
 * same command to all of them.
 *
 * Groups can contain lamps and nested groups.
 */
@interface LSFSDKGroup : LSFSDKGroupMember <LSFSDKDeletableItem>
{
    @protected LSFGroupModel *groupModel;
}

@property (nonatomic, readonly) int colorTempMin;
@property (nonatomic, readonly) int colorTempMax;
@property (nonatomic, readonly) BOOL isAllLampsGroup;

/** @name Creating LSFSDKLamp */

/**
 * Constructs an instance of the LSFSDKGroup class.
 *
 * @param groupID The ID of the Group.
 *
 * @return Instance of LSFSDKGroup.
 *
 * @warning *Note:* This method is intended to be used internally. Client software should not instantiate
 * Groups directly, but should instead get them from the LSFSDKLightingDirector using the [[LSFSDKLightingDirector getLightingDirector] groups]
 * property.
 */
-(id)initWithGroupID: (NSString *)groupID;

/**
 * Constructs an instance of the LSFSDKGroup class.
 *
 * @param groupID The ID of the Group.
 * @param groupName The name of the Group
 *
 * @return Instance of LSFSDKGroup.
 *
 * @warning *Note:* This method is intended to be used internally. Client software should not instantiate
 * Groups directly, but should instead get them from the LSFSDKLightingDirector using the [[LSFSDKLightingDirector getLightingDirector] groups]
 * property.
 */
-(id)initWithGroupID: (NSString *)groupID andName: (NSString *)groupName;

-(void)add: (LSFSDKGroupMember *)member;
-(void)remove: (LSFSDKGroupMember *)member;
-(void)modify: (NSArray *)members;
-(void)deleteItem;
-(BOOL)hasLamp: (LSFSDKLamp *)lamp;
-(BOOL)hasGroup: (LSFSDKGroup *)group;
-(BOOL)hasLampWithID: (NSString *)lampID;
-(BOOL)hasGroupWithID: (NSString *)groupID;
-(NSArray *)getLamps;
-(NSArray *)getGroups;
-(NSSet *)getLampIDs;
-(NSSet *)getGroupIDs;

/*
 * Note: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.
 */
-(LSFGroupModel *)getLampGroupDataModel;

@end

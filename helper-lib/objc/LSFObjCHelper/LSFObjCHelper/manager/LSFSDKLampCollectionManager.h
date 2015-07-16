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

#import "LSFSDKLightingItemCollectionManager.h"
#import "LSFSDKLamp.h"
#import "LSFSDKLampDelegate.h"


@interface LSFSDKLampCollectionManager : LSFSDKLightingItemCollectionManager
{
    @protected NSMutableArray *lampIDs;
}

-(id)init;
-(void)addLampDelegate: (id<LSFSDKLampDelegate>)lampDelegate;
-(void)removeLampDelegate: (id<LSFSDKLampDelegate>)lampDelegate;
-(LSFSDKLamp *)addLampWithID: (NSString *)lampID;
-(LSFSDKLamp *)addLampWithID: (NSString *)lampID lamp: (LSFSDKLamp *)lamp;
-(LSFSDKLamp *)getLampWithID: (NSString *)lampID;
-(NSArray *)getLamps;
-(NSArray *)getLampsWithFilter: (id<LSFSDKLightingItemFilter>)filter;
-(NSArray *)getLampsCollectionWithFilter: (id<LSFSDKLightingItemFilter>)filter;
-(NSArray *)removeAllLamps;
-(LSFSDKLamp *)removeLampWithID: (NSString *)lampID;
-(LSFLampModel *)getModelWithID: (NSString *)lampID;

@end
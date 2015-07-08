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
#import "LSFSDKLightingItemListenerManager.h"
#import "LSFSDKTrackingID.h"
#import "../LSFSDKLightingItemErrorEvent.h"
#import "../LSFSDKLightingDelegate.h"
#import "../model/LSFSDKLightingItemFilter.h"
#import <LSFSDKResponseCodes.h>

@interface LSFSDKLightingItemCollectionManager : LSFSDKLightingItemListenerManager
{
    @protected NSMutableDictionary *itemAdapters;
}

-(id)init;
-(BOOL)hasID: (NSString *)itemID;
-(NSArray *)getIDArray;
-(unsigned int)size;
-(id)getAdapterForID: (NSString *)itemID;
-(NSArray *)removeAllAdapters;
-(id)removeAdapterWithID: (NSString *)itemID;
-(NSArray *)getAdapters;
-(NSArray *)getAdaptersWithFilter: (id<LSFSDKLightingItemFilter>)filter;
-(void)sendInitializedEvent: (NSString *)itemID;
-(void)sendInitializedEvent: (NSString *)itemID withTrackingID: (LSFSDKTrackingID *)trackingID;
-(void)sendChangedEvent: (NSString *)itemID;
-(void)sendRemovedEvent: (id)item;
-(void)sendErrorEvent: (NSString *)errorName statusCode: (lsf::LSFResponseCode)responseCode;
-(void)sendErrorEvent: (NSString *)errorName statusCode: (lsf::LSFResponseCode)responseCode itemID: (NSString *)itemID;
-(void)sendErrorEvent: (NSString *)errorName statusCode: (lsf::LSFResponseCode)responseCode itemID: (NSString *)itemID withTrackingID: (LSFSDKTrackingID *)trackingID;
-(void)sendErrorEvent: (LSFSDKLightingItemErrorEvent *)errorEvent;
-(void)sendInitializedEvent: (id<LSFSDKLightingDelegate>)delegate item: (id)item trackingID: (LSFSDKTrackingID *)trackingID;
-(void)sendChangedEvent: (id<LSFSDKLightingDelegate>)delegate item: (id)item;
-(void)sendRemovedEvent: (id<LSFSDKLightingDelegate>)delegate item: (id)item;
-(void)sendErrorEvent: (id<LSFSDKLightingDelegate>)delegate errorEvent: (LSFSDKLightingItemErrorEvent *)errorEvent;

@end

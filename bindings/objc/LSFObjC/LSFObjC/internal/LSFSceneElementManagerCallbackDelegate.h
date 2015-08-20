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
#import <LSFResponseCodes.h>
#import "LSFSceneElement.h"

using namespace lsf;

@protocol LSFSceneElementManagerCallbackDelegate <NSObject>

-(void)getAllSceneElementIDsReplyWithCode: (LSFResponseCode)rc andSceneElementIDs: (NSArray *)sceneElementIDs;
-(void)getSceneElementNameReplyWithCode: (LSFResponseCode)rc sceneElementID: (NSString *)sceneElementID language: (NSString *)language andSceneElementName: (NSString *)sceneElementName;
-(void)setSceneElementNameReplyWithCode: (LSFResponseCode)rc sceneElementID: (NSString *)sceneElementID andLanguage: (NSString *)language;
-(void)sceneElementsNameChanged: (NSArray *)sceneElementIDs;
-(void)createSceneElementReplyWithCode: (LSFResponseCode)rc sceneElementID: (NSString *)sceneElementID andTrackingID: (unsigned int)trackingID;
-(void)sceneElementsCreated: (NSArray *)sceneElementIDs;
-(void)updateSceneElementReplyWithCode: (LSFResponseCode)rc andSceneElementID: (NSString *)sceneElementID;
-(void)sceneElementsUpdated: (NSArray *)sceneElementIDs;
-(void)deleteSceneElementReplyWithCode: (LSFResponseCode)rc andSceneElementID: (NSString *)sceneElementID;
-(void)sceneElementsDeleted: (NSArray *)sceneElementIDs;
-(void)getSceneElementReplyWithCode: (LSFResponseCode)rc sceneElementID: (NSString *)sceneElementID andSceneElement: (LSFSceneElement *)sceneElement;
-(void)applySceneElementReplyWithCode: (LSFResponseCode)rc andSceneElementID: (NSString *)sceneElementID;
-(void)sceneElementsApplied: (NSArray *)sceneElementIDs;

@end

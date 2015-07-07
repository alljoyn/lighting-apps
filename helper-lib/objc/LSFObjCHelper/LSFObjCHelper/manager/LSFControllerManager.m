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

#import "LSFControllerManager.h"
#import "LSFSDKControllerDelegate.h"

@interface LSFControllerManager()

@property (nonatomic, strong) LSFSDKController *leader;

@end

@implementation LSFControllerManager

-(id)init
{
    self = [super init];

    if (self)
    {
        self.leader = [[LSFSDKController alloc] init];
    }

    return self;
}

-(LSFSDKController *)getLeader
{
    return self.leader;
}

-(void)sendLeaderStateChangedEvent
{
    for (id delegate in delegates)
    {
        if ([delegate conformsToProtocol: @protocol(LSFSDKControllerDelegate)])
        {
            id<LSFSDKControllerDelegate> controllerDelegate = (id<LSFSDKControllerDelegate>)delegate;
            [controllerDelegate onLeaderChange: [self getLeader]];
        }
        else
        {
            NSLog(@"LSFControllerManager - sendLeaderStateChangedEvent() delegate does not conform to \"LSFControllerListener\" protocol.");
        }
    }
}

-(void)sendErrorEventWithName: (NSString *)name andResonseCode: (LSFResponseCode)responseCode
{
    [self sendErrorEvent: [[LSFSDKControllerErrorEvent alloc] initWithName: name andResponseCode: responseCode]];
}

-(void)sendErrorEventWithName: (NSString *)name andErrorCodes: (NSArray *)errorCodes
{
    LSFSDKControllerErrorEvent *errorEvent = [[LSFSDKControllerErrorEvent alloc] initWithName: name andErrorCodes: errorCodes];
    [self sendErrorEvent: errorEvent];
}

-(void)sendErrorEvent: (LSFSDKControllerErrorEvent *)errorEvent
{
    for (id delegate in delegates)
    {
        if ([delegate conformsToProtocol: @protocol(LSFSDKControllerDelegate)])
        {
            id<LSFSDKControllerDelegate> controllerDelegate = (id<LSFSDKControllerDelegate>)delegate;
            [controllerDelegate onControllerError: errorEvent];
        }
        else
        {
            NSLog(@"LSFControllerManager - sendErrorEvent() delegate does not conform to \"LSFControllerListener\" protocol.");
        }
    }
}

@end

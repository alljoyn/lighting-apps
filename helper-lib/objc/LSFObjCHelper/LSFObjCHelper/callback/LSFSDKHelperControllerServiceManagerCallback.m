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

#import "LSFSDKHelperControllerServiceManagerCallback.h"
#import "LSFSDKLightingSystemManager.h"
#import "LSFControllerModel.h"

@interface LSFSDKHelperControllerServiceManagerCallback()

@property (nonatomic, strong) LSFSDKLightingSystemManager *manager;

-(void)postSendControllerChanged;

@end

@implementation LSFSDKHelperControllerServiceManagerCallback

@synthesize manager = _manager;

-(id)initWithLightingSystemManager: (LSFSDKLightingSystemManager *)manager
{
    self = [super init];

    if (self)
    {
        self.manager = manager;
    }

    return self;
}

/*
 * Implementation of LSFControllerServiceManagerCallbackDelegate
 */
-(void)getControllerServiceVersionReply: (unsigned int)version
{
    dispatch_async(self.manager.dispatchQueue, ^{
        [[[[self.manager controllerManager] getLeader] getControllerDataModel] setControllerVersion: version];
        [self postSendControllerChanged];
    });
}

-(void)lightingResetControllerServiceReplyWithCode: (LSFResponseCode)rc
{
    NSLog(@"LSFSampleControllerServiceManagerCallback - Lighting Controller Service Reset reply with code %i", rc);
}

-(void)controllerServiceLightingReset
{
    NSLog(@"LSFSampleControllerServiceManagerCallback - Controller Service Lighting Reset");
}

-(void)controllerServiceNameChangedForControllerID: (NSString *)controllerID andName: (NSString *)controllerName
{
    //TODO - should be handled by the AboutManager
}

-(void)postSendControllerChanged
{
    dispatch_async(self.manager.dispatchQueue, ^{
        [[self.manager controllerManager] sendLeaderStateChangedEvent];
    });
}

@end
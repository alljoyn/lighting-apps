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

#import "LSFSDKControllerDelegateBase.h"
#import "LSFSDKLightingDirector.h"
#import "manager/LSFControllerManager.h"
#import "manager/LSFSDKLightingSystemManager.h"

@implementation LSFSDKControllerDelegateBase

@synthesize delegate = _delegate;

-(id)init
{
    self = [super init];

    if (self)
    {
        //Intentionally left blank
    }

    return self;
}

-(void)onLeaderChange: (LSFSDKController *)leader
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.delegate)
        {
            [self.delegate onNextControllerConnection];
        }
    });

    //Remove self as delegate
    LSFSDKLightingSystemManager *manager = [[LSFSDKLightingDirector getLightingDirector] lightingManager];
    [[manager controllerManager] removeDelegate: self];
}

-(void)onControllerError: (LSFSDKControllerErrorEvent *)errorEvent
{
    //Intentionally left blank
}

@end
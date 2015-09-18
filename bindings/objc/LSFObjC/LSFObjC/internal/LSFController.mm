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

#import "LSFController.h"
#import "Controller.h"

@interface LSFController()

@property (nonatomic, readonly) Controller *controller;

@end

@implementation LSFController

@synthesize controller = _controller;
@synthesize isLeader = _isLeader;
@synthesize name = _name;

-(id)init
{
    self = [super init];

    if (self)
    {
        self.handle = new Controller();
    }

    return self;
}

-(void)initializeWithControllerServiceDelegate: (id<LSFControllerServiceDelegate>)csd;
{
    self.controller->SetControllerCallback(csd);
}

-(void)dealloc
{
    Controller *ptr = [self controller];

    if (ptr)
    {
        delete ptr;
    }

    self.handle = NULL;
}

-(void)startControllerWithKeyStoreFilePath: (NSString *)keyStoreFilePath
{
    NSLog(@"LSFController.mm - start method exectuing. KeyStoreFilePath = %@", keyStoreFilePath);

    self.controller->StartController([keyStoreFilePath UTF8String]);
}

-(void)stopController
{
    NSLog(@"LSFController.mm - stop method exectuing");

    self.controller->StopController();
}

-(void)factoryResetController
{
    self.controller->FactoryResetController();
}

-(void)lightingResetController
{
    self.controller->LightingResetController();
}

-(void)sendNetworkConnected
{
    self.controller->SendNetworkConnected();
}

-(void)sendNetworkDisconnected
{
    self.controller->SendNetworkDisconnected();
}

-(BOOL)isLeader
{
    return self.controller->IsControllerLeader();
}

-(NSString *)name
{
    qcc::String controllerName = self.controller->GetControllerName();
    NSString *name = [NSString stringWithUTF8String: controllerName.c_str()];
    return name;
}

/*
 * Accessor for the internal C++ API object this objective-c class encapsulates
 */
- (Controller *)controller
{
    return static_cast<Controller*>(self.handle);
}

@end

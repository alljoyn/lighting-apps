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

#import "LSFControllerSystemManager.h"
#import "LSFController.h"

@interface LSFControllerSystemManager()

@property (nonatomic, strong) LSFController *controller;
@property (nonatomic, strong) NSString *DEVICE_ID_KEY;
@property (nonatomic, strong) NSString *APP_ID_KEY;

@end

@implementation LSFControllerSystemManager

@synthesize controllerStarted = _controllerStarted;
@synthesize controller = _controller;
@synthesize DEVICE_ID_KEY = _DEVICE_ID_KEY;
@synthesize APP_ID_KEY = _APP_ID_KEY;

+(LSFControllerSystemManager *)getControllerSystemManager
{
    static LSFControllerSystemManager *cssManager = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        cssManager = [[self alloc] init];
    });

    return cssManager;
}

-(id)init
{
    self = [super init];

    if (self)
    {
        self.controllerStarted = NO;
        self.controller = [[LSFController alloc] initWithControllerServiceDelegate: self];
        self.DEVICE_ID_KEY = @"CONTROLLER_DEVICE_ID";
        self.APP_ID_KEY = @"CONTROLLER_APP_ID";
    }

    return self;
}

-(void)startController
{
    self.controllerStarted = YES;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.controller startControllerWithKeyStoreFilePath: @"Documents"];
    });
}

-(void)stopController
{
    self.controllerStarted = NO;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.controller stopController];
    });
}

/*
 * LSFControllerServiceDelegate implementation
 */
-(NSString *)getControllerDefaultDeviceID: (NSString *)randomDeviceID
{
    NSLog(@"ViewController - getControllerDefaultDeviceID() executing");

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *savedDeviceID = [userDefaults stringForKey: self.DEVICE_ID_KEY];
    NSLog(@"savedDeviceID returned from NSUserDefaults = %@", savedDeviceID);

    if (savedDeviceID == nil)
    {
        NSLog(@"savedDeviceID not found in NSUserDefaults");
        savedDeviceID = randomDeviceID;
        [userDefaults setObject: savedDeviceID forKey: self.DEVICE_ID_KEY];
        NSLog(@"savedDeviceID = %@", savedDeviceID);
    }

    return savedDeviceID;
}

-(NSString *)getControllerDefaultAppID: (NSString *)randomAppID
{
    NSLog(@"ViewController - getControllerDefaultAppID() executing");

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *savedAppID = [userDefaults stringForKey: self.APP_ID_KEY];
    NSLog(@"savedAppID returned from NSUserDefaults = %@", savedAppID);

    if (savedAppID == nil)
    {
        NSLog(@"savedAppID not found in NSUserDefaults");
        savedAppID = randomAppID;
        [userDefaults setObject: savedAppID forKey: self.APP_ID_KEY];
        NSLog(@"savedAppID = %@", savedAppID);
    }

    return savedAppID;
}

-(uint64_t)getMacAddress
{
    NSLog(@"ViewController - getMacAddress() executing");

    uint64_t returnValue = 0;

    for (int i = 0; i < 6; i++)
    {
        uint64_t val = arc4random_uniform(255);
        returnValue = ((returnValue << 8) | val);
    }
    
    return returnValue;
}

@end


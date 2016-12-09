/******************************************************************************
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFWifiMonitor.h"
#import "LSFUtilityFunctions.h"
#import <LSFSDKLightingDirector.h>
#import <LSFSDKLightingController.h>
#import <LSFSDKLightingControllerConfigurationBase.h>

#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>
#import <sys/socket.h>
#import <CoreFoundation/CoreFoundation.h>

@interface LSFWifiMonitor()

@property (nonatomic, strong) NSString *lastKnownSSID;
@property (nonatomic, strong) LSFSDKLightingControllerConfigurationBase *configuration;

-(void)startController;
-(void)stopController;

@end

/*
 * Static functions to serve as reachability callback and print flags
 */
static void NetworkStatusCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void* info)
{
    NSLog(@"LSFWifiMonitor - NetworkStatusCallback() executing");
    [[LSFWifiMonitor getWifiMonitor] checkCurrentStatus];
}

@implementation LSFWifiMonitor
{
	SCNetworkReachabilityRef _nrr;
}

@synthesize isWifiConnected = _isWifiConnected;
@synthesize lastKnownSSID = _lastKnownSSID;
@synthesize configuration = _configuration;

+(id)getWifiMonitor
{
    static LSFWifiMonitor *wifiMonitor = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        wifiMonitor = [[self alloc] init];
    });

    return wifiMonitor;
}

-(id)init
{
    self = [super init];

    if (self)
    {
        self.lastKnownSSID = @"";

        struct sockaddr_in localWifiAddress;
        bzero(&localWifiAddress, sizeof(localWifiAddress));
        localWifiAddress.sin_len = sizeof(localWifiAddress);
        localWifiAddress.sin_family = AF_INET;
        localWifiAddress.sin_addr.s_addr = htonl(IN_LINKLOCALNETNUM);

        _nrr = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&localWifiAddress);

        //Initialize Controller configuration and controller
        self.configuration = [[LSFSDKLightingControllerConfigurationBase alloc] initWithKeystorePath: @"Documents"];
        LSFSDKLightingController *lightingController = [LSFSDKLightingController getLightingController];
        [lightingController initializeWithControllerConfiguration: self.configuration];

        if ([self currentNetworkStatus] == NotReachable)
        {
            NSLog(@"Wifi Disconnected at startup");
            self.isWifiConnected = NO;
            self.lastKnownSSID = @"";
        }
        else
        {
            NSLog(@"Wifi Connected at startup. Last Known SSID = %@", [LSFUtilityFunctions currentWifiSSID]);
            self.isWifiConnected = YES;
            self.lastKnownSSID = [LSFUtilityFunctions currentWifiSSID];

            [self startController];
        }

        BOOL monitorStartSuccess = [self startMonitoringWifi];
        NSLog(@"Starting to monitor wifi return %@", monitorStartSuccess ? @"success" : @"fail");
    }

    return self;
}

-(void)dealloc
{
    [self stopMonitoringWifi];

	if (_nrr != NULL)
	{
		CFRelease(_nrr);
	}
}

-(BOOL)startMonitoringWifi
{
    BOOL successful = NO;
	SCNetworkReachabilityContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};

	if (SCNetworkReachabilitySetCallback(_nrr, NetworkStatusCallback, &context))
	{
		if (SCNetworkReachabilityScheduleWithRunLoop(_nrr, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode))
		{
			successful = YES;
		}
	}

	return successful;
}

-(void)stopMonitoringWifi
{
    if (_nrr != NULL)
	{
		SCNetworkReachabilityUnscheduleFromRunLoop(_nrr, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
	}
}

-(void)checkCurrentStatus
{
    NetworkConnectionStatus ncs = [self currentNetworkStatus];

    if (ncs == NotReachable && self.isWifiConnected)
    {
        NSLog(@"Wifi Disconnected");
        self.isWifiConnected = NO;
        self.lastKnownSSID = @"";
        [self stopController];

        [[NSNotificationCenter defaultCenter] postNotificationName: @"WifiNotification" object: self];
    }
    else
    {
        NSLog(@"Wifi Connected. Last Known SSID = %@. Current SSID = %@", self.lastKnownSSID, [LSFUtilityFunctions currentWifiSSID]);

        if ([LSFUtilityFunctions currentWifiSSID] == nil)
        {
            NSLog(@"Current Wi-Fi SSID is nil just calling stop");
            [self stopController];

            self.isWifiConnected = NO;
            self.lastKnownSSID = [LSFUtilityFunctions currentWifiSSID];

            [[NSNotificationCenter defaultCenter] postNotificationName: @"WifiNotification" object: self];
        }
        else
        {
            if (![self.lastKnownSSID isEqualToString: [LSFUtilityFunctions currentWifiSSID]])
            {
                NSLog(@"SSID has changed. Resetting Controller.");

                if (self.isWifiConnected)
                {
                    [self stopController];
                }

                [self startController];

                self.isWifiConnected = YES;
                self.lastKnownSSID = [LSFUtilityFunctions currentWifiSSID];

                [[NSNotificationCenter defaultCenter] postNotificationName: @"WifiNotification" object: self];
            }
        }
    }
}

-(NetworkConnectionStatus)currentNetworkStatus
{
    NetworkConnectionStatus ncs = NotReachable;
    SCNetworkReachabilityFlags flags;

    if (SCNetworkReachabilityGetFlags(_nrr, &flags))
    {
        if ((flags & kSCNetworkReachabilityFlagsReachable) && (flags & kSCNetworkReachabilityFlagsIsDirect))
        {
            ncs = ReachableViaWiFi;
        }
    }

    return ncs;
}

/*
 * Private Functions
 */
-(void)startController
{
    [[LSFSDKLightingDirector getLightingDirector] startWithApplicationName: @"LightingDirector" dispatchQueue: dispatch_get_main_queue()];

    dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
        [[LSFSDKLightingController getLightingController] start];
    });
}

-(void)stopController
{
    [[LSFSDKLightingDirector getLightingDirector] stop];

    dispatch_async([[LSFSDKLightingDirector getLightingDirector] queue], ^{
        [[LSFSDKLightingController getLightingController] start];
    });
}

@end
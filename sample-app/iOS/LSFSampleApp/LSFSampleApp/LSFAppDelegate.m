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

#import "LSFAppDelegate.h"
#import "LSFWifiMonitor.h"
#import "LSFTabManager.h"

#import <LSFSDKLightingDirector.h>
#import "LSFLightingEventListener.h"

@implementation LSFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"LSFAppDelegate - applicationDidFinishLaunchingWithOptions()");

    LSFSDKLightingDirector *lightingDirector = [LSFSDKLightingDirector getLightingDirector];
    [lightingDirector addDelegate:[[LSFLightingEventListener alloc] init]];
    
    [lightingDirector startWithApplicationName: @"LightingDirector" dispatchQueue: dispatch_get_main_queue()];

    [LSFTabManager getTabManager];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"LSFAppDelegate - applicationWillResignActive()");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"LSFAppDelegate - applicationDidEnterBackground()");

    //Close app when it enters the background
    exit(0);
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"LSFAppDelegate - applicationWillEnterForeground()");

    [[LSFWifiMonitor getWifiMonitor] checkCurrentStatus];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"LSFAppDelegate - applicationDidBecomeActive()");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"LSFAppDelegate - applicationWillTerminate()");
}

@end

/******************************************************************************
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 ******************************************************************************/

#import "LSFTrackingIDDelegate.h"
#import <LSFSDKTrackingID.h>

@interface LSFLightingListenerUtil : NSObject

+(void)listenForTrackingID: (LSFSDKTrackingID *)trackingID delegate: (id<LSFTrackingIDDelegate>)delegate;
+(void)listenForTrackingID: (LSFSDKTrackingID *)trackingID perform: (void (^)(id item))performBlock;
+(void)listenForTrackingID: (LSFSDKTrackingID *)trackingID perform: (void (^)(id item))performBlock onError: (void (^)(id item))performError;

@end
/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import "LSFScenesV1ModuleProxy.h"
#import "scenesV1/LSFScenesV1SupportDelegate.h"
#import "LSFScenesV1NoSupportDelegate.h"

@implementation LSFScenesV1ModuleProxy

@synthesize scenesV1Delegate = _scenesV1Delegate;

+(LSFScenesV1ModuleProxy *)getProxy
{
    static LSFScenesV1ModuleProxy *proxy = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        proxy = [[self alloc] init];
    });

    return proxy;
}

-(id)init
{
    self = [super init];

    if (self)
    {
#ifdef LSF_SCENES_V1_MODULE
        _scenesV1Delegate = [[LSFScenesV1SupportDelegate alloc] init];
#else
        _scenesV1Delegate = [[LSFScenesV1NoSupportDelegate alloc] init];
#endif
    }

    return self;
}

@end
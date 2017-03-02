/******************************************************************************
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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

#import "LSFSDKAboutData.h"

@interface LSFSDKAboutData()

@property (nonatomic, readonly) ajn::AboutData *myAboutData;

@end

@implementation LSFSDKAboutData

@synthesize myAboutData = _myAboutData;

-(id)initWithAboutData: (ajn::AboutData *)aboutData
{
    self = [super init];

    if (self)
    {
        self.handle = aboutData;
    }

    return self;
}

-(void)putKey: (NSString *)key withStringValue: (NSString *)value
{
    [self putKey: key withStringValue: value andLanguage: @""];
}

-(void)putKey: (NSString *)key withStringValue: (NSString *)value andLanguage: (NSString *)language
{
    ajn::MsgArg msgArg;
    msgArg.Set("s", [value UTF8String]);
    msgArg.Stabilize();
    [self putKey: key withMsgArg: &msgArg andLanguage: language];
}

-(void)putKey: (NSString *)key withStringArrayValue: (NSArray *)value
{
    [self putKey: key withStringArrayValue: value andLanguage: @""];
}

-(void)putKey: (NSString *)key withStringArrayValue: (NSArray *)value andLanguage: (NSString *)language
{
    ajn::MsgArg msgArg;
    const char* strArray[[value count]];

    for (int i = 0; i < [value count]; i++)
    {
        strArray[i] = [[value objectAtIndex: i] UTF8String];
    }

    msgArg.Set("as", (size_t)[value count], strArray);
    msgArg.Stabilize();

    [self putKey: key withMsgArg: &msgArg andLanguage: language];
}

-(void)putKey: (NSString *)key witDataValue: (NSData *)value
{
    [self putKey: key witDataValue: value andLanguage: @""];
}

-(void)putKey: (NSString *)key witDataValue: (NSData *)value andLanguage: (NSString *)language
{
    ajn::MsgArg msgArg;

    uint8_t* byteArray = (uint8_t *)[value bytes];
    msgArg.Set("ay", [value length], byteArray);
    msgArg.Stabilize();

    [self putKey: key withMsgArg: &msgArg andLanguage: language];
}

/*
 * Private
 */
-(void)putKey: (NSString *)key withMsgArg:(ajn::MsgArg *)msgArg
{
    [self putKey: key withMsgArg: msgArg andLanguage: @""];
}

-(void)putKey: (NSString *)key withMsgArg:(ajn::MsgArg *)msgArg andLanguage: (NSString *)language
{
    self.myAboutData->SetField([key UTF8String], *msgArg, [language UTF8String]);
}

/*
 * Accessor for the internal C++ API object this objective-c class encapsulates
 */
- (ajn::AboutData *)myAboutData
{
    return static_cast<ajn::AboutData*>(self.handle);
}

@end
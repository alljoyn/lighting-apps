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
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import <lsf/controllerservice/OEM_CS_Config.h>
#import "../LSFSDKAboutData.h"

using namespace lsf;

#ifdef LSF_BINDINGS
using namespace controllerservice;
#endif

@protocol LSFControllerServiceDelegate <NSObject>

-(NSString *)getControllerDefaultDeviceID: (NSString *)generatedDeviceID;
-(unsigned long long)getMacAddressAsDecimal: (NSString *)generatedMacAddress;
-(BOOL)isNetworkConnected;
-(OEM_CS_RankParam_Mobility)getControllerRankMobility;
-(OEM_CS_RankParam_Power)getControllerRankPower;
-(OEM_CS_RankParam_Availability)getControllerRankAvailability;
-(OEM_CS_RankParam_NodeType)getControllerRankNodeType;
-(void)populateDefaultProperties: (LSFSDKAboutData *)aboutData;

@end
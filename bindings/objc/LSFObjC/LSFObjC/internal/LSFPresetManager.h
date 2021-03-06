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

#import <Foundation/Foundation.h>
#import "LSFObject.h"
#import "LSFControllerClient.h"
#import "LSFPresetManagerCallbackDelegate.h"
#import "LSFLampState.h"
#import <PresetManager.h>

@interface LSFPresetManager : LSFObject

-(id)initWithControllerClient: (LSFControllerClient *)controllerClient andPresetManagerCallbackDelegate: (id<LSFPresetManagerCallbackDelegate>)pmDelegate;
-(ControllerClientStatus)getAllPresetIDs;
-(ControllerClientStatus)getPresetWithID: (NSString *)presetID;
-(ControllerClientStatus)getPresetNameWithID: (NSString *)presetID;
-(ControllerClientStatus)getPresetNameWithID: (NSString *)presetID andLanguage: (NSString *)language;
-(ControllerClientStatus)setPresetNameWithID: (NSString *)presetID andPresetName: (NSString *)name;
-(ControllerClientStatus)setPresetNameWithID: (NSString *)presetID presetName: (NSString *)name andLanguage: (NSString *)language;
-(ControllerClientStatus)createPresetWithState: (LSFLampState *)preset andPresetName: (NSString *)name;
-(ControllerClientStatus)createPresetWithState: (LSFLampState *)preset presetName: (NSString *)name andLanguage: (NSString *)language;
-(ControllerClientStatus)createPresetWithTracking: (uint32_t *)trackingID state: (LSFLampState *)preset andPresetName: (NSString *)name;
-(ControllerClientStatus)createPresetWithTracking: (uint32_t *)trackingID state: (LSFLampState *)preset presetName: (NSString *)name andLanguage: (NSString *)language;
-(ControllerClientStatus)updatePresetWithID: (NSString *)presetID andState: (LSFLampState *)preset;
-(ControllerClientStatus)deletePresetWithID: (NSString *)presetID;
-(ControllerClientStatus)getDefaultLampState;
-(ControllerClientStatus)setDefaultLampState: (LSFLampState *)defaultLampState;
-(ControllerClientStatus)getPresetDataSetWithID: (NSString *)presetID;
-(ControllerClientStatus)getPresetDataSetWithID: (NSString *)presetID andLanguage: (NSString *)language;

@end
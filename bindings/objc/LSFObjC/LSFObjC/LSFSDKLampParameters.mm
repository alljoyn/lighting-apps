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

#import "LSFSDKLampParameters.h"
#import <LSFTypes.h>

@interface LSFSDKLampParameters()

@property (nonatomic, readonly) lsf::LampParameters *lampParameters;

@end

@implementation LSFSDKLampParameters

@synthesize lampParameters = _lampParameters;

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.handle = new lsf::LampParameters();
    }
    
    return self;
}

-(void)setEnergyUsageMilliwatts: (unsigned int)energyUsageMilliwatts
{
    self.lampParameters->energyUsageMilliwatts = energyUsageMilliwatts;
}

-(unsigned int)energyUsageMilliwatts
{
    return self.lampParameters->energyUsageMilliwatts;
}

-(void)setLumens: (unsigned int)lumens
{
    self.lampParameters->lumens = lumens;
}

-(unsigned int)lumens
{
    return self.lampParameters->lumens;
}

/*
 * Accessor for the internal C++ API object this objective-c class encapsulates
 */
- (lsf::LampParameters *)lampParameters
{
    return static_cast<lsf::LampParameters*>(self.handle);
}

@end
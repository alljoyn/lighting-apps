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
#import "LSFHandle.h"

/**
 *  The base class for all AllJoyn API objects
 */
@interface LSFObject : NSObject<LSFHandle>

/** A handle to the C++ API object associated with this objective-c class */
@property (nonatomic, assign) LSFHandle handle;

/** 
 * Initialize the API object
 *
 * @param handle The handle to the C++ API object associated with this objective-c API object
 */
-(id)initWithHandle: (LSFHandle)handle;

/** 
 * Initialize the API object
 *
 * @param handle The handle to the C++ API object associated with this objective-c API object.
 * @param deletionFlag A flag indicating whether or not the objective-c class should call delete on the handle when dealloc is called.
 */
-(id)initWithHandle: (LSFHandle)handle shouldDeleteHandleOnDealloc: (BOOL)deletionFlag;

@end
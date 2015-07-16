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

#import "LSFObject.h"

@interface LSFObject()

/**
 * Flag indicating whether or not the object pointed to by handle should be deleted when an instance of this class is deallocated.
 */
@property (nonatomic) BOOL shouldDeleteHandleOnDealloc;

@end

@implementation LSFObject

@synthesize handle = _handle;
@synthesize shouldDeleteHandleOnDealloc = _shouldDeleteHandleOnDealloc;

-(id)initWithHandle: (LSFHandle)handle
{
    self = [super init];
    
    if (self)
    {
        self.handle = handle;
        self.shouldDeleteHandleOnDealloc = NO;
    }
    
    return self;
}

-(id)initWithHandle: (LSFHandle)handle shouldDeleteHandleOnDealloc: (BOOL)deletionFlag
{
    self = [super init];
    
    if (self)
    {
        self.handle = handle;
        self.shouldDeleteHandleOnDealloc = deletionFlag;
    }
    
    return self;
}

@end
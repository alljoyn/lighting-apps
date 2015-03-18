/******************************************************************************
 * Copyright (c) 2014, AllSeen Alliance. All rights reserved.
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

#import "LSFLampModelContainer.h"
#import "LSFLampModel.h"

@interface LSFLampModelContainer()

//-(void)populateDictionary;

@end

@implementation LSFLampModelContainer

@synthesize lampContainer = _lampContainer;

+(id)getLampModelContainer
{
    static LSFLampModelContainer *lampModelContainer = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        lampModelContainer = [[self alloc] init];
    });
    
    return lampModelContainer;
}

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.lampContainer = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

@end
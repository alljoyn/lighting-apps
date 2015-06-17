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

#import "LSFDataModel.h"

@interface LSFDataModel()

@end

@implementation LSFDataModel

@synthesize state = _state;
@synthesize capability = _capability;
@synthesize uniformity = _uniformity;

-(id)initWithID: (NSString *)theID andName: (NSString *)name
{
    self = [super initWithID: theID andName: name];

    if (self)
    {
        self.state = [[LSFLampState alloc] init];
        self.capability = [[LSFCapabilityData alloc] init];
        self.uniformity = [[LSFLampStateUniformity alloc] init];
        stateInitialized = NO;
    }

    return self;
}

-(void)setState: (LSFLampState *)state
{
    _state = state;
    stateInitialized = YES;
}

-(BOOL)isInitialized
{
    return ([super isInitialized] && stateInitialized);
}

@end

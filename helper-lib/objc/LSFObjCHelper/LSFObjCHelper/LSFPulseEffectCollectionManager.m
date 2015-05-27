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

#import "LSFPulseEffectCollectionManager.h"

@implementation LSFPulseEffectCollectionManager

@synthesize pulseEffectContainer = _pulseEffectContainer;

+(id)getPulseEffectCollectionManager
{
    static LSFPulseEffectCollectionManager *pulseEffectCollectionManager = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        pulseEffectCollectionManager = [[self alloc] init];
    });

    return pulseEffectCollectionManager;
}

-(id)init
{
    self = [super init];

    if (self)
    {
        self.pulseEffectContainer = [[NSMutableDictionary alloc] init];
    }

    return self;
}

@end

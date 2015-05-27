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

#import "LSFTransitionEffectV2.h"
#import "LSFTypes.h"

@interface LSFTransitionEffectV2()

@property (nonatomic, readonly) lsf::TransitionEffect *transitionEffect;

@end

@implementation LSFTransitionEffectV2

@synthesize transitionEffect = _transitionEffect;

-(id)init
{
    self = [super init];

    if (self)
    {
        self.handle = new lsf::TransitionEffect();
    }

    return self;
}

-(id)initWithLampState: (LSFLampState *)lampState
{
    self = [super init];

    if (self)
    {
        self.handle = new lsf::TransitionEffect(*static_cast<lsf::LampState*>(lampState.handle));
    }

    return self;
}

-(id)initWithLampState: (LSFLampState *)lampState transitionPeriod: (unsigned int)transitionPeriod
{
    self = [super init];

    if (self)
    {
        self.handle = new lsf::TransitionEffect(*static_cast<lsf::LampState*>(lampState.handle), transitionPeriod);
    }

    return self;
}

-(id)initWithPresetID: (NSString *)presetID
{
    self = [super init];

    if (self)
    {
        std::string pid([presetID UTF8String]);
        self.handle = new lsf::TransitionEffect(pid);
    }

    return self;
}

-(id)initWithPresetID: (NSString *)presetID transitionPeriod: (unsigned int)transitionPeriod
{
    self = [super init];

    if (self)
    {
        std::string pid([presetID UTF8String]);
        self.handle = new lsf::TransitionEffect(pid, transitionPeriod);
    }

    return self;
}

-(void)setLampState: (LSFLampState *)lampState
{
    self.transitionEffect->state = *(static_cast<lsf::LampState*>(lampState.handle));
}

-(LSFLampState *)lampState
{
    LSFLampState *lampState = [[LSFLampState alloc] initWithOnOff: self.transitionEffect->state.onOff brightness: self.transitionEffect->state.brightness hue: self.transitionEffect->state.hue saturation: self.transitionEffect->state.saturation colorTemp: self.transitionEffect->state.colorTemp];
    lampState.isNull = self.transitionEffect->state.nullState;

    return lampState;
}

-(void)setTransitionPeriod: (unsigned int)transitionPeriod
{
    self.transitionEffect->transitionPeriod = transitionPeriod;
}

-(unsigned int)transitionPeriod
{
    return self.transitionEffect->transitionPeriod;
}

-(void)setPresetID: (NSString *)presetID
{
    std::string pid([presetID UTF8String]);
    self.transitionEffect->presetID = pid;
}

-(NSString *)presetID
{
    return [NSString stringWithUTF8String: (self.transitionEffect->presetID).c_str()];
}

-(void)setInvalidArgs: (BOOL)invalidArgs
{
    self.transitionEffect->invalidArgs = invalidArgs;
}

-(BOOL)invalidArgs
{
    return self.transitionEffect->invalidArgs;
}

/*
 * Accessor for the internal C++ API object this objective-c class encapsulates
 */
-(lsf::TransitionEffect *)transitionEffect
{
    return static_cast<lsf::TransitionEffect*>(self.handle);
}

@end

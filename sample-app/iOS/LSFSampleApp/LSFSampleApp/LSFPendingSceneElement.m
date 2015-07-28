/******************************************************************************
 * Copyright AllSeen Alliance. All rights reserved.
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

#import "LSFPendingSceneElement.h"
#import <LSFSDKLightingDirector.h>

@implementation LSFPendingSceneElement

@synthesize members = _members;
@synthesize effect = _effect;
@synthesize capability = _capability;
@synthesize hasEffect = _hasEffect;

-(id)init
{
    self = [super init];

    if (self)
    {
        _members = nil;
        _effect = nil;
        _capability = nil;
        _hasEffect = NO;
    }

    return self;
}

-(id)initFromSceneElementID: (NSString *)sceneElementID
{
    self = [self init];

    LSFSDKSceneElement *element = [[LSFSDKLightingDirector getLightingDirector] getSceneElementWithID: sceneElementID];

    self.theID = element.theID;
    self.name = element.name;
    self.effect = [element getEffect];

    self.members = [NSMutableArray arrayWithArray: [element getGroups]];
    [self.members addObjectsFromArray: [element getLamps]];

    self.capability = [[LSFSDKCapabilityData alloc] init];

    for (LSFSDKGroupMember *member in self.members)
    {
        [self.capability includeData: [member getCapabilities]];

        if ([member isKindOfClass: [LSFSDKLamp class]])
        {
            self.hasEffect = self.hasEffect || ((LSFSDKLamp *)member).details.hasEffects;
        }
        else if ([member isKindOfClass: [LSFSDKGroup class]])
        {
            for (LSFSDKLamp *lamp in [((LSFSDKGroup *) member) getLamps])
            {
                self.hasEffect = self.hasEffect || lamp.details.hasEffects;
            }
        }
    }

    return self;
}

@end
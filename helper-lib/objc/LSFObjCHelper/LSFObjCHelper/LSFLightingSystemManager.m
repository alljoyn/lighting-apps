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

#import "LSFLightingSystemManager.h"
#import "LSFAllJoynManager.h"
#import "LSFControllerAdapter.h"

@interface LSFLightingSystemManager()

//@property (nonatomic, strong) LSFLampCollectionManager *lampCollectionManager;
//@property (nonatomic, strong) LSFGroupCollectionManager *groupCollectionManager
//@property (nonatomic, strong) LSFPresetCollectionManager *presetCollectionManager;
//@property (nonatomic, strong) LSFSceneCollectionManager *sceneCollectionManager;
//@property (nonatomic, strong) LSFMasterSceneCollectionManager *masterSceneCollectionManager;
@property (nonatomic, strong) LSFControllerManager *controllerManager;

@end

@implementation LSFLightingSystemManager

@synthesize DEFAULT_LANGUAGE = _DEFAULT_LANGUAGE;
@synthesize controllerManager = _controllerManager;

+(LSFLightingSystemManager *)getLightingSystemManager
{
    static LSFLightingSystemManager *director = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        director = [[self alloc] init];
    });

    return director;
}

-(id)init
{
    self = [super init];

    if (self)
    {
        self.DEFAULT_LANGUAGE = @"en";
        self.controllerManager = [[LSFControllerManager alloc] init];

        //TODO - initialize private properties
    }

    return self;
}

-(void)start
{
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    [ajManager start];
}

-(void)stop
{
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    [ajManager stop];
}

//-(LSFLampCollectionManager *)getLampCollectionManager;
//-(LSFGroupCollectionManager *)getGroupCollectionManager;
//-(LSFPresetCollectionManager *)getPresetCollectionManager;
//-(LSFSceneCollectionManager *)getSceneCollectionManager;
//-(LSFMasterSceneCollectionManager *)getMasterSceneCollectionManager;

-(LSFControllerManager *)getControllerManager
{
    return self.controllerManager;
}

-(LSFLampManager *)getLampManager
{
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    return ajManager.lsfLampManager;
}

-(LSFLampGroupManager *)getGroupManager
{
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    return ajManager.lsfLampGroupManager;
}

-(LSFPresetManager *)getPresetManager
{
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    return ajManager.lsfPresetManager;
}

-(LSFSceneManager *)getSceneManager
{
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    return ajManager.lsfSceneManager;
}

-(LSFMasterSceneManager *)getMasterSceneManager
{
    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    return ajManager.lsfMasterSceneManager;
}

-(void)postOnNextControllerConnection: (id<LSFNextControllerConnectionDelegate>)delegate
{
    LSFControllerAdapter *controllerAdapter = [[LSFControllerAdapter alloc] init];
    controllerAdapter.delegate = delegate;

    LSFControllerManager *controllerManager = [self getControllerManager];
    [controllerManager addDelegate: controllerAdapter];
}

@end

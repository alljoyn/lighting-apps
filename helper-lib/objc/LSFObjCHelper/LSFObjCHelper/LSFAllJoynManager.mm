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

#import "LSFAllJoynManager.h"
#import "LSFSampleLampGroupManager.h"
#import "LSFDispatchQueue.h"
#import "BusAttachment.h"
#import "PasswordManager.h"
#import "Init.h"

@interface LSFAllJoynManager() {
    BusAttachment *busAttachment;
}

@property (nonatomic, strong) dispatch_queue_t backgroundQueue;
@property (nonatomic, strong) NSMutableDictionary *lampsAnnouncementData;

@end

@implementation LSFAllJoynManager

@synthesize director = _director;
@synthesize bus = _bus;
@synthesize lsfControllerClient = _lsfControllerClient;
@synthesize lsfControllerServiceManager = _lsfControllerServiceManager;
@synthesize lsfLampManager = _lsfLampManager;
@synthesize lsfPresetManager = _lsfPresetManager;
@synthesize lsfLampGroupManager = _lsfLampGroupManager;
@synthesize lsfSceneManager = _lsfSceneManager;
@synthesize lsfMasterSceneManager = _lsfMasterSceneManager;
@synthesize lsfTransitionEffectManager = _lsfTransitionEffectManager;
@synthesize lsfPulseEffectManager = _lsfPulseEffectManager;
@synthesize isConnectedToController = _isConnectedToController;
@synthesize sccc = _sccc;
@synthesize scsmc = _scsmc;
@synthesize slmc = _slmc;
@synthesize spmc = _spmc;
@synthesize slgmc = _slgmc;
@synthesize ssmc = _ssmc;
@synthesize smsmc = _smsmc;
@synthesize temc = _temc;
@synthesize pemc = _pemc;
@synthesize backgroundQueue = _backgroundQueue;
@synthesize aboutManager = _aboutManager;
@synthesize lampsAnnouncementData = _lampsAnnouncementData;

+(LSFAllJoynManager *)getAllJoynManager
{
    static LSFAllJoynManager *ajManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        ajManager = [[self alloc] init];
    });
    
    return ajManager;
}

-(id)init
{
    self = [super init];
    
    if (self)
    {
        //NSLog(@"LSFAllJoynManager - init() function executing");
        
        self.isConnectedToController = NO;
        
        //Create dispatch queue and callback objects
        self.backgroundQueue = ([LSFDispatchQueue getDispatchQueue]).queue;
        self.sccc = [[LSFHelperControllerClientCallback alloc] init];
        self.scsmc = [[LSFHelperControllerServiceManagerCallback alloc] init];
        self.slmc = [[LSFHelperLampManagerCallback alloc] init];
        self.slgmc = [[LSFHelperLampGroupManagerCallback alloc] init];
        self.spmc = [[LSFHelperPresetManagerCallback alloc] init];
        self.ssmc = [[LSFHelperSceneManagerCallback alloc] init];
        self.smsmc = [[LSFHelperMasterSceneManagerCallback alloc] init];
        self.temc = [[LSFHelperTransitionEffectManagerCallback alloc] init];
        self.pemc = [[LSFHelperPulseEffectManagerCallback alloc] init];

        QStatus status;
        if ((status = AllJoynInit()) == ER_OK)
        {
            if ((status = AllJoynRouterInit()) == ER_OK)
            {
                NSLog(@"LSFAllJoynManager - Successfully initialized AllJoyn core and AllJoyn Router");
            }
            else
            {
                NSLog(@"LSFAllJoynManager - AllJoynRouterInit returned bad status code %@", [NSString stringWithUTF8String: QCC_StatusText(status)]);
            }
        }
        else
        {
            NSLog(@"LSFAllJoynManager - AllJoynInit returned bad status code %@", [NSString stringWithUTF8String: QCC_StatusText(status)]);
        }
        
        //Create Bus
        status = ER_OK;
        busAttachment = new BusAttachment("LSFSampleController", true);
        
        //Create password for Bundled Router
//        status = PasswordManager::SetCredentials("ALLJOYN_PIN_KEYX", "ALLJOYN_PIN_KEYX");
//        if (status != ER_OK)
//        {
//            NSLog(@"ERROR: Failed to set Password Manager Credentials");
//        }

        //Start the bus
        status = busAttachment->Start();
        if (status != ER_OK)
        {
            NSLog(@"ERROR: Failed to start bus. %@", [NSString stringWithUTF8String: QCC_StatusText(status)]);
        }
        
        //Connect the bus
        status = busAttachment->Connect();
        if (status != ER_OK)
        {
            NSLog(@"ERROR: Failed to connect bus. %@", [NSString stringWithUTF8String: QCC_StatusText(status)]);
        }
        
//        status = [self.bus requestWellKnownName: @"org.alljoyn.BusNode" withFlags: kAJNBusNameFlagDoNotQueue];
//        if (status != ER_OK)
//        {
//            NSLog(@"ERROR: Failed to get well-known name for bundled router");
//        }
//        
//        status = [self.bus advertiseName: @"quiet@org.alljoyn.BusNode" withTransportMask: kAJNTransportMaskAny];
//        if (status != ER_OK)
//        {
//            NSLog(@"ERROR: Failed to advertise well-known name for bundled router");
//        }
        
        self.lsfControllerClient = [[LSFControllerClient alloc] initWithBusAttachment: busAttachment andControllerClientCallbackDelegate: self.sccc];
        self.lsfControllerServiceManager = [[LSFControllerServiceManager alloc] initWithControllerClient: self.lsfControllerClient andControllerServiceManagerCallbackDelegate: self.scsmc];
        self.lsfLampManager = [[LSFLampManager alloc] initWithControllerClient: self.lsfControllerClient andLampManagerCallbackDelegate: self.slmc];
        self.lsfLampGroupManager = [[LSFSampleLampGroupManager alloc] initWithControllerClient: self.lsfControllerClient andLampManagerCallbackDelegate: self.slgmc];
        self.lsfPresetManager = [[LSFPresetManager alloc] initWithControllerClient: self.lsfControllerClient andPresetManagerCallbackDelegate: self.spmc];
        self.lsfSceneManager = [[LSFSceneManager alloc] initWithControllerClient: self.lsfControllerClient andSceneManagerCallbackDelegate: self.ssmc];
        self.lsfMasterSceneManager = [[LSFMasterSceneManager alloc] initWithControllerClient: self.lsfControllerClient andMasterSceneManagerCallbackDelegate: self.smsmc];
        self.lsfTransitionEffectManager = [[LSFTransitionEffectManager alloc] initWithControllerClient: self.lsfControllerClient andTransitionEffectManagerCallbackDelegate: self.temc];
        self.lsfPulseEffectManager = [[LSFPulseEffectManager alloc] initWithControllerClient: self.lsfControllerClient andPulseEffectManagerCallbackDelegate: self.pemc];
        self.aboutManager = [[LSFAboutManager alloc] initWithBusAttachment: busAttachment];
        self.lampsAnnouncementData = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)dealloc
{
    QStatus status;
    if ((status = AllJoynRouterShutdown()) == ER_OK)
    {
        if ((status = AllJoynShutdown()) == ER_OK)
        {
            NSLog(@"LSFAllJoynManager - dealloc(). Successfully shutdown AllJoyn core and AllJoyn Router");
        }
        else
        {
            NSLog(@"LSFAllJoynManager - dealloc(). AllJoynShutdown returned bad status code %@", [NSString stringWithUTF8String: QCC_StatusText(status)]);
        }
    }
    else
    {
        NSLog(@"LSFAllJoynManager - dealloc(). AllJoynRouterShutdown returned bad status code %@", [NSString stringWithUTF8String: QCC_StatusText(status)]);
    }
}

-(void)start
{
    ControllerClientStatus status = [self.lsfControllerClient start];

    if (status == CONTROLLER_CLIENT_ERR_RETRY)
    {
        NSLog(@"Controller Client start return retry. Retrying 5 seconds later");
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), ([LSFDispatchQueue getDispatchQueue]).queue, ^{
            [self start];
        });
    }
    else if (status == CONTROLLER_CLIENT_OK)
    {
        [self.aboutManager registerAnnouncementHandler];
        NSLog(@"Controller Client started successfully");
    }
}

-(void)stop
{
    [self.aboutManager unregisterAnnouncementHandler];

    ControllerClientStatus status = [self.lsfControllerClient stop];

    if (status == CONTROLLER_CLIENT_OK)
    {
        NSLog(@"Controller Client stop returned ok");
    }
    else
    {
        NSLog(@"Controller Client stop returned some type of error");
    }
}

-(void)addNewLamp: (NSString*)lampID lampAnnouncementData: (LSFLampAnnouncementData*)lampAnnData
{
    if (!self.lampsAnnouncementData[lampID])
    {
        [self.lampsAnnouncementData setObject: lampAnnData forKey: lampID];
    }
    else
    {
        [self.lampsAnnouncementData setValue: lampAnnData forKey: lampID];
    }
}

-(void)getAboutDataForLampID: (NSString*)lampID
{
    LSFLampAnnouncementData* lampAnnData = [self.lampsAnnouncementData  objectForKey: lampID];
    [self.aboutManager getAboutDataFromBusName: [lampAnnData busName] onPort: [lampAnnData port]];
}

-(ajn::BusAttachment *)bus
{
    return busAttachment;
}

@end

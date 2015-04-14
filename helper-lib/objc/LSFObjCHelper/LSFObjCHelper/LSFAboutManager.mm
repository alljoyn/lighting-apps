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

#import "LSFAboutManager.h"
#import "LSFConstants.h"
#import "AJNMessageArgument.h"
#import "LSFAboutData.h"
#import "LSFLampModelContainer.h"
#import "LSFLampModel.h"
#import "LSFAllJoynManager.h"
#import "LSFDispatchQueue.h"
#import "AJNSessionOptions.h"
#import "LSFLampAnnouncementData.h"
#import "AJNAboutObjectDescription.h"
#import "AJNAboutProxy.h"

@interface LSFAboutManager()

@property (nonatomic, strong) AJNBusAttachment *bus;

-(void)getAboutDataFrom: (NSString *)peerName onPort: (unsigned int)port;
-(void)extractAboutData: (NSMutableDictionary *)aboutData;
-(NSString *)extractNSStringFromAJNMessageArgument: (AJNMessageArgument *)msgArg;
-(NSString *)extractAppIDFromArrayOfBytes: (AJNMessageArgument *)msgArg;
-(NSString *)buildNSStringFromAJNMessageArgument: (AJNMessageArgument *)msgArg;

@end

@implementation LSFAboutManager

@synthesize bus = _bus;

-(id)initWithBusAttachment: (AJNBusAttachment *)bus
{
    self = [super init];
    
    if (self)
    {
        self.bus = bus;
        [self.bus enableConcurrentCallbacks];
        [self.bus addMatchRule: @"sessionless='t',type='error'"];
    }
    
    return self;
}

-(void)registerAnnouncementHandler
{
    NSLog(@"LSFAboutManager - registerAnnouncementHandler() executing");

    LSFConstants *constants = [LSFConstants getConstants];

    NSArray *lampInterfaces = [[NSArray alloc] initWithObjects: constants.lampStateInterfaceName, constants.lampDetailsInterfaceName, constants.lampParametersInterfaceName, constants.lampServiceInterfaceName, nil];
    NSArray *controllerInterfaces = [[NSArray alloc] initWithObjects: constants.controllerServiceInterfaceName, constants.controllerServiceLampInterfaceName, constants.controllerServiceLampGroupInterfaceName, constants.controllerServicePresetInterfaceName, constants.controllerServiceSceneInterfaceName, constants.controllerServiceMasterSceneInterfaceName, constants.configServiceInterfaceName, constants.aboutInterfaceName, nil];

    [self.bus registerAboutListener: self];
    [self.bus whoImplementsInterfaces: lampInterfaces numberOfInterfaces: [lampInterfaces count]];
    [self.bus whoImplementsInterfaces: controllerInterfaces numberOfInterfaces: [controllerInterfaces count]];
}

-(void)unregisterAnnouncementHandler
{
    NSLog(@"LSFAboutManager - unregisterAnnouncementHandler() executing");

    LSFConstants *constants = [LSFConstants getConstants];

    NSArray *lampInterfaces = [[NSArray alloc] initWithObjects: constants.lampStateInterfaceName, constants.lampDetailsInterfaceName, constants.lampParametersInterfaceName, constants.lampServiceInterfaceName, nil];
    NSArray *controllerInterfaces = [[NSArray alloc] initWithObjects: constants.controllerServiceInterfaceName, constants.controllerServiceLampInterfaceName, constants.controllerServiceLampGroupInterfaceName, constants.controllerServicePresetInterfaceName, constants.controllerServiceSceneInterfaceName, constants.controllerServiceMasterSceneInterfaceName, constants.configServiceInterfaceName, constants.aboutInterfaceName, nil];

    [self.bus registerAboutListener: self];
    [self.bus cancelWhoImplementsInterfaces: lampInterfaces numberOfInterfaces: [lampInterfaces count]];
    [self.bus cancelWhoImplementsInterfaces: controllerInterfaces numberOfInterfaces: [controllerInterfaces count]];
}

- (void)didReceiveAnnounceOnBus:(NSString *)busName withVersion:(uint16_t)version withSessionPort:(AJNSessionPort)port withObjectDescription:(AJNMessageArgument *)objectDescriptionArg withAboutDataArg:(AJNMessageArgument *)aboutDataArg
{
    NSLog(@"LSFAboutManager - didReceiveAnnounceOnBus:withVersion:withSessionPort:withOnjectDescription:withAboutDataArg: executing()");

    LSFConstants *constants = [LSFConstants getConstants];
    AJNAboutObjectDescription *aboutObjectDescription = [[AJNAboutObjectDescription alloc] initWithMsgArg: objectDescriptionArg];

    size_t numLampInterfaces = [aboutObjectDescription getInterfacesForPath: constants.lampServiceObjectDescription interfaces: nil numOfInterfaces: 0];
    NSMutableArray *lampInterfaces = [[NSMutableArray alloc] initWithCapacity:numLampInterfaces];
    [aboutObjectDescription getInterfacesForPath: constants.lampServiceObjectDescription interfaces: &lampInterfaces numOfInterfaces: numLampInterfaces];

    size_t numControllerInterfaces = [aboutObjectDescription getInterfacesForPath: constants.controllerServiceObjectDescription interfaces: nil numOfInterfaces: 0];
    NSMutableArray *controllerInterfaces = [[NSMutableArray alloc] initWithCapacity:numControllerInterfaces];
    [aboutObjectDescription getInterfacesForPath: constants.controllerServiceObjectDescription interfaces: &controllerInterfaces numOfInterfaces: numControllerInterfaces];

    NSSet *lis = [NSSet setWithArray: lampInterfaces];
    NSSet *cis = [NSSet setWithArray: controllerInterfaces];
    NSSet *lampInterfacesSet = [NSSet setWithArray: [NSArray arrayWithObjects: constants.lampServiceInterfaceName, constants.lampStateInterfaceName, constants.lampDetailsInterfaceName, constants.lampParametersInterfaceName, nil]];
    NSSet *controllerInterfacesSet = [NSSet setWithArray: [NSArray arrayWithObjects: constants.controllerServiceInterfaceName, constants.controllerServiceLampInterfaceName, constants.controllerServiceLampGroupInterfaceName, constants.controllerServicePresetInterfaceName, constants.controllerServiceSceneInterfaceName, constants.controllerServiceMasterSceneInterfaceName, nil]];

    if ([lis isEqualToSet: lampInterfacesSet])
    {
        NSLog(@"Received lamp announcement");

        MsgArg *entries;
        size_t numFields;
        MsgArg *arg = static_cast<MsgArg*>(aboutDataArg.handle);

        arg->Get("a{sv}", &numFields, &entries);

        char *key;
        MsgArg *value;
        NSString *lampID;
        for (size_t i = 0; i < numFields; ++i)
        {
            entries[i].Get("{sv}", &key, &value);

            if (strcmp(key, "DeviceId") == 0)
            {
                NSLog(@"Found Device ID");
                char *deviceID;
                value->Get("s", &deviceID);

                lampID = [NSString stringWithUTF8String: deviceID];
                NSLog(@"LampID = %@", lampID);
                break;
            }
        }

        LSFLampAnnouncementData *lampAnnData = [[LSFLampAnnouncementData alloc] initPort: port busName: busName];

        dispatch_async(dispatch_queue_create("GetAboutData", NULL), ^{
            //[self getAboutDataFrom: busName onPort: port usingAboutData: *aboutData];
            [[LSFAllJoynManager getAllJoynManager] addNewLamp: lampID lampAnnouncementData: lampAnnData];
        });
    }
    else if ([cis isEqualToSet: controllerInterfacesSet])
    {
        NSLog(@"Received controller announcement");
    }
    else
    {
        NSLog(@"Supported interfaces do not match lamps or controller");
    }
}

-(void)getAboutDataFromBusName: (NSString *)busName onPort: (unsigned int)port
{
    [self getAboutDataFrom:busName onPort:port];
}

/*
 * Private Functions
 */
-(void)getAboutDataFrom: (NSString *)peerName onPort: (unsigned int)port
{
    LSFConstants *constants = [LSFConstants getConstants];
    AJNSessionOptions *opt = [[AJNSessionOptions alloc] initWithTrafficType: kAJNTrafficMessages supportsMultipoint: false proximity: kAJNProximityAny transportMask: kAJNTransportMaskAny];
    AJNSessionId sessionID = [self.bus joinSessionWithName: peerName onPort: port withDelegate: nil options: opt];

    if (sessionID == 0 || sessionID == -1)
    {
        NSLog(@"Failed to join session with lamp (%@). SID = %u", peerName, sessionID);
    }
    else
    {
        NSLog(@"Session ID = %u", sessionID);

        NSMutableDictionary *fullAboutData = [[NSMutableDictionary alloc] init];
        AJNAboutProxy *aboutProxy = [[AJNAboutProxy alloc] initWithBusAttachment: self.bus busName: peerName sessionId: sessionID];

        QStatus status = ER_OK;
        for (int i = 0; i < 5; i++)
        {
            status = [aboutProxy getAboutDataForLanguage: constants.defaultLanguage usingDictionary: &fullAboutData];

            if (status != ER_OK)
            {
                NSLog(@"Failed attempt (%i) to get about data from lamp (%@). Retrying.", i, peerName);
            }
            else
            {
                NSLog(@"Breaking on attempt %i", i);
                break;
            }
        }

        if (status != ER_OK)
        {
            NSLog(@"Failed 5 attempts to get about data from lamp (%@).", peerName);
        }
        else
        {
            [self extractAboutData: fullAboutData];
        }

        fullAboutData = nil;
        aboutProxy = nil;
    }

    //Need to make sure I leave the session to ensure the sample app fully disconnects from the lamp
    QStatus status = [self.bus leaveSession: sessionID];
    if (status != ER_OK)
    {
        NSLog(@"Failed to leave session %u with %@", sessionID, peerName);
    }
    else
    {
        NSLog(@"Successfully left session %u with %@", sessionID, peerName);
    }

    //Clean up objects
    opt = nil;
    sessionID = nil;
}

-(void)extractAboutData: (NSMutableDictionary *)aboutData
{
    LSFAboutData *myAboutData = [[LSFAboutData alloc] init];

    //Extract AppId
    AJNMessageArgument *msgArg = [aboutData valueForKey: @"AppId"];
    myAboutData.appID = [self extractAppIDFromArrayOfBytes: msgArg];

    //Extract DefaultLanguage
    msgArg = [aboutData valueForKey: @"DefaultLanguage"];
    myAboutData.defaultLanguage = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract DeviceName
    msgArg = [aboutData valueForKey: @"DeviceName"];
    myAboutData.deviceName = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract DeviceID
    msgArg = [aboutData valueForKey: @"DeviceId"];
    myAboutData.deviceID = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract AppName
    msgArg = [aboutData valueForKey: @"AppName"];
    myAboutData.appName = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract Manufacturer
    msgArg = [aboutData valueForKey: @"Manufacturer"];
    myAboutData.manufacturer = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract ModelNumber
    msgArg = [aboutData valueForKey: @"ModelNumber"];
    myAboutData.modelNumber = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract SupportedLanguages
    msgArg = [aboutData valueForKey: @"SupportedLanguages"];
    myAboutData.supportedLanguages = [self buildNSStringFromAJNMessageArgument: msgArg];

    //Extract Description
    msgArg = [aboutData valueForKey: @"Description"];
    myAboutData.description = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract DateOfManufacture
    msgArg = [aboutData valueForKey: @"DateOfManufacture"];
    myAboutData.dateOfManufacture = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract SoftwareVersion
    msgArg = [aboutData valueForKey: @"SoftwareVersion"];
    myAboutData.softwareVersion = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract AJSoftwareVersion
    msgArg = [aboutData valueForKey: @"AJSoftwareVersion"];
    myAboutData.ajSoftwareVersion = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract HardwareVersion
    msgArg = [aboutData valueForKey: @"HardwareVersion"];
    myAboutData.hardwareVersion = [self extractNSStringFromAJNMessageArgument: msgArg];

    //Extract SupportUrl
    msgArg = [aboutData valueForKey: @"SupportUrl"];
    myAboutData.supportURL = [self extractNSStringFromAJNMessageArgument: msgArg];

    LSFAllJoynManager *ajManager = [LSFAllJoynManager getAllJoynManager];
    [ajManager.slmc postUpdateLampID: myAboutData.deviceID withAboutData: myAboutData];
}

-(NSString *)extractNSStringFromAJNMessageArgument: (AJNMessageArgument *)msgArg
{
    QStatus status;
    const char* msgArgContent;
    status = [msgArg value: @"s", &msgArgContent];
    return [NSString stringWithUTF8String: msgArgContent];
}

-(NSString *)extractAppIDFromArrayOfBytes: (AJNMessageArgument *)msgArg
{
    QStatus status;
    NSMutableData *ajnMsgArgData;
    uint8_t *AppIdBuffer;
    size_t numElements;
    status = [msgArg value:@"ay", &numElements, &AppIdBuffer];
    ajnMsgArgData = [NSMutableData dataWithBytes:AppIdBuffer length:(NSInteger)numElements];
    return [[ajnMsgArgData description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
}

-(NSString *)buildNSStringFromAJNMessageArgument: (AJNMessageArgument *)msgArg
{
    NSMutableString *supportedLanguages = [[NSMutableString alloc] initWithString: @""];

    QStatus status;
    MsgArg *argsArray;
    size_t numElements;
    status = [msgArg value:@"as", &numElements, &argsArray];
    for (size_t i = 0; i < numElements; i++)
    {
        char* suppLang;
        argsArray[i].Get("s", &suppLang);

        NSString *supportedLanguage = [NSString stringWithUTF8String: suppLang];

        if (i == (numElements - 1))
        {
            [supportedLanguages appendFormat: @"%@", supportedLanguage];
        }
        else
        {
            [supportedLanguages appendFormat: @"%@, ", supportedLanguage];
        }
    }

    NSLog(@"Final Supported Languages = %@", supportedLanguages);

    return [NSString stringWithString: supportedLanguages];
}

@end

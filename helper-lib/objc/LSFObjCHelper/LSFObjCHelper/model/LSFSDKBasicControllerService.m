/******************************************************************************
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 ******************************************************************************/

#import "LSFSDKBasicControllerService.h"

@implementation LSFSDKBasicControllerService

@synthesize controllerConfiguration = _controllerConfiguration;

-(id)initWithControllerConfiguration: (id<LSFSDKLightingControllerConfiguration>)configuration
{
    self = [super init];

    if (self)
    {
        _controllerConfiguration = configuration;

        //initialize self as callback in LSFController
        [self initializeWithControllerServiceDelegate: self];
    }

    return self;
}

-(NSString *)getControllerDefaultDeviceID: (NSString *) generatedDeviceID
{
    return generatedDeviceID;
}

-(unsigned long long)getMacAddressAsDecimal: (NSString *)generatedMacAddress
{
    NSString *macAddr = [_controllerConfiguration getMacAddress: generatedMacAddress];
    NSScanner *scanner = [NSScanner scannerWithString: macAddr];

    unsigned long long macAddressLongLong;
    [scanner scanHexLongLong: &macAddressLongLong];

    return macAddressLongLong;
}

-(BOOL)isNetworkConnected
{
    return [_controllerConfiguration isNetworkConnected];
}

-(OEM_CS_RankParam_Mobility)getControllerRankMobility
{
    return [_controllerConfiguration getRankMobility];
}

-(OEM_CS_RankParam_Power)getControllerRankPower
{
    return [_controllerConfiguration getRankPower];
}

-(OEM_CS_RankParam_Availability)getControllerRankAvailability
{
    return [_controllerConfiguration getRankAvailability];
}

-(OEM_CS_RankParam_NodeType)getControllerRankNodeType
{
    return [_controllerConfiguration getRankNodeType];
}

-(void)populateDefaultProperties:(LSFSDKAboutData *)aboutData
{
    return [_controllerConfiguration populateDefaultProperties: aboutData];
}

@end
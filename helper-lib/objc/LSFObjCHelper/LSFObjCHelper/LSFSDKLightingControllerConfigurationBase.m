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

#import "LSFSDKLightingControllerConfigurationBase.h"
#import "AboutKeys.h"

@implementation LSFSDKLightingControllerConfigurationBase

-(id)initWithKeystorePath: (NSString *)keystorePath
{
    self = [super init];

    if (self)
    {
        keystoreFilePath = keystorePath;
    }

    return self;
}

-(NSString *)getKeystorePath
{
    return keystoreFilePath;
}

-(NSString *)getMacAddress: (NSString *)generatedMacAddress
{
    return generatedMacAddress;
}

-(BOOL)isNetworkConnected
{
    return YES;
}

-(OEM_CS_RankParam_Mobility)getRankMobility
{
    return HIGH_MOBILITY;
}

-(OEM_CS_RankParam_Power)getRankPower
{
    return BATTERY_POWERED_CHARGABLE;
}

-(OEM_CS_RankParam_Availability)getRankAvailability
{
    return SIX_TO_NINE_HOURS;
}

-(OEM_CS_RankParam_NodeType)getRankNodeType
{
    return WIRELESS;
}

-(void)populateDefaultProperties:(LSFAboutData *)aboutData
{
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::DATE_OF_MANUFACTURE] withStringValue: @"10/1/2199"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::DEFAULT_LANGUAGE] withStringValue: @"en"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::HARDWARE_VERSION] withStringValue: @"355.499. b"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::MODEL_NUMBER] withStringValue: @"100"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::SOFTWARE_VERSION] withStringValue: @"1"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::SUPPORT_URL] withStringValue: @"http://www.company_a.com"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::SUPPORTED_LANGUAGES] withStringArrayValue: [NSArray arrayWithObjects: @"en", @"de-AT", nil]];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::APP_NAME] withStringValue: @"LightingControllerService" andLanguage: @"en"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::APP_NAME] withStringValue: @"LightingControllerService" andLanguage: @"de-AT"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::DESCRIPTION] withStringValue: @"Controller Service" andLanguage: @"en"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::DESCRIPTION] withStringValue: @"Controller Service" andLanguage: @"de-AT"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::DEVICE_NAME] withStringValue: @"LightingController" andLanguage: @"en"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::DEVICE_NAME] withStringValue: @"LightingController" andLanguage: @"de-AT"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::MANUFACTURER] withStringValue: @"Company A (EN)" andLanguage: @"en"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::MANUFACTURER] withStringValue: @"Firma A (DE-AT)" andLanguage: @"de-AT"];
    [aboutData putKey: [NSString stringWithUTF8String: AboutKeys::APP_ID] witDataValue: [self generateRandomAppID]];
}

-(NSString *) generateRandomHexStringWithLength: (int) len
{
    NSString *digits = @"0123456789ABCDEF";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];

    for (int i = 0; i < len; i++)
    {
        unichar c = [digits characterAtIndex: (arc4random() % [digits length])];
        [randomString appendFormat: @"%C", c];
    }

    return randomString;
}

-(NSData *) generateRandomAppID
{
    NSMutableData *data = [[NSMutableData alloc] init];
    int numBytes = 16;
    for (int i = 0; i < (numBytes / sizeof(u_int32_t)); i++)
    {
        u_int32_t randomBits = arc4random();
        [data appendBytes: (void *)&randomBits length: 4];
    }

    return data;
}

@end

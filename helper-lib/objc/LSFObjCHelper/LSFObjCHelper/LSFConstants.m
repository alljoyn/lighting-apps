/******************************************************************************
 * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE."];
        [self.NOTICE_TEXT addAttribute: NSFontAttributeName value: [UIFont fontWithName: @"Helvetica Neue" size: 18.0f] range: NSMakeRange(0, self.NOTICE_TEXT.length)];

        self.MIN_BRIGHTNESS = 0.0;
        self.MAX_BRIGHTNESS = 100.0;
        self.MIN_HUE = 0.0;
        self.MAX_HUE = 360.0;
        self.MIN_SATURATION = 0.0;
        self.MAX_SATURATION = 100.0;
        self.MIN_COLOR_TEMP = 1000.0;
        self.MAX_COLOR_TEMP = 20000.0;
    }
    
    return self;
}

-(unsigned int)scaleLampStateValue: (unsigned int)value withMax: (unsigned int)max
{
    return round((double)value * 4294967295.0 / (double)max);
}

-(unsigned int)unscaleLampStateValue: (unsigned int)value withMax: (unsigned int)max
{
    return round((double)value * (double)max / 4294967295.0);
}

-(unsigned int)scaleColorTemp: (unsigned int)value
{
    unsigned int scaledColorTemp = round(4294967295.0 * (((double)value - self.MIN_COLOR_TEMP) / (self.MAX_COLOR_TEMP - self.MIN_COLOR_TEMP)));
    return scaledColorTemp;
}

-(unsigned int)unscaleColorTemp: (unsigned int)value
{
    unsigned int unscaledColorTemp = round(self.MIN_COLOR_TEMP * (1 - ((double)value / 4294967295.0)) + (self.MAX_COLOR_TEMP * ((double)value / 4294967295.0)));
    return unscaledColorTemp;
}

-(NSString *)currentWifiSSID
{
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    
    for (NSString *ifnam in ifs)
    {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"])
        {
            ssid = info[@"SSID"];
            //NSLog(@"SSID = %@", ssid);
        }
    }
    
    return ssid;
}

@end
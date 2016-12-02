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

#import "LSFSDKColorItem.h"

@implementation LSFSDKColorItem

-(NSArray *)getColorHsvt
{
    return [NSArray arrayWithObjects: [NSNumber numberWithUnsignedInt: [[[self getColorDataModel] state] hue]], [NSNumber numberWithUnsignedInt: [[[self getColorDataModel] state] saturation]], [NSNumber numberWithUnsignedInt: [[[self getColorDataModel] state] brightness]], [NSNumber numberWithUnsignedInt: [[[self getColorDataModel] state] colorTemp]], nil];
}

-(BOOL)getPowerOn
{
    return [[[self getColorDataModel] state] onOff];
}

-(BOOL)isOn
{
    return [self getPowerOn];
}

-(BOOL)isOff
{
    return ![self isOn];
}

-(Power)getPower
{
    return (([self getPowerOn]) ? ON : OFF);
}

-(LSFSDKColor *)getColor
{
    return [[LSFSDKColor alloc] initWithHsvt: [self getColorHsvt]];
}

-(LSFSDKMyLampState *)getState
{
    return [[LSFSDKMyLampState alloc] initWithPower: [self getPower] color: [self getColor]];
}

-(LSFSDKLampStateUniformity *)getUniformity
{
    return [[LSFSDKLampStateUniformity alloc] initWithLampStateUniformity: [[self getColorDataModel] uniformity]];
}

-(LSFSDKCapabilityData *)getCapabilities
{
    return [[LSFSDKCapabilityData alloc] initWithCapabilityData: [[self getColorDataModel] capability]];
}

-(void)setCapabilities: (LSFSDKCapabilityData *)capabilityData
{
    [self getColorDataModel].capability = capabilityData;
}

-(LSFDataModel *)getColorDataModel;
{
    @throw [NSException exceptionWithName: NSInternalInconsistencyException reason: [NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo: nil];
}

/*
 * Overriden functions from base class
 */
-(LSFModel *)getItemDataModel
{
    return [self getColorDataModel];
}

@end
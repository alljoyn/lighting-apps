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

#import "LSFPendingItem.h"
#import "LSFPendingEffect.h"
#import <LSFSDKCapabilityData.h>

@interface LSFPendingSceneElement : LSFPendingItem

-(id)initFromSceneElementID: (NSString *)sceneElementID;

@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, strong) LSFPendingEffect *pendingEffect;
@property (nonatomic, strong) LSFSDKCapabilityData *capability;
@property (nonatomic) BOOL hasEffect;

@end
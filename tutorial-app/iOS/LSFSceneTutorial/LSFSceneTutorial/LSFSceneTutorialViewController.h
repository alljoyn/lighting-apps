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

#import <UIKit/UIKit.h>
#import "LSFSDKNextControllerConnectionDelegate.h"

/*
 * Tutorial illustrating how to create a Scene consisting of a PulseEffect and apply it using a
 * global delegate. This tutorial assumes that there exists at least one Lamp and one Controller
 * on the network.
 */
@interface LSFSceneTutorialViewController : UIViewController <LSFSDKNextControllerConnectionDelegate>

@property (nonatomic, weak) IBOutlet UILabel *versionLabel;

@end

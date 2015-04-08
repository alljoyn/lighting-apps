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
 *     PERFORMANCE OF THIS SOFTWARE.
 ******************************************************************************/

#import <Foundation/Foundation.h>
#import "LSFLightingItem.h"
#import "LSFSceneDataModel.h"

/**
 * An LSFLightingScene object represents a set of lamps and associated states in the lighting system, and can be
 * used to apply the states to the lamps.
 */
@interface LSFLightingScene : LSFLightingItem

/** @name Creating LSFLightingScene */

/**
 * Constructs an instance of the LSFLightingScene class.
 *
 * @param sceneID The ID of the Scene.
 *
 * @return Instance of LSFLightingScene.
 *
 * @warning *Note:* This method is intended to be used internally. Client software should not instantiate
 * Groups directly, but should instead get them from the LSFLightingDirector using the [LSFLightingDirector getScenes]
 * method.
 */
-(id)initWithSceneID: (NSString *)sceneID;

/** @name LSFLightingScene Controls */

/**
 * Sends a command to apply this Scene, which sets the appropriate state for all
 * constituent lamps.
 */
-(void)apply;

/*
 * Note: This method is not intended to be used by clients, and may change or be
 * removed in subsequent releases of the SDK.
 */
-(LSFSceneDataModel *)getSceneDataModel;

@end
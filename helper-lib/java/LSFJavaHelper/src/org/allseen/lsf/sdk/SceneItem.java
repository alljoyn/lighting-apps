/* /* 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 */
package org.allseen.lsf.sdk;

/**
 * Abstract base class for Lighting Items that can be applied in a Scene and also deleted.
 */
public abstract class SceneItem extends LightingItem implements DeletableItem {

    /**
     * Apply the current SceneItem.
     */
    public abstract void apply();
}
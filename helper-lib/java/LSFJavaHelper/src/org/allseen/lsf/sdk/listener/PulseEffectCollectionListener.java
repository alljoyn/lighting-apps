/*
 *  * 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 */
package org.allseen.lsf.sdk.listener;

import org.allseen.lsf.sdk.TrackingID;

public interface PulseEffectCollectionListener<PULSEEFFECT, ERROR> extends LightingListener {
    public void onPulseEffectInitialized(TrackingID trackingId, PULSEEFFECT effect);
    public void onPulseEffectChanged(PULSEEFFECT effect);
    public void onPulseEffectRemoved(PULSEEFFECT effect);
    public void onPulseEffectError(ERROR error);
}
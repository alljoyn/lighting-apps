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

public class PulseEffectCollectionListenerBase<PULSEEFFECT, ERROR> implements PulseEffectCollectionListener<PULSEEFFECT, ERROR> {

    @Override
    public void onPulseEffectInitialized(TrackingID trackingId, PULSEEFFECT effect)     { }

    @Override
    public void onPulseEffectChanged(PULSEEFFECT effect)                                { }

    @Override
    public void onPulseEffectRemoved(PULSEEFFECT effect)                                { }

    @Override
    public void onPulseEffectError(ERROR error)                                         { }

}
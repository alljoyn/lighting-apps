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

public class TransitionEffectCollectionListenerBase<TRANSITIONEFFECT, ERROR> implements TransitionEffectCollectionListener<TRANSITIONEFFECT, ERROR> {

    @Override
    public void onTransitionEffectInitialized(TrackingID trackingId, TRANSITIONEFFECT effect)   { }

    @Override
    public void onTransitionEffectChanged(TRANSITIONEFFECT effect)                              { }

    @Override
    public void onTransitionEffectRemoved(TRANSITIONEFFECT effect)                              { }

    @Override
    public void onTransitionEffectError(ERROR error)                                            { }

}
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
package org.allseen.lsf;

import org.allseen.lsf.sdk.ControllerClientStatus;
import org.allseen.lsf.sdk.TrackingID;

public class TransitionEffectManager extends BaseNativeClassWrapper {
    public static final int MAX_TRANSITION_EFFECTS = 100;

    public TransitionEffectManager(ControllerClient controller, TransitionEffectManagerCallback callback) {
         createNativeObject(controller, callback);
    }

    public native ControllerClientStatus getAllTransitionEffectIDs();
    public native ControllerClientStatus getTransitionEffect(String transitionEffectID);
    public native ControllerClientStatus applyTransitionEffectOnLamps(String transitionEffectID, String[] lampIDs);
    public native ControllerClientStatus applyTransitionEffectOnLampGroups(String transitionEffectID, String[] lampGroupIDs);
    public native ControllerClientStatus getTransitionEffectName(String transitionEffectID, String language);
    public native ControllerClientStatus setTransitionEffectName(String transitionEffectID, String transitionEffectName, String language);
    public native ControllerClientStatus createTransitionEffect(TrackingID trackingID, TransitionEffectV2 transitionEffect, String transitionEffectName, String language);
    public native ControllerClientStatus updateTransitionEffect(String transitionEffectID, TransitionEffectV2 transitionEffect);
    public native ControllerClientStatus deleteTransitionEffect(String transitionEffectID);
    public native ControllerClientStatus getTransitionEffectDataSet(String transitionEffectID, String language);

    protected native void createNativeObject(ControllerClient controller, TransitionEffectManagerCallback callback);

    @Override
    protected native void destroyNativeObject();
}
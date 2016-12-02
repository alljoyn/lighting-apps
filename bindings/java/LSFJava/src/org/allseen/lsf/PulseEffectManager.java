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

public class PulseEffectManager extends BaseNativeClassWrapper {
    public static final int MAX_PULSE_EFFECTS = 100;

    public PulseEffectManager(ControllerClient controller, PulseEffectManagerCallback callback) {
        createNativeObject(controller, callback);
    }

    public native ControllerClientStatus getAllPulseEffectIDs();
    public native ControllerClientStatus getPulseEffect(String pulseEffectID);
    public native ControllerClientStatus applyPulseEffectOnLamps(String pulseEffectID, String[] lampIDs);
    public native ControllerClientStatus applyPulseEffectOnLampGroups(String pulseEffectID, String[] lampGroupIDs);
    public native ControllerClientStatus getPulseEffectName(String pulseEffectID, String language);
    public native ControllerClientStatus setPulseEffectName(String pulseEffectID, String pulseEffectName, String language);
    public native ControllerClientStatus createPulseEffect(TrackingID trackingID, PulseEffectV2 pulseEffect, String pulseEffectName, String language);
    public native ControllerClientStatus updatePulseEffect(String pulseEffectID, PulseEffectV2 pulseEffect);
    public native ControllerClientStatus deletePulseEffect(String pulseEffectID);
    public native ControllerClientStatus getPulseEffectDataSet(String pulseEffectID, String language);

    protected native void createNativeObject(ControllerClient controller, PulseEffectManagerCallback callback);

    @Override
    protected native void destroyNativeObject() ;
}
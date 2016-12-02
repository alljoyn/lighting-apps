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

import org.allseen.lsf.sdk.ResponseCode;

public class PulseEffectManagerCallback extends DefaultNativeClassWrapper {

    public PulseEffectManagerCallback() {
        createNativeObject();
    }

    public void getPulseEffectReplyCB(ResponseCode responseCode, String pulseEffectID, PulseEffectV2 pulseEffect)                     { }
    public void applyPulseEffectOnLampsReplyCB(ResponseCode responseCode, String pulseEffectID, String[] lampIDs)                   { }
    public void applyPulseEffectOnLampGroupsReplyCB(ResponseCode responseCode, String pulseEffectID, String[] lampGroupIDs)         { }
    public void getAllPulseEffectIDsReplyCB(ResponseCode responseCode, String[] pulseEffectIDs)                                     { }
    public void getPulseEffectNameReplyCB(ResponseCode responseCode, String pulseEffectID, String language, String pulseEffectName) { }
    public void setPulseEffectNameReplyCB(ResponseCode responseCode, String pulseEffectID, String language)                         { }
    public void pulseEffectsNameChangedCB(String[] pulseEffectIDs)                                                                  { }
    public void createPulseEffectReplyCB(ResponseCode responseCode, String pulseEffectID, long trackingID)                          { }
    public void pulseEffectsCreatedCB(String[] pulseEffectIDs)                                                                      { }
    public void updatePulseEffectReplyCB(ResponseCode responseCode, String pulseEffectID)                                           { }
    public void pulseEffectsUpdatedCB(String[] pulseEffectIDs)                                                                      { }
    public void deletePulseEffectReplyCB(ResponseCode responseCode, String pulseEffectID)                                           { }
    public void pulseEffectsDeletedCB(String[] pulseEffectIDs)                                                                      { }

    @Override
    protected native void createNativeObject();

    @Override
    protected native void destroyNativeObject();
}
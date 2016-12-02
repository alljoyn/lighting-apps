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

public class TransitionEffectManagerCallback extends DefaultNativeClassWrapper {

    public TransitionEffectManagerCallback() {
        createNativeObject();
    }

    public void getTransitionEffectReplyCB(ResponseCode responseCode, String transitionEffectID, TransitionEffectV2 transitionEffect)                 { }
    public void applyTransitionEffectOnLampsReplyCB(ResponseCode responseCode, String transitionEffectID, String[] lampIDs)                         { }
    public void applyTransitionEffectOnLampGroupsReplyCB(ResponseCode responseCode, String transitionEffectID, String[] lampGroupIDs)               { }
    public void getAllTransitionEffectIDsReplyCB(ResponseCode responseCode, String[] transitionEffectIDs)                                           { }
    public void getTransitionEffectNameReplyCB(ResponseCode responseCode, String transitionEffectID, String language, String transitionEffectName)  { }
    public void setTransitionEffectNameReplyCB(ResponseCode responseCode, String transitionEffectID, String language)                               { }
    public void transitionEffectsNameChangedCB(String[] transitionEffectIDs)                                                                        { }
    public void createTransitionEffectReplyCB(ResponseCode responseCode, String transitionEffectID, long trackingID)                                { }
    public void transitionEffectsCreatedCB(String[] transitionEffectIDs)                                                                            { }
    public void updateTransitionEffectReplyCB(ResponseCode responseCode, String transitionEffectID)                                                 { }
    public void transitionEffectsUpdatedCB(String[] transitionEffectIDs)                                                                            { }
    public void deleteTransitionEffectReplyCB(ResponseCode responseCode, String transitionEffectID)                                                 { }
    public void transitionEffectsDeletedCB(String[] transitionEffectIDs)                                                                            { }

    @Override
    protected native void createNativeObject();

    @Override
    protected native void destroyNativeObject();
}
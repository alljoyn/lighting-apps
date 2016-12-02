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
package org.allseen.lsf.sampleapp;

import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.LightingItem;
import org.allseen.lsf.sdk.LightingItemErrorEvent;
import org.allseen.lsf.sdk.TrackingID;

public class LightingListenerUtil {

    public static void listenFor(final TrackingID trackingId, final TrackingIDListener listener) {
        LightingDirector.get().addListener(new AnyLightingItemListenerBase() {

            @Override
            public void onAnyInitialized(TrackingID tid, LightingItem item) {
                if (tid != null && tid.value == trackingId.value) {
                    LightingDirector.get().removeListener(this);
                    listener.onTrackingIDReceived(tid, item);
                }
            }

            @Override
            public void onAnyError(LightingItemErrorEvent error) {
                if (error.trackingID != null && error.trackingID.value == trackingId.value) {
                    LightingDirector.get().removeListener(this);
                    listener.onTrackingIDError(error);
                }
            }
        });
    }
}
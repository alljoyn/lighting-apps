/*
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
*/
package org.allseen.lsf.tutorial.pulseeffects;

import org.allseen.lsf.sdk.AllLightingItemListenerBase;
import org.allseen.lsf.sdk.Color;
import org.allseen.lsf.sdk.Group;
import org.allseen.lsf.sdk.Lamp;
import org.allseen.lsf.sdk.LightingController;
import org.allseen.lsf.sdk.LightingControllerConfigurationBase;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.MyLampState;
import org.allseen.lsf.sdk.NextControllerConnectionListener;
import org.allseen.lsf.sdk.Power;
import org.allseen.lsf.sdk.PulseEffect;
import org.allseen.lsf.sdk.TrackingID;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

/*
 * Tutorial illustrating how to create a Group and PulseEffect, then apply the effect
 * the group. This tutorial assumes that there exists at least one Lamp and one Controller
 * on the network.
 */
public class TutorialPulseEffectActivity extends Activity implements NextControllerConnectionListener  {
    private static final int CONTROLLER_CONNECTION_DELAY = 5000;

    private LightingDirector lightingDirector;
    private TrackingID groupCreationId;
    private String tutorialGroupId;

    /*
     * Global Lighting event listener. Responsible for handling any callbacks that
     * the user is interested in acting on.
     */
    private class MyLightingListener extends AllLightingItemListenerBase {
        @Override
        public void onGroupInitialized(TrackingID trackingId, Group group) {
            // STEP 4: Use the group initialization as a trigger to create parameters
            // for a PulseEffect and create it.
            if (trackingId != null && groupCreationId != null && trackingId.value == groupCreationId.value) {
                // Save the ID of the Group; to be used later
                tutorialGroupId = group.getId();

                //Variable parameters
                Color pulseFromColor = Color.green();
                Color pulseToColor = Color.blue();
                Power pulsePowerState = Power.ON;
                long period = 1000;
                long duration = 500;
                long numPulses = 10;
                MyLampState lampFrom = new MyLampState(pulsePowerState, pulseFromColor);
                MyLampState lampTo = new MyLampState(pulsePowerState, pulseToColor);

                // boilerplate code, alter parameters above to change effect color, length, etc.
                lightingDirector.createPulseEffect(lampFrom, lampTo, period, duration, numPulses, "TutorialPulseEffect");
            }
        }

        @Override
        public void onPulseEffectInitialized(TrackingID trackingId, PulseEffect effect) {
            // STEP 5: Use the pulse effect initialization as a trigger to apply it
            // to all the lamps in the defined group.
            if (tutorialGroupId != null) {
                effect.applyTo(lightingDirector.getGroup(tutorialGroupId));
            }
        }
    }

    @Override
    protected void onCreate(Bundle savedState) {
        super.onCreate(savedState);

        setContentView(R.layout.activity_tutorial_app);

        // Display the version number
        String version = "<unknown>";
        try { version = getPackageManager().getPackageInfo(getPackageName(), 0).versionName; } catch (Exception e) {}
        ((TextView)findViewById(R.id.appTextVersion)).setText(version);

        // STEP 1: Initialize a lighting controller with default configuration.
        LightingController lightingController = LightingController.get();
        lightingController.init(new LightingControllerConfigurationBase(getApplicationContext().getFileStreamPath("").getAbsolutePath()));
        lightingController.start();

        // STEP 2: Instantiate the director and wait for the connection, register a
        // global listener to handle Lighting events
        lightingDirector = LightingDirector.get();
        lightingDirector.addListener(new MyLightingListener());
        lightingDirector.setNetworkConnectionStatus(true);
        lightingDirector.postOnNextControllerConnection(this, CONTROLLER_CONNECTION_DELAY);
        lightingDirector.start("TutorialApp");
    }

    @Override
    protected void onDestroy() {
        lightingDirector.stop();
        super.onDestroy();
    }

    @Override
    public void onControllerConnected() {
        // STEP 3: Create a Group consisting of all the connected Lamps
        Lamp[] lamps = lightingDirector.getLamps();
        groupCreationId = lightingDirector.createGroup(lamps, "TutorialGroup");
    }
}
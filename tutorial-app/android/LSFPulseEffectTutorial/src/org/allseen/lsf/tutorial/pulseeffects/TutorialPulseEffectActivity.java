/*
 * Copyright (c) AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for any
 *    purpose with or without fee is hereby granted, provided that the above
 *    copyright notice and this permission notice appear in all copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *    WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *    MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *    ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *    WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *    ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.tutorial.pulseeffects;

import org.allseen.lsf.TrackingID;
import org.allseen.lsf.sdk.AllCollectionAdapter;
import org.allseen.lsf.sdk.Color;
import org.allseen.lsf.sdk.Group;
import org.allseen.lsf.sdk.Lamp;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.MyLampState;
import org.allseen.lsf.sdk.NextControllerConnectionListener;
import org.allseen.lsf.sdk.Power;
import org.allseen.lsf.sdk.PulseEffect;

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
    private class MyLightingListener extends AllCollectionAdapter {
        @Override
        public void onGroupInitialized(TrackingID trackingId, Group group) {
            if (trackingId != null && groupCreationId != null && trackingId.value == groupCreationId.value) {
                // Save the ID of the Group; to be used later
                tutorialGroupId = group.getId();

                // STEP 3: Use the Group creation event as a trigger to create the PulseEffect
                Color pulseFromColor = Color.GREEN;
                Color pulseToColor = Color.BLUE;
                Power pulsePowerState = Power.ON;
                long period = 1000;
                long duration = 500;
                long numPulses = 10;

                // boilerplate code, alter parameters above to change effect color, length, etc.
                lightingDirector.createPulseEffect(new MyLampState(pulsePowerState, pulseFromColor),
                        new MyLampState(pulsePowerState, pulseToColor), period, duration, numPulses,
                        "TutorialPulseEffect", null);
            }
        }

        @Override
        public void onPulseEffectInitialized(TrackingID trackingId, PulseEffect effect) {
            // STEP4: All the PulseEffect
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

        // Instantiate the director and wait for the connection
        lightingDirector = LightingDirector.get();

        // STEP 1: Register a global listener to handle Lighting events and Controller connection
        lightingDirector.addListener(new MyLightingListener());
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
        // STEP 2: Create a Group consisting of all the connected Lamps
        Lamp[] lamps = lightingDirector.getLamps();
        groupCreationId = lightingDirector.createGroup(lamps, "TutorialGroup", null);
    }
}

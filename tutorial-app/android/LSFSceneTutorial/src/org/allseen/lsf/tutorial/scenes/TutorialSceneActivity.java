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
package org.allseen.lsf.tutorial.scenes;

import org.allseen.lsf.TrackingID;
import org.allseen.lsf.helper.facade.Color;
import org.allseen.lsf.helper.facade.GroupMember;
import org.allseen.lsf.helper.facade.LightingDirector;
import org.allseen.lsf.helper.facade.MyLampState;
import org.allseen.lsf.helper.facade.Power;
import org.allseen.lsf.helper.facade.PulseEffect;
import org.allseen.lsf.helper.facade.Scene;
import org.allseen.lsf.helper.facade.SceneElement;
import org.allseen.lsf.helper.listener.NextControllerConnectionListener;
import org.allseen.lsf.helper.listener.PulseEffectAdapter;
import org.allseen.lsf.helper.listener.SceneAdapter;
import org.allseen.lsf.helper.listener.SceneElementAdapter;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

/*
 * Tutorial illustrating how to create a Scene consisting of a PulseEffect and apply it using a
 * one-shot listener to chain events together. This tutorial assumes that there exists a one Lamp
 * and one Controller on the network.
 */
public class TutorialSceneActivity extends Activity implements NextControllerConnectionListener {
    private static final int CONTROLLER_CONNECTION_DELAY = 5000;

    private LightingDirector lightingDirector;

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

        // STEP 1: Register a listener for when the Controller connects and start the LightingDirector
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
        // STEP 2: Define all parameters used in creating a Scene.
        final Color pulseFromColor = Color.GREEN;
        final Color pulseToColor = Color.BLUE;
        final Power pulsePowerState = Power.ON;
        final long period = 1000;
        final long duration = 500;
        final long numPulses = 10;
        final GroupMember[] members = lightingDirector.getLamps();

        // STEP 3: Start Scene creation process, creating all intermediate objects necessary along
        // the way.
        // boilerplate code, alter parameters in STEP 2 to change effect color, length, etc.

        // STEP 3A: Create PulseEffect
        lightingDirector.createPulseEffect(new MyLampState(pulsePowerState, pulseFromColor),
                new MyLampState(pulsePowerState, pulseToColor), period, duration, numPulses,
                "TutorialPulseEffect", new PulseEffectAdapter() {

            @Override
            public void onPulseEffectInitialized(TrackingID trackingId, PulseEffect effect) {
                // STEP 3B: Create SceneElement with newly created PulseEffect
                lightingDirector.createSceneElement(effect, members, "TutorialSceneElement", new SceneElementAdapter() {

                    @Override
                    public void onSceneElementInitialized(TrackingID trackingId, SceneElement element) {
                        // STEP 3C: Create Scene using newly created SceneElement
                        lightingDirector.createScene(new SceneElement[] { element }, "TutorialScene", new SceneAdapter() {

                            @Override
                            public void onSceneInitialized(TrackingID trackingId, Scene scene) {
                                // STEP 4: Apply The scene
                                scene.apply();
                            }
                        });
                    }
                });
            }
        });
    }
}

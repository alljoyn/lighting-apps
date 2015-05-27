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
package org.allseen.lsf.tutorial.transitioneffects;

import org.allseen.lsf.TrackingID;
import org.allseen.lsf.sdk.Color;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.MyLampState;
import org.allseen.lsf.sdk.NextControllerConnectionListener;
import org.allseen.lsf.sdk.Power;
import org.allseen.lsf.sdk.TransitionEffect;
import org.allseen.lsf.sdk.TransitionEffectAdapter;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

/*
 * Tutorial illustrating how to create a TransitionEffect and apply it using a
 * one-shot listener. This tutorial assumes that there exists a one Lamp and
 * one Controller on the network.
 */
public class TutorialTransitionEffectActivity extends Activity implements NextControllerConnectionListener {
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
        // STEP 2: Create a TransitionEffect and listen for events using a one-shot Listener
        lightingDirector.createTransitionEffect(new MyLampState(Power.ON, Color.RED), 5000, "TutorialTransition", new TransitionEffectAdapter() {
            @Override
            public void onTransitionEffectInitialized(TrackingID trackingId, TransitionEffect effect) {
                // STEP 3: Apply the Scene
                effect.applyTo(lightingDirector.getLamps()[0]);
            }
        });
    }
}

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
package org.allseen.lsf.tutorial.presets;

import org.allseen.lsf.TrackingID;
import org.allseen.lsf.sdk.AllCollectionAdapter;
import org.allseen.lsf.sdk.Color;
import org.allseen.lsf.sdk.Lamp;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.Power;
import org.allseen.lsf.sdk.Preset;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

/*
 * Tutorial illustrating how to create a Preset and apply it to the lamps. This
 * tutorial assumes that there exists a one Lamp and one Controller on the network.
 */
public class TutorialPresetActivity extends Activity {
    private LightingDirector lightingDirector;

    /*
     * Global Lighting event listener. Responsible for handling any callbacks that
     * the user is interested in acting on.
     */
    private class MyLightingListener extends AllCollectionAdapter {
        @Override
        public void onLampInitialized(Lamp lamp) {
            // STEP 2: Use the discovery of a Lamp as a trigger for creating
            // the Preset. We define a preset that changes the color to red.
            lightingDirector.createPreset(Power.ON, Color.RED, "TutorialPreset", null);
        }

        @Override
        public void onPresetInitialized(TrackingID trackingId, Preset preset) {
            // STEP3: With the Preset is created, apply the Preset to all the Lamps on the network
            for (Lamp lamp : lightingDirector.getLamps()) {
                preset.applyTo(lamp);
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

        // STEP 1: Register a global listener to handle Lighting events and start the LightingDirector
        lightingDirector.addListener(new MyLightingListener());
        lightingDirector.start("TutorialApp");
    }

    @Override
    protected void onDestroy() {
        lightingDirector.stop();
        super.onDestroy();
    }
}

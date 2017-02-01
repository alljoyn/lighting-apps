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
package org.allseen.lsf.tutorial;

import org.alljoyn.lsf.tutorial.R;
import org.allseen.lsf.helper.facade.Group;
import org.allseen.lsf.helper.facade.Lamp;
import org.allseen.lsf.helper.facade.LightingDirector;
import org.allseen.lsf.helper.facade.Scene;
import org.allseen.lsf.helper.manager.LightingSystemQueue;

import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.support.v4.app.FragmentActivity;
import android.widget.TextView;

public class TutorialActivity extends FragmentActivity {
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
        lightingDirector = new LightingDirector(new LightingSystemQueue() {
            Handler handler = new Handler(Looper.getMainLooper());
            @Override
            public void post(Runnable r) {
                handler.post(r);
            }

            @Override
            public void postDelayed(Runnable r, int delay) {
                handler.postDelayed(r, delay);
            }});

        lightingDirector.postOnNextControllerConnection(new Runnable() {
            @Override
            public void run() {
                performLightingOperations();
            }}, 5000);
        lightingDirector.start("TutorialApp");
    }

    @Override
    protected void onDestroy() {
        lightingDirector.stop();
        super.onDestroy();
    }

    protected void performLightingOperations() {
        // Lamp operations
        Lamp[] lamps = lightingDirector.getLamps();

        for (int i = 0; i < lamps.length; i++) {
            lamps[i].turnOn();
        }

        try {Thread.sleep(2000);} catch(Exception e) { }

        for (int i = 0; i < lamps.length; i++) {
            lamps[i].turnOff();
        }

        try {Thread.sleep(2000);} catch(Exception e) { }

        for (int i = 0; i < lamps.length; i++) {
            lamps[i].setColor(180, 100, 50, 4000);
        }

        // Group operations
        Group[] groups = lightingDirector.getGroups();

        for (int i = 0; i < groups.length; i++) {
            groups[i].turnOn();
        }

        try {Thread.sleep(2000);} catch(Exception e) { }

        for (int i = 0; i < groups.length; i++) {
            groups[i].turnOff();
        }

        try {Thread.sleep(2000);} catch(Exception e) { }

        for (int i = 0; i < groups.length; i++) {
            groups[i].setColor(90, 100, 75, 4000);
        }

        try {Thread.sleep(2000);} catch(Exception e) { }

        // Scene operations
        Scene[] scenes = lightingDirector.getScenes();

        for (int i = 0; i < scenes.length; i++) {
            scenes[i].apply();
        }
    }
}
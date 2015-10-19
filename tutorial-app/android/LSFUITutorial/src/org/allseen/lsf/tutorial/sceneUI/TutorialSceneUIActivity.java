/*
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
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
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.tutorial.sceneUI;

import java.util.ArrayList;

import org.allseen.lsf.sdk.AllLightingItemListenerBase;
import org.allseen.lsf.sdk.LightingController;
import org.allseen.lsf.sdk.LightingControllerConfigurationBase;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.Scene;
import org.allseen.lsf.sdk.TrackingID;

import android.app.ListActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

public class TutorialSceneUIActivity extends ListActivity {

    private ListView listView;
    private ArrayList<Scene> sceneList;
    private ArrayList<String> sceneNameList;
    private ArrayAdapter<String> listAdapter;


    // A global Listener that updates the UI when a Scene is initialized or removed.
    private class MyLightingListener extends AllLightingItemListenerBase {
        @Override
        public void onSceneInitialized(TrackingID trackingId, Scene scene) {
            //Update UI when a Scene is initialized.
            sceneList.add(scene);
            sceneNameList.add(scene.getName());
            updateUI();
        }

        @Override
        public void onSceneRemoved(Scene scene) {
            //Update UI when a Scene is removed.
            int index = sceneList.indexOf(scene);
            sceneList.remove(index);
            sceneNameList.remove(index);
            updateUI();
        }
    }

    @Override
    protected void onCreate(Bundle savedState) {
        super.onCreate(savedState);

        setContentView(R.layout.activity_tutorial_app);

        // STEP 1: Find the ListView resource and set the data ArrayList and adapter for the UI ListView.
        listView = (ListView) findViewById(android.R.id.list);
        sceneList = new ArrayList<Scene>();
        sceneNameList = new ArrayList<String>();
        listAdapter = new ArrayAdapter<String>(this, R.layout.simplerow, sceneNameList);
        listView.setAdapter(listAdapter);

        // STEP 2: Initialize a lighting controller with default configuration.
        LightingController lightingController = LightingController.get();
        lightingController.init(new LightingControllerConfigurationBase(getApplicationContext().getFileStreamPath("").getAbsolutePath()));
        lightingController.start();

        // STEP 3: Instantiate the director, add the custom listener, then start.
        LightingDirector lightingDirector = LightingDirector.get();
        lightingDirector.addListener(new MyLightingListener());
        lightingDirector.setNetworkConnectionStatus(true);
        lightingDirector.start("TutorialApp");
    }

    @Override
    protected void onResume(){
        super.onResume();
        updateUI();
    }

    @Override
    protected void onListItemClick(ListView l, View v, int position, long id) {
        sceneList.get(position).apply();
    }

    private void updateUI() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                listAdapter.notifyDataSetChanged();
            }
        });
    }
}
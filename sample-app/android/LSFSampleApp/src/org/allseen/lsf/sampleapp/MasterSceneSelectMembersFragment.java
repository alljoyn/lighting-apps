/*
 *  *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
package org.allseen.lsf.sampleapp;

import java.util.List;

import org.allseen.lsf.helper.manager.AllJoynManager;

import android.view.Menu;
import android.view.MenuInflater;

public class MasterSceneSelectMembersFragment extends SelectMembersFragment {

    public MasterSceneSelectMembersFragment() {
        super(R.string.label_master_scene);
    }

    @Override
    protected boolean showScenes() {
        return true;
    }

    @Override
    protected String getHeaderText() {
        return getString(R.string.master_scene_select_members);
    }

    @Override
    protected String[] getPendingScenes() {
        return ((SampleAppActivity)getActivity()).pendingMasterSceneModel.masterScene.getScenes();
    }

    @Override
    protected String getPendingItemID() {
        return ((SampleAppActivity)getActivity()).pendingMasterSceneModel.id;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);

        ((SampleAppActivity)getActivity()).updateActionBar(R.string.title_master_scene_add, false, false, false, true, true);
    }

    @Override
    protected void processSelection(SampleAppActivity activity, List<String> lampIDs, List<String> groupIDs, List<String> sceneIDs) {
        activity.pendingMasterSceneModel.masterScene.setScenes(sceneIDs.toArray(new String[sceneIDs.size()]));

        if (activity.pendingMasterSceneModel.hasDefaultID()) {
            AllJoynManager.masterSceneManager.createMasterScene(activity.pendingMasterSceneModel.masterScene, activity.pendingMasterSceneModel.getName(), SampleAppActivity.LANGUAGE);
        } else {
            AllJoynManager.masterSceneManager.updateMasterScene(activity.pendingMasterSceneModel.id, activity.pendingMasterSceneModel.masterScene);
        }
    }

    @Override
    protected int getMixedSelectionMessageID() {
        return R.string.mixing_lamp_types_message_scene;
    }

    @Override
    protected int getMixedSelectionPositiveButtonID() {
        return R.string.create_scene;
    }
}
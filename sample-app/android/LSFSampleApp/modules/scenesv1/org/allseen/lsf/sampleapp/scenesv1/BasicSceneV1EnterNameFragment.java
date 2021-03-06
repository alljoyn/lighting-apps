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
package org.allseen.lsf.sampleapp.scenesv1;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.sampleapp.EnterNameFragment;
import org.allseen.lsf.sampleapp.R;
import org.allseen.lsf.sampleapp.SampleAppActivity;
import org.allseen.lsf.sampleapp.Util;
import org.allseen.lsf.sdk.LampCapabilities;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.model.SceneDataModel;

import android.util.Log;

public class BasicSceneV1EnterNameFragment extends EnterNameFragment {

    public BasicSceneV1EnterNameFragment() {
        super(R.string.label_basic_scene);
    }

    @Override
    protected int getTitleID() {
        return R.string.title_basic_scene_add;
    }

    @Override
    protected void setName(String name) {
        SceneDataModel sceneModel = new SceneDataModel();

        sceneModel.setName(name);

        BasicSceneV1InfoFragment.pendingBasicSceneModel = sceneModel;
        EffectV1InfoFragment.pendingBasicSceneElementMembers = new LampGroup();
        EffectV1InfoFragment.pendingBasicSceneElementCapability = new LampCapabilities(true, true, true);

        Log.d(SampleAppActivity.TAG, "Pending basic scene name: " + BasicSceneV1InfoFragment.pendingBasicSceneModel.getName());
    }

    @Override
    protected String getDuplicateNameMessage() {
        return this.getString(R.string.duplicate_name_message_scene);
    }

    @Override
    protected boolean duplicateName(String basicSceneName) {
        return Util.isDuplicateName(LightingDirector.get().getScenes(), basicSceneName);
    }
}
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
package org.allseen.lsf.sampleapp.scenesv1;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.sampleapp.R;
import org.allseen.lsf.sdk.LampCapabilities;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.Scene;
import org.allseen.lsf.sdk.SceneV1;
import org.allseen.lsf.sdk.model.NoEffectDataModel;
import org.allseen.lsf.sdk.model.PulseEffectDataModel;
import org.allseen.lsf.sdk.model.SceneDataModel;
import org.allseen.lsf.sdk.model.TransitionEffectDataModel;

import android.content.Context;

public class BasicScenePlugin {
    public static void init(Context context) {
        NoEffectDataModel.defaultName = context.getString(R.string.effect_name_none);
        TransitionEffectDataModel.defaultName = context.getString(R.string.effect_name_transition);
        PulseEffectDataModel.defaultName = context.getString(R.string.effect_name_pulse);
        SceneDataModel.defaultName = context.getString(R.string.default_basic_scene_name);
    }

    public static void resetPendingData(String sceneID) {
        Scene scene = sceneID != null ? LightingDirector.get().getScene(sceneID) : null;

        if (scene != null && scene instanceof SceneV1) {
            BasicSceneV1InfoFragment.pendingBasicSceneModel = BasicSceneUtil.createSceneDataModelFrom((SceneV1)scene);
        } else {
            BasicSceneV1InfoFragment.pendingBasicSceneModel = new SceneDataModel();
        }

        EffectV1InfoFragment.pendingBasicSceneElementMembers = new LampGroup();
        EffectV1InfoFragment.pendingBasicSceneElementCapability = new LampCapabilities(true, true, true);
    }
}

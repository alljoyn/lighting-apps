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

import java.util.List;

import org.allseen.lsf.sampleapp.SceneItemSelectEffectTypeFragment;
import org.allseen.lsf.sampleapp.ScenesPageFragment;
import org.allseen.lsf.sdk.model.EffectType;
import org.allseen.lsf.sdk.model.NoEffectDataModel;
import org.allseen.lsf.sdk.model.PulseEffectDataModel;
import org.allseen.lsf.sdk.model.TransitionEffectDataModel;

public class BasicSceneV1SelectEffectTypeFragment extends SceneItemSelectEffectTypeFragment {
    @Override
    protected String getPendingSceneItemName() {
        return BasicSceneV1InfoFragment.pendingBasicSceneModel.getName();
    }

    @Override
    protected String[] getPendingSceneElementMemberLampIDs() {
        return EffectV1InfoFragment.pendingBasicSceneElementMembers.getLamps();
    }

    @Override
    protected String[] getPendingSceneElementMemberGroupIDs() {
        return EffectV1InfoFragment.pendingBasicSceneElementMembers.getLampGroups();
    }

    @Override
    protected boolean isItemSelected(String itemID) {
        EffectType effectType = EffectType.None;

        if (NoEffectFragment.pendingNoEffectModel != null) {
            effectType = EffectType.None;
        } else if (TransitionEffectFragment.pendingTransitionEffectModel != null) {
            effectType = EffectType.Transition;
        } else if (PulseEffectFragment.pendingPulseEffectModel != null) {
            effectType = EffectType.Pulse;
        }

        return effectType.toString().equals(itemID);
    }

    @Override
    public void onActionNext() {
        List<String> selectedIDs = getSelectedIDs();
        String effectID = selectedIDs != null && selectedIDs.size() > 0 ? selectedIDs.get(0) : EffectType.None.toString();

        if (effectID.equals(EffectType.None.toString())) {
            NoEffectFragment.pendingNoEffectModel = new NoEffectDataModel();
            TransitionEffectFragment.pendingTransitionEffectModel = null;
            PulseEffectFragment.pendingPulseEffectModel = null;
            ((ScenesPageFragment)parent).showConstantEffectChildFragment();
        } else if (effectID.equals(EffectType.Transition.toString())) {
            NoEffectFragment.pendingNoEffectModel = null;
            TransitionEffectFragment.pendingTransitionEffectModel = new TransitionEffectDataModel();
            PulseEffectFragment.pendingPulseEffectModel = null;
            ((ScenesPageFragment)parent).showTransitionEffectChildFragment();
        } else if (effectID.equals(EffectType.Pulse.toString())) {
            NoEffectFragment.pendingNoEffectModel = null;
            TransitionEffectFragment.pendingTransitionEffectModel = null;
            PulseEffectFragment.pendingPulseEffectModel = new PulseEffectDataModel();
            ((ScenesPageFragment)parent).showPulseEffectChildFragment();
        }
    }
}

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

import java.util.Arrays;
import java.util.Collection;
import org.allseen.lsf.sampleapp.R;
import org.allseen.lsf.sampleapp.SampleAppActivity;
import org.allseen.lsf.sampleapp.SceneItemSelectMembersFragment;
import org.allseen.lsf.sampleapp.ScenesPageFragment;
import org.allseen.lsf.sdk.ColorAverager;
import org.allseen.lsf.sdk.LampCapabilities;
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.NoEffectDataModel;

import android.view.Menu;
import android.view.MenuInflater;

public class BasicSceneV1SelectMembersFragment extends SceneItemSelectMembersFragment {

    public BasicSceneV1SelectMembersFragment() {
        super(R.string.label_basic_scene);
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);

        ((SampleAppActivity)getActivity()).updateActionBar(R.string.title_basic_scene_element_add, false, false, true, false, true);
    }

    @Override
    protected String getHeaderText() {
        return getString(R.string.basic_scene_select_members);
    }

    @Override
    protected String getPendingItemID() {
        return BasicSceneV1InfoFragment.pendingBasicSceneModel.id;
    }

    @Override
    protected int getMixedSelectionMessageID() {
        return R.string.mixing_lamp_types_message_scene;
    }

    @Override
    protected int getMixedSelectionPositiveButtonID() {
        return R.string.create_scene;
    }

    @Override
    protected Collection<String> getPendingGroupIDs() {
        return Arrays.asList(EffectV1InfoFragment.pendingBasicSceneElementMembers.getLampGroups());
    }

    @Override
    protected Collection<String> getPendingLampIDs() {
        return Arrays.asList(EffectV1InfoFragment.pendingBasicSceneElementMembers.getLamps());
    }

    @Override
    protected void setPendingMemberIDs(Collection<String> lampIDs, Collection<String> groupIDs) {
        EffectV1InfoFragment.pendingBasicSceneElementMembers.setLamps(lampIDs.toArray(new String[lampIDs.size()]));
        EffectV1InfoFragment.pendingBasicSceneElementMembers.setLampGroups(groupIDs.toArray(new String[groupIDs.size()]));
    }

    @Override
    protected void setPendingCapability(LampCapabilities capability) {
        EffectV1InfoFragment.pendingBasicSceneElementCapability = capability;
    }

    @Override
    protected boolean getPendingMembersHaveEffects() {
        return EffectV1InfoFragment.pendingBasicSceneElementMembersHaveEffects;
    }

    @Override
    protected void setPendingMembersHaveEffects(boolean haveEffects) {
        EffectV1InfoFragment.pendingBasicSceneElementMembersHaveEffects = haveEffects;
    }

    @Override
    protected int getPendingMembersMinColorTemp() {
        return EffectV1InfoFragment.pendingBasicSceneElementMembersMinColorTemp;
    }

    @Override
    protected void setPendingMembersMinColorTemp(int minColorTemp) {
        EffectV1InfoFragment.pendingBasicSceneElementMembersMinColorTemp = minColorTemp;
    }

    @Override
    protected int getPendingMembersMaxColorTemp() {
        return EffectV1InfoFragment.pendingBasicSceneElementMembersMaxColorTemp;
    }

    @Override
    protected void setPendingMembersMaxColorTemp(int maxColorTemp) {
        EffectV1InfoFragment.pendingBasicSceneElementMembersMaxColorTemp = maxColorTemp;
    }

    @Override
    protected ColorAverager getPendingColorTempAverager() {
        return EffectV1InfoFragment.pendingBasicSceneElementColorTempAverager;
    }

    @Override
    protected void updatePendingColorTempAverager(int viewColorTemp) {
        getPendingColorTempAverager().add(ColorStateConverter.convertColorTempViewToModel(viewColorTemp));
    }

    @Override
    public void onActionNext() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();

        if (processSelection()) {
            if (getPendingMembersHaveEffects()) {
                if (NoEffectFragment.pendingNoEffectModel != null) {
                    showNoEffectChildFragment(activity);
                } else if (TransitionEffectFragment.pendingTransitionEffectModel != null) {
                    showTransitionEffectChildFragment(activity);
                } else if (PulseEffectFragment.pendingPulseEffectModel != null) {
                    showPulseEffectChildFragment(activity);
                } else {
                    showSelectEffectChildFragment(activity);
                }
            } else {
                if (NoEffectFragment.pendingNoEffectModel == null) {
                    NoEffectFragment.pendingNoEffectModel = new NoEffectDataModel();
                }

                showNoEffectChildFragment(activity);
            }
        }
    }

    protected void showSelectEffectChildFragment(SampleAppActivity activity) {
        NoEffectFragment.pendingNoEffectModel = null;
        TransitionEffectFragment.pendingTransitionEffectModel = null;
        PulseEffectFragment.pendingPulseEffectModel = null;

        ((ScenesPageFragment)parent).showSelectEffectTypeChildFragment();
    }

    protected void showNoEffectChildFragment(SampleAppActivity activity) {
        TransitionEffectFragment.pendingTransitionEffectModel = null;
        PulseEffectFragment.pendingPulseEffectModel = null;

        ((ScenesPageFragment)parent).showConstantEffectChildFragment();
    }

    protected void showTransitionEffectChildFragment(SampleAppActivity activity) {
        NoEffectFragment.pendingNoEffectModel = null;
        PulseEffectFragment.pendingPulseEffectModel = null;

        ((ScenesPageFragment)parent).showTransitionEffectChildFragment();
    }

    protected void showPulseEffectChildFragment(SampleAppActivity activity) {
        NoEffectFragment.pendingNoEffectModel = null;
        TransitionEffectFragment.pendingTransitionEffectModel = null;

        ((ScenesPageFragment)parent).showPulseEffectChildFragment();
    }
}

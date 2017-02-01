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
package org.allseen.lsf.sampleapp;

import java.util.Map;

import org.allseen.lsf.LampState;
import org.allseen.lsf.PresetPulseEffect;

import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.SeekBar;

public abstract class BasicSceneElementInfoFragment extends DimmableItemInfoFragment {

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        SampleAppActivity activity = (SampleAppActivity)getActivity();
        BasicSceneElementDataModel pendingModel = getPendingSceneElementDataModel();

        checkInitialColorTemp(pendingModel, DimmableItemScaleConverter.convertColorTempViewToModel(activity.pendingBasicSceneElementMembersMinColorTemp));

        View root = super.onCreateView(inflater, container, savedInstanceState);

        if (pendingModel.presetID != null && !pendingModel.presetID.equals(PresetPulseEffect.PRESET_ID_CURRENT_STATE)) {
            PresetDataModel presetModel = activity.presetModels.get(pendingModel.presetID);

            if (presetModel != null) {
                pendingModel.state = presetModel.state;
            } else {
                pendingModel.presetID = null;
            }
        }

        return root;
    }

    @Override
    public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
        super.onCreateOptionsMenu(menu, inflater);

        ((SampleAppActivity)getActivity()).updateActionBar(R.string.title_basic_scene_element_add, false, false, false, true, true);
    }

    @Override
    public void onClick(View view) {
        int viewID = view.getId();

        if (viewID == R.id.statusButtonPower) {
            onHeaderClick();
        } else {
            super.onClick(view);
        }
    }

    @Override
    protected void onHeaderClick() {
        // TODO-FIX dialog to change effect type here
    }

    // Override parent to update the pending lamp state rather than call the activity
    @Override
    public void setField(SeekBar seekBar) {
        int seekBarID = seekBar.getId();
        int seekBarProgress = seekBar.getProgress();
        Object seekBarTag = seekBar.getTag();
        LampState pendingState = getPendingSceneElementState(seekBarTag);
        CapabilityData capability = getPendingSceneElementDataModel().capability;
        int colorTempMin = getColorTempMin();

        if (seekBarID == R.id.stateSliderBrightness) {
            pendingState.setBrightness(DimmableItemScaleConverter.convertBrightnessViewToModel(seekBarProgress));
        } else if (seekBarID == R.id.stateSliderHue) {
            pendingState.setHue(DimmableItemScaleConverter.convertHueViewToModel(seekBarProgress));
        } else if (seekBarID == R.id.stateSliderSaturation) {
            pendingState.setSaturation(DimmableItemScaleConverter.convertSaturationViewToModel(seekBarProgress));
        } else if (seekBarID == R.id.stateSliderColorTemp) {
            pendingState.setColorTemp(DimmableItemScaleConverter.convertColorTempViewToModel(seekBarProgress + colorTempMin));
        }

        updatePresetFields(pendingState, getLampStateViewAdapter(seekBarTag));
        updatePresetID(getMatchingPreset(pendingState), seekBarTag);

        setColorIndicator(getLampStateViewAdapter(seekBarTag).stateView, pendingState, capability, getColorTempDefault());
    }

    @Override
    public void updatePresetFields() {
        updatePresetFields(getPendingSceneElementDataModel());
    }

    protected void updatePresetID(String presetID, Object viewTag) {
        getPendingSceneElementDataModel().presetID = presetID;
    }

    protected LampState getPendingSceneElementState(Object viewTag) {
        return getPendingSceneElementDataModel().state;
    }

    protected LampStateViewAdapter getLampStateViewAdapter(Object viewTag) {
        return stateAdapter;
    }

    protected String getMatchingPreset(LampState itemState) {
        Map<String, PresetDataModel> presetModels = ((SampleAppActivity)getActivity()).presetModels;

        for (PresetDataModel presetModel : presetModels.values()) {
            if (presetModel.stateEquals(itemState)) {
                return presetModel.id;
            }
        }

        return null;
    }

    @Override
    public void onActionDone() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();
        BasicSceneElementDataModel elementModel = getPendingSceneElementDataModel();

        elementModel.members = activity.pendingBasicSceneElementMembers;
        elementModel.capability = activity.pendingBasicSceneElementCapability;

        updatePendingSceneElement();

        activity.pendingBasicSceneElementMembers = null;
        activity.pendingBasicSceneElementCapability = null;

        activity.pendingNoEffectModel = null;
        activity.pendingTransitionEffectModel = null;
        activity.pendingPulseEffectModel = null;

        parent.popBackStack(PageFrameParentFragment.CHILD_TAG_INFO);
    }

    @Override
    protected int getColorTempMin() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();

        return activity.pendingBasicSceneElementMembersMinColorTemp;
    }

    @Override
    protected int getColorTempSpan() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();

        return activity.pendingBasicSceneElementMembersMaxColorTemp - activity.pendingBasicSceneElementMembersMinColorTemp;
    }

    @Override
    protected long getColorTempDefault() {
        SampleAppActivity activity = (SampleAppActivity)getActivity();

        return activity.pendingBasicSceneElementColorTempAverager.getAverage();
    }

    protected void checkInitialColorTemp(BasicSceneElementDataModel pendingModel, long modelColorTempMin) {
        if (pendingModel.state.getColorTemp() < modelColorTempMin) {
            pendingModel.state.setColorTemp(modelColorTempMin);
        }
    }

    protected abstract BasicSceneElementDataModel getPendingSceneElementDataModel();
    protected abstract void updatePendingSceneElement();
}
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
package org.allseen.lsf.sampleapp;

import org.allseen.lsf.sampleapp.R;
import org.allseen.lsf.sdk.LampCapabilities;
import org.allseen.lsf.sdk.LampStateUniformity;
import org.allseen.lsf.sdk.LightingDirector;
import org.allseen.lsf.sdk.MyLampState;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class PresetEffectFragment extends EffectV2InfoFragment {
    public static PendingPresetEffect pendingPresetEffect = null;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = super.onCreateView(inflater, container, savedInstanceState);

        setImageButtonBackgroundResource(statusView, R.id.statusButtonPower, R.drawable.list_constant_icon);

        ((TextView)statusView.findViewById(R.id.statusLabelName)).setText(R.string.label_effect_name);

        updateInfoFields(pendingPresetEffect.name, new MyLampState(pendingPresetEffect.state), LampCapabilities.allCapabilities, pendingPresetEffect.uniformity);
        initLampState();

        return view;
    }

    @Override
    public int getTitleID() {
        return R.string.title_preset_add;
    }

    @Override
    protected void updateInfoFields(String name, MyLampState state, LampCapabilities capability, LampStateUniformity uniformity) {
        stateAdapter.setCapability(capability);

        super.updateInfoFields(name, state, capability, uniformity);

        updatePresetInfoFields();
    }

    protected void updatePresetInfoFields() {
        // Superclass updates the icon, so we have to re-override
        setImageButtonBackgroundResource(statusView, R.id.statusButtonPower, R.drawable.list_constant_icon);
    }

    @Override
    protected int getLayoutID() {
        return R.layout.fragment_effect_constant;
    }

    @Override
    protected String getPendingEffectID() {
        return pendingPresetEffect.id;
    }

    @Override
    protected MyLampState getPendingLampState(int index) {
        return pendingPresetEffect.state;
    }

    @Override
    protected String getPendingPresetID(int index) {
        return pendingPresetEffect.id;
    }

    @Override
    protected void setPendingPresetID(int index, String presetID) {
        logErrorOnInvalidIndex(index);

        pendingPresetEffect.id = presetID;
    }

    @Override
    public void onActionDone() {
        if (!isAddMode()) {
            LightingDirector.get().getPreset(pendingPresetEffect.id).modify(pendingPresetEffect.state.getPower(), pendingPresetEffect.state.getColor());
        } else {
            LightingDirector.get().createPreset(pendingPresetEffect.state.getPower(), pendingPresetEffect.state.getColor(), pendingPresetEffect.name, null);
        }

        parent.popBackStack(ScenesPageFragment.CHILD_TAG_SELECT_EFFECT);
    }
}

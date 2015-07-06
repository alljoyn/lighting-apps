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

import org.allseen.lsf.LampState;
import org.allseen.lsf.sampleapp.DimmableItemPresetsFragment;
import org.allseen.lsf.sdk.Color;
import org.allseen.lsf.sdk.MyLampState;
import org.allseen.lsf.sdk.Preset;
import org.allseen.lsf.sdk.model.ColorStateConverter;

public class BasicSceneElementPresetsFragment extends DimmableItemPresetsFragment {

    @Override
    protected MyLampState getItemLampState() {
        LampState lampState;

        if (NoEffectFragment.pendingNoEffectModel != null) {
            lampState = NoEffectFragment.pendingNoEffectModel.getState();
        } else if (TransitionEffectFragment.pendingTransitionEffectModel != null) {
            lampState = TransitionEffectFragment.pendingTransitionEffectModel.getState();
        } else if (key2 != PulseEffectFragment.STATE2_ITEM_TAG) {
            lampState = PulseEffectFragment.pendingPulseEffectModel.getState();
        } else {
            lampState = PulseEffectFragment.pendingPulseEffectModel.endState;
        }

        return new MyLampState(lampState);
    }

    @Override
    protected void doApplyPreset(Preset preset) {
        Color color = preset.getColor();
        LampState state = new LampState();

        state.setOnOff(preset.isOn());
        state.setHue(ColorStateConverter.convertHueViewToModel(color.getHue()));
        state.setSaturation(ColorStateConverter.convertSaturationViewToModel(color.getSaturation()));
        state.setBrightness(ColorStateConverter.convertBrightnessViewToModel(color.getBrightness()));
        state.setColorTemp(ColorStateConverter.convertColorTempViewToModel(color.getColorTemperature()));

        if (NoEffectFragment.pendingNoEffectModel != null) {
            NoEffectFragment.pendingNoEffectModel.presetID = preset.getId();
            NoEffectFragment.pendingNoEffectModel.state = state;
        } else if (TransitionEffectFragment.pendingTransitionEffectModel != null) {
            TransitionEffectFragment.pendingTransitionEffectModel.presetID = preset.getId();
            TransitionEffectFragment.pendingTransitionEffectModel.state = state;
        } else if (key2 != PulseEffectFragment.STATE2_ITEM_TAG) {
            PulseEffectFragment.pendingPulseEffectModel.presetID = preset.getId();
            PulseEffectFragment.pendingPulseEffectModel.state = state;
        } else {
            PulseEffectFragment.pendingPulseEffectModel.endPresetID = preset.getId();
            PulseEffectFragment.pendingPulseEffectModel.endState = state;
        }
    }
}

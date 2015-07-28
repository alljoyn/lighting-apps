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
import org.allseen.lsf.LampState;
import org.allseen.lsf.sampleapp.EnterDurationFragment;
import org.allseen.lsf.sampleapp.PendingTransitionEffectV2;
import org.allseen.lsf.sdk.Color;
import org.allseen.lsf.sdk.LampCapabilities;
import org.allseen.lsf.sdk.MyLampState;
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.TransitionEffectDataModel;

public class PendingTransitionEffectV1 extends PendingTransitionEffectV2 {
    TransitionEffectDataModel dataModel;

    public PendingTransitionEffectV1() {
        this(new TransitionEffectDataModel());
    }

    public PendingTransitionEffectV1(TransitionEffectDataModel dataModel) {
        this.dataModel = dataModel;

        id = dataModel.id;
        name = dataModel.getName();
        state = new MyLampState(dataModel.state);
        presetID = dataModel.presetID;

        EnterDurationFragment.duration = dataModel.duration;
    }

    public void updateDataModel(LampGroup members, LampCapabilities capabilities) {
        dataModel.members = members;
        dataModel.setCapability(capabilities);

        dataModel.presetID = presetID;

        Color color = state.getColor();
        dataModel.state = new LampState();
        dataModel.state.setOnOff(state.isOn());
        dataModel.state.setHue(ColorStateConverter.convertHueViewToModel(color.getHue()));
        dataModel.state.setSaturation(ColorStateConverter.convertSaturationViewToModel(color.getSaturation()));
        dataModel.state.setBrightness(ColorStateConverter.convertBrightnessViewToModel(color.getBrightness()));
        dataModel.state.setColorTemp(ColorStateConverter.convertColorTempViewToModel(color.getColorTemperature()));

        dataModel.duration = EnterDurationFragment.duration;
    }
}

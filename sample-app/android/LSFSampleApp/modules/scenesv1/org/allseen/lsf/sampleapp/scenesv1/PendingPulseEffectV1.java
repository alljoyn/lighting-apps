/*
 *  * Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
package org.allseen.lsf.sampleapp.scenesv1;

import org.allseen.lsf.LampGroup;
import org.allseen.lsf.LampState;
import org.allseen.lsf.sampleapp.EnterCountFragment;
import org.allseen.lsf.sampleapp.EnterDurationFragment;
import org.allseen.lsf.sampleapp.EnterPeriodFragment;
import org.allseen.lsf.sampleapp.PendingPulseEffectV2;
import org.allseen.lsf.sdk.Color;
import org.allseen.lsf.sdk.LampCapabilities;
import org.allseen.lsf.sdk.MyLampState;
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.PulseEffectDataModel;

public class PendingPulseEffectV1 extends PendingPulseEffectV2 {
    PulseEffectDataModel dataModel;

    public PendingPulseEffectV1() {
        this(new PulseEffectDataModel());
    }

    public PendingPulseEffectV1(PulseEffectDataModel dataModel) {
        this.dataModel = dataModel;

        id = dataModel.id;
        name = dataModel.getName();

        startState = new MyLampState(dataModel.state);
        startPresetID = dataModel.presetID;
        startWithCurrent = dataModel.startWithCurrent;

        endState = new MyLampState(dataModel.endState);
        endPresetID = dataModel.endPresetID;

        EnterPeriodFragment.period = dataModel.period;
        EnterDurationFragment.duration = dataModel.duration;
        EnterCountFragment.count = dataModel.count;
    }

    public void updateDataModel(LampGroup members, LampCapabilities capabilities) {
        dataModel.members = members;
        dataModel.setCapability(capabilities);

        dataModel.state = copyLampState(startState, new LampState());
        dataModel.presetID = startPresetID;
        dataModel.startWithCurrent = startWithCurrent;

        dataModel.endState = copyLampState(endState, new LampState());
        dataModel.endPresetID = endPresetID;

        dataModel.period = EnterPeriodFragment.period;
        dataModel.duration = EnterDurationFragment.duration;
        dataModel.count = EnterCountFragment.count;
    }

    protected static LampState copyLampState(MyLampState source, LampState destination) {
        Color color = source.getColor();

        destination.setOnOff(source.isOn());
        destination.setHue(ColorStateConverter.convertHueViewToModel(color.getHue()));
        destination.setSaturation(ColorStateConverter.convertSaturationViewToModel(color.getSaturation()));
        destination.setBrightness(ColorStateConverter.convertBrightnessViewToModel(color.getBrightness()));
        destination.setColorTemp(ColorStateConverter.convertColorTempViewToModel(color.getColorTemperature()));

        return destination;
    }
}
/*
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
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

import org.allseen.lsf.LampState;

public class DimmableItemDataModel extends ItemDataModel {
    public static final char TAG_PREFIX_UNKNOWN = 'X';

    public LampState state;
    public LampStateUniformity uniformity;

    protected CapabilityData capability;

    public DimmableItemDataModel() {
        this("", TAG_PREFIX_UNKNOWN, "");
    }

    public DimmableItemDataModel(String itemID, char prefix, String itemName) {
        super(itemID, prefix, itemName);

        state = new LampState();
        uniformity = new LampStateUniformity();

        capability = new CapabilityData();

        state.setOnOff(false);
        state.setBrightness(0);
        state.setHue(0);
        state.setSaturation(0);
        state.setColorTemp(0);
    }

    public DimmableItemDataModel(DimmableItemDataModel other) {
        super(other);

        this.state = new LampState(other.state);
        this.uniformity = new LampStateUniformity(other.uniformity);
        this.capability = other.getCapability();
    }

    public boolean stateEquals(DimmableItemDataModel that) {
        return that != null ? stateEquals(that.state) : false;
    }

    public boolean stateEquals(LampState thatState) {
        boolean result = false;

        if (thatState != null) {
            result =
                this.state.getHue() == thatState.getHue() &&
                this.state.getSaturation() == thatState.getSaturation() &&
                this.state.getBrightness() == thatState.getBrightness() &&
                this.state.getColorTemp() == thatState.getColorTemp() &&
                this.state.getOnOff() == thatState.getOnOff();
        }

        return result;
    }

    public void setCapability(CapabilityData capability) {
        this.capability = capability;
    }

    public CapabilityData getCapability() {
        return capability;
    }
}
/* Copyright (c) 2014, AllSeen Alliance. All rights reserved.
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
package org.allseen.lsf.helper.facade;

import org.allseen.lsf.helper.model.ColorItemDataModel;
import org.allseen.lsf.helper.model.ColorStateConverter;
import org.allseen.lsf.helper.model.LightingItemDataModel;

/**
 * Abstract base class for Lighting items that support color.
 * <p>
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public abstract class ColorItem extends LightingItem implements LampState {

    public void turnOn() {
        setPowerOn(true);
    }

    public void turnOff() {
        setPowerOn(false);
    }

    public void setColorHsvt(int[] hsvt) {
        setColorHsvt(hsvt[0], hsvt[1], hsvt[2], hsvt[3]);
    }

    public int[] getColorHsvt() {
        return ColorStateConverter.convertModelToView(getColorDataModel().state);
    }

    public void setPower(Power power) {
        setPowerOn(power == Power.ON);
    }

    public boolean getPowerOn() {
        return getColorDataModel().state.getOnOff();
    }

    public Power getPower() {
        return (getPowerOn())? Power.ON : Power.OFF;
    }

    public void setColor(Color color) {
        setColorHsvt(color.getHue(), color.getSaturation(), color.getBrightness(), color.getColorTemperature());
    }

    public Color getColor() {
        return new Color(getColorHsvt());
    }

    @Override
    protected LightingItemDataModel getItemDataModel() {
        return getColorDataModel();
    }

    public abstract void setPowerOn(boolean powerOn);
    public abstract void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees);
    protected abstract ColorItemDataModel getColorDataModel();
}

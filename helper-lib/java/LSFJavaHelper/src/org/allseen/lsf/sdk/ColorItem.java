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
package org.allseen.lsf.sdk;

import org.allseen.lsf.sdk.model.ColorItemDataModel;
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.LightingItemDataModel;

/**
 * Abstract base class for Lighting Items that support Color
 * and Power values in the lighting system.
 */
public abstract class ColorItem extends LightingItem {

    /**
     * Returns the color HSVT value in an int array.
     *
     * @return int array with indexes 0,1,2,3 mapped to hue, saturation,
     * brightness, and color temperature components, respectively.
     */
    public int[] getColorHsvt() {
        return ColorStateConverter.convertModelToView(getColorDataModel().getState());
    }

    /**
     * Returns a boolean representing the power state of the Color Item.
     *
     * @return boolean representing whether or not power is on.
     */
    public boolean getPowerOn() {
        return getColorDataModel().getState().getOnOff();
    }

    /**
     * Returns a boolean representing the power state of the Color Item.
     *
     * @return boolean representing whether or not power is on.
     */
    public boolean isOn() {
        return getPowerOn();
    }

    /**
     * Returns a boolean representing the power state of the Color Item.
     *
     * @return boolean representing whether or not power is off.
     */
    public boolean isOff() {
        return !isOn();
    }

    /**
     * Returns the power state of the Color Item.
     *
     * @return the Power state of the Color Item.
     */
    public Power getPower() {
        return (getPowerOn())? Power.ON : Power.OFF;
    }

    /**
     * Returns a Color object identical to the Color of the Color Item.
     *
     * @return A Color Object identical to the Color of the Color Item.
     */
    public Color getColor() {
        return new Color(getColorHsvt());
    }

    /**
     * Returns a MyLampState object identical to that of the Color Item.
     *
     * @return a MyLampState object identical to that of the Color Item.
     */
    public MyLampState getState() {
        return new MyLampState(getPower(), getColor());
    }

    /**
     * Returns a LampStateUniformity object identical to that of the Color Item.
     *
     * @return a LampStateUniformity object identical to that of the Color Item.
     */
    public LampStateUniformity getUniformity() {
        return new LampStateUniformity(getColorDataModel().uniformity);
    }

    /**
     * Returns a LampCapabilities object identical to that of the Color Item.
     *
     * @return a LampCapabilities object identical to that of the Color Item.
     */
    public LampCapabilities getCapability() {
        return new LampCapabilities(getColorDataModel().getCapability());
    }

    /**
     * Sets the LampCapabilities of the Color Item.
     *
     * @param capability The LampCapabilities object to be set in the Color Item.
     */
    public void setCapability(LampCapabilities capability) {
        getColorDataModel().setCapability(capability);
    }

    @Override
    protected LightingItemDataModel getItemDataModel() {
        return getColorDataModel();
    }

    protected abstract ColorItemDataModel getColorDataModel();
}

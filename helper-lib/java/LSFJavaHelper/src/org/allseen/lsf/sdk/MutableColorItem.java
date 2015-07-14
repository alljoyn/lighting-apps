/* Copyright (c) AllSeen Alliance. All rights reserved.
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



/**
 * Abstract base class for Lighting items that support color.
 */
public abstract class MutableColorItem extends ColorItem implements LampState {

    /**
     * Set Power of the Mutable Color Item to ON.
     */
    public void turnOn() {
        setPowerOn(true);
    }

    /**
     * Set Power of the Mutable Color Item to OFF.
     */
    public void turnOff() {
        setPowerOn(false);
    }

    /**
     * Set the Color of the Mutable Color Item with the values defined in
     * the HSVT array.
     * @param hsvt
     *              the array of values. hsvt[0] is the hue component in degrees (0-360),
     *              hsvt[1] is the saturation component in percent (0-100), hsvt[2] is the brightness
     *              component in percent (0-100), and hsvt[3] is the color temperature in degrees
     *              Kelvin, (2700 - 9000)
     */
    public void setColorHsvt(int[] hsvt) {
        String errorContext = "MutableColorItem.setColorHsvt() error";

        if (postInvalidArgIfNull(errorContext, hsvt)) {
            if (hsvt.length != 4) {
                postInvalidArgIfNull(errorContext, null);
            } else {
                setColorHsvt(hsvt[0], hsvt[1], hsvt[2], hsvt[3]);
            }
        }
    }

    /**
     * Switches Power value from ON if OFF and vice versa.
     */
    public void togglePower() {
        setPowerOn(isOff());
    }

    /**
     * Sets Power to the same state as the parameter.
     *
     * @param power The desired Power state.
     */
    public void setPower(Power power) {
        setPowerOn(power == Power.ON);
    }

    /**
     * Sets Color to the same value as the parameter.
     *
     * @param color The desired Color value.
     */
    public void setColor(Color color) {
        String errorContext = "MutableColorItem.setColor() error";

        if (postInvalidArgIfNull(errorContext, color)) {
            setColorHsvt(color.getHue(), color.getSaturation(), color.getBrightness(), color.getColorTemperature());
        }
    }

    @Override
    public abstract void setPowerOn(boolean powerOn);
    @Override
    public abstract void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees);
}

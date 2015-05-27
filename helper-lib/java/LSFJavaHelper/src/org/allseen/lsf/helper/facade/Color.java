/*
 * Copyright AllSeen Alliance. All rights reserved.
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

import org.allseen.lsf.helper.model.ColorStateConverter;

public class Color {

    public static final Color RED = new Color(0, 100, 100, 3500);
    public static final Color GREEN = new Color(120, 100, 50, 3500);
    public static final Color BLUE = new Color(240, 100, 100, 3500);
    public static final Color WHITE = new Color(0,0,100,3500);

    private int hue;
    private int saturation;
    private int brightness;
    private int colorTemperature;

    public Color(int[] hsvt) {
        this(hsvt[0], hsvt[1], hsvt[2], hsvt[3]);
    }

    public Color(Color other) {
        this(other.hue, other.saturation, other.brightness, other.colorTemperature);
    }

    public Color(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees) {
        setHue(hueDegrees);
        setSaturation(saturationPercent);
        setBrightness(brightnessPercent);
        setColorTemperature(colorTempDegrees);
    }

    public void setHue(int hueDegrees) {
        hue = ColorStateConverter.boundHueView(hueDegrees);
    }

    public int getHue() {
        return hue;
    }

    public void setSaturation(int saturationPercent) {
        saturation = ColorStateConverter.boundSaturationView(saturationPercent);
    }

    public int getSaturation() {
        return saturation;
    }

    public void setBrightness(int brightnessPercent) {
        brightness = ColorStateConverter.boundBrightnessView(brightnessPercent);
    }

    public int getBrightness() {
        return brightness;
    }

    public void setColorTemperature(int colorTempDegrees) {
        colorTemperature = ColorStateConverter.boundColorTempView(colorTempDegrees);
    }

    public int getColorTemperature() {
        return colorTemperature;
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + brightness;
        result = prime * result + colorTemperature;
        result = prime * result + hue;
        result = prime * result + saturation;
        return result;
    }

    @Override
    public boolean equals(Object other) {
        if (other != null && other instanceof Color) {
            Color otherColor = (Color) other;

            return this.getBrightness() == otherColor.getBrightness() &&
                   this.getColorTemperature() == otherColor.getColorTemperature() &&
                   this.getHue() == otherColor.getHue() &&
                   this.getSaturation() == otherColor.getSaturation();
        }

        return false;
    }



}

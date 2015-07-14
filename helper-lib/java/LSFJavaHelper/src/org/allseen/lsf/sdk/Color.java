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
package org.allseen.lsf.sdk;

import org.allseen.lsf.sdk.model.ColorStateConverter;

/**
 * A Color object represents a defined color state in a lighting system.
 *<p>
 * Contains 4 pre-defined values: RED, GREEN, BLUE and WHITE.
 */
public class Color {

    public static final Color DEFAULT = new Color(LightingDirector.HUE_MIN, LightingDirector.SATURATION_MIN, LightingDirector.BRIGHTNESS_MIN, LightingDirector.COLORTEMP_MIN);

    public static final Color RED = new Color(0, 100, 100, 3500);
    public static final Color GREEN = new Color(120, 100, 50, 3500);
    public static final Color BLUE = new Color(240, 100, 100, 3500);
    public static final Color WHITE = new Color(0,0,100,3500);

    private int hue;
    private int saturation;
    private int brightness;
    private int colorTemperature;

    /**
     * Set a Color object with the defined HSVT values in an int array.
     *
     * @param hsvt the array of values. hsvt[0] is the hue component in degrees (0-360),
     * hsvt[1] is the saturation component in percent (0-100), hsvt[2] is the brightness
     * component in percent (0-100), and hsvt[3] is the color temperature in degrees
     * Kelvin, (2700 - 9000)
     */
    public Color(int[] hsvt) {
        this(hsvt[0], hsvt[1], hsvt[2], hsvt[3]);
    }

    /**
     * Set a Color object with defined HSVT values of another Color object.
     *
     * @param other The other Color object.
     */
    public Color(Color other) {
        this(other.hue, other.saturation, other.brightness, other.colorTemperature);
    }

    /**
     * Set a Color object with defined HSVT values.
     *
     * @param hueDegrees The hue component of the desired color, in degrees (0-360)
     * @param saturationPercent The saturation component of the desired color, in percent (0-100)
     * @param brightnessPercent The brightness component of the desired color, in percent (0-100)
     * @param colorTempDegrees The color temperature component of the desired color, in degrees Kelvin (2700-9000)
     */
    public Color(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees) {
        setHue(hueDegrees);
        setSaturation(saturationPercent);
        setBrightness(brightnessPercent);
        setColorTemperature(colorTempDegrees);
    }

    /**
     * Sets the hue component of a Color object.
     *
     * @param hueDegrees the hue component of the desire color, in degrees (0-360)
     */
    public void setHue(int hueDegrees) {
        hue = ColorStateConverter.boundHueView(hueDegrees);
    }

    /**
     * Gets the hue component of a Color object.
     *
     * @return The hue component of a Color object, in degrees (0-360)
     */
    public int getHue() {
        return hue;
    }

    /**
     * Sets the saturation component of a Color object.
     *
     * @param saturationPercent The saturation component of the desired color, in degrees (1-100)
     */
    public void setSaturation(int saturationPercent) {
        saturation = ColorStateConverter.boundSaturationView(saturationPercent);
    }

    /**
     * Gets the saturation component of a Color object.
     *
     * @return The saturation component of a Color object, in percent (1-100)
     */
    public int getSaturation() {
        return saturation;
    }

    /**
     * Sets the brightness component of a Color object.
     *
     * @param brightnessPercent The brightness component of the desired color, in percent (1-100)
     */
    public void setBrightness(int brightnessPercent) {
        brightness = ColorStateConverter.boundBrightnessView(brightnessPercent);
    }

    /**
     * Gets the brightness component of a Color object.
     *
     * @return The brightness component of a Color object, in percent (1-100)
     */
    public int getBrightness() {
        return brightness;
    }

    /**
     * Sets the color temperature component of a Color object.
     *
     * @param colorTempDegrees The color temperature component of the desired color, in degrees
     * Kelvin (2700-9000)
     */
    public void setColorTemperature(int colorTempDegrees) {
        colorTemperature = ColorStateConverter.boundColorTempView(colorTempDegrees);
    }

    /**
     * Gets the color temperature component of a Color object.
     *
     * @return The color temperature component of a Color object, in degrees Kelvin (2700-9000)
     */
    public int getColorTemperature() {
        return colorTemperature;
    }

    /**
     * Generates a hashCode for a Color object.
     *
     * @return The hashcode for the Color object
     */
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

    /**
     * Compares the Color object to another object for equivalence.
     *
     * @return boolean value representing if the Color object is equivalent to the other object.
     */
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

/* Copyright AllSeen Alliance. All rights reserved.
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
 * A MyLampState object represents the state of a lamp in the lighting system
 * in terms of a Power and a Color.
 */
public class MyLampState implements LampState {

    private static final Color DEFAULT_COLOR = Color.WHITE;
    private static final Power DEFAULT_POWER = Power.ON;

    private Power power;
    private Color color;

    /**
     * Constructs a MyLampState object.
     *
     * @param lampState An existing LampState.
     */
    public MyLampState(org.allseen.lsf.LampState lampState) {
        this(
                lampState.getOnOff() ? Power.ON : Power.OFF,
                        ColorStateConverter.convertHueModelToView(lampState.getHue()),
                        ColorStateConverter.convertSaturationModelToView(lampState.getHue()),
                        ColorStateConverter.convertBrightnessModelToView(lampState.getHue()),
                        ColorStateConverter.convertColorTempModelToView(lampState.getHue()));
    }

    /**
     * Constructs a MyLampState object.
     *
     * @param lampPower The Power value.
     * @param hue The hue component of a Color in degrees (0-360)
     * @param sat The saturation component of a Color in percent (0-100)
     * @param brightness The brightness component of a Color, in percent (0-100)
     * @param colorTemp The color temperature component of a Color, in degrees Kelvin (2700-9000)
     */
    public MyLampState(Power lampPower, int hue, int sat, int brightness, int colorTemp) {
        this(lampPower, new Color(hue, sat, brightness, colorTemp));
    }

    /**
     * Contructs a MyLampState object.
     *
     * @param lampPower The Power value. Default is ON.
     * @param colorState The Color value. Default is WHITE.
     */
    public MyLampState(Power lampPower, Color colorState) {
        power = (lampPower != null)? lampPower : DEFAULT_POWER;
        color = (colorState != null)? colorState : DEFAULT_COLOR;
    }

    /**
     * Sets the MyLampState's Power and Color values to those of the parameter.
     * If either of the parameter's values are <code>null</code>, the corresponding parameter
     * in the MyLampState will be set to <code>null</code>.
     *
     * @param other The other MyLampState.
     */
    public MyLampState(MyLampState other) {
        this((other == null)? null : other.power,
                (other == null)? null : new Color(other.color));
    }

    /**
     * Returns the Power state of the MyLampState.
     *
     * @return the Power state of the MyLampState.
     */
    public Power getPower() {
        return power;
    }

    /**
     * Returns the Color state of the MyLampState.
     *
     * @return The Color state of the MyLampState.
     */
    public Color getColor() {
        return color;
    }

    /**
     * Returns boolean true if the Power state of the MyLampState is ON, false otherwise.
     *
     * @return Boolean true if the Power state of the MyLampState is ON, false otherwise.
     */
    @Override
    public boolean getPowerOn() {
        return power == Power.ON;
    }

    /**
     * Sets power to ON if passed boolean true, OFF otherwise.
     *
     * @param powerOn Boolean that sets the Power state.
     */
    @Override
    public void setPowerOn(boolean powerOn) {
        power = (powerOn)? Power.ON : Power.OFF;
    }

    /**
     * Returns boolean true if Power is ON, false otherwise.
     *
     * @return boolean true if Power is ON, false otherwise.
     */
    public boolean isOn() {
        return getPowerOn();
    }

    /**
     * Returns boolean true if Power is OFF, false otherwise.
     *
     * @return boolean true if Power is OFF, false otherwise.
     */
    public boolean isOff() {
        return !isOn();
    }

    /**
     * Return an int array in which the first four indices correspond to
     * the Hue, Saturation, Brightness, and Color Temperature values of the
     * MyLampState's Color, respectively.
     *
     * @return The hsvt array.
     */
    @Override
    public int[] getColorHsvt() {
        return new int[] { color.getHue(), color.getSaturation(), color.getBrightness(), color.getColorTemperature() };
    }

    /**
     * Sets the hue, saturation, brightness, and color temperature of
     * the MyLampState's Color value.
     *
     * @param hueDegrees The hue component of the desired color, in degrees (0-360)
     * @param saturationPercent The saturation component of the desired color, in percent (0-100)
     * @param brightnessPercent The brightness component of the desired color, in percent (0-100)
     * @param colorTempDegrees The color temperature component of the desired color, in degrees Kelvin (2700-9000)
     */
    @Override
    public void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees) {
        color = new Color(hueDegrees, saturationPercent, brightnessPercent, colorTempDegrees);
    }

    /**
     * Returns the hash code of the MyLampState object.
     *
     * @return A hash code of the MyLampState object.
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((color == null) ? 0 : color.hashCode());
        result = prime * result + ((power == null) ? 0 : power.hashCode());
        return result;
    }

    /**
     * Returns boolean true if the MyLampState is equivalent to the
     * parameter object, false otherwise.
     *
     * @return boolean true if the MyLampState is equivalent to the
     * parameter object, false otherwise.
     */
    @Override
    public boolean equals(Object other) {
        if (other != null && other instanceof MyLampState) {
            MyLampState otherMyLampState = (MyLampState) other;

            return this.getColor().equals(otherMyLampState.getColor()) &&
                    this.getPower().equals(otherMyLampState.getPower());
        }

        return false;
    }
}

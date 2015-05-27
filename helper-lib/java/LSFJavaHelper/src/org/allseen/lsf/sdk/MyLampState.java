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

public class MyLampState implements LampState {

    private static final Color DEFAULT_COLOR = Color.WHITE;
    private static final Power DEFAULT_POWER = Power.ON;

    private Power power;
    private Color color;

    public MyLampState(Power lampPower, int hue, int sat, int brightness, int colorTemp) {
        this(lampPower, new Color(hue, sat, brightness, colorTemp));
    }

    public MyLampState(Power lampPower, Color colorState) {
        power = (lampPower != null)? lampPower : DEFAULT_POWER;
        color = (colorState != null)? colorState : DEFAULT_COLOR;
    }

    public MyLampState(MyLampState other) {
        this((other == null)? null : other.power,
             (other == null)? null : new Color(other.color));
    }

    public Power getPower() {
        return power;
    }

    public Color getColor() {
        return color;
    }

    @Override
    public boolean getPowerOn() {
        return power == Power.ON;
    }

    @Override
    public void setPowerOn(boolean powerOn) {
        power = (powerOn)? Power.ON : Power.OFF;
    }

    @Override
    public int[] getColorHsvt() {
        return new int[] { color.getHue(), color.getSaturation(), color.getBrightness(), color.getColorTemperature() };
    }

    @Override
    public void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees) {
        color = new Color(hueDegrees, saturationPercent, brightnessPercent, colorTempDegrees);
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((color == null) ? 0 : color.hashCode());
        result = prime * result + ((power == null) ? 0 : power.hashCode());
        return result;
    }

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

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
package org.allseen.lsf.sampleapp;

import org.allseen.lsf.LampDetails;
import org.allseen.lsf.LampState;
import org.allseen.lsf.sdk.model.ColorStateConverter;
import org.allseen.lsf.sdk.model.LampCapabilities;

import android.graphics.Color;

public class ViewColor {

    public static int calculate(LampState state, LampCapabilities capability, LampDetails details) {
        int viewColorTempDefault = details != null ? details.getMinTemperature() : ColorStateConverter.VIEW_COLORTEMP_MIN;

        if (viewColorTempDefault < ColorStateConverter.VIEW_COLORTEMP_MIN || viewColorTempDefault > ColorStateConverter.VIEW_COLORTEMP_MAX) {
            viewColorTempDefault = ColorStateConverter.VIEW_COLORTEMP_MIN;
        }

        return calculate(state, capability, ColorStateConverter.convertColorTempViewToModel(viewColorTempDefault));
    }

    public static int calculate(LampState state, LampCapabilities capability, long modelColorTempDefault) {
        int viewHue;
        int viewSaturation;
        int viewBrightness;
        int viewColorTemp;

        if (capability == null || capability.color > LampCapabilities.NONE) {
            // Type 4 (full color)
            viewHue = ColorStateConverter.convertHueModelToView(state.getHue());
            viewSaturation = ColorStateConverter.convertSaturationModelToView(state.getSaturation());
            viewBrightness = ColorStateConverter.convertBrightnessModelToView(state.getBrightness());
            viewColorTemp = ColorStateConverter.convertColorTempModelToView(state.getColorTemp());
        } else if (capability.temp > LampCapabilities.NONE) {
            // Type 3 (on/off, dim, color temp)
            viewHue = ColorStateConverter.VIEW_HUE_MIN;
            viewSaturation = ColorStateConverter.VIEW_SATURATION_MIN;
            viewBrightness = ColorStateConverter.convertBrightnessModelToView(state.getBrightness());
            viewColorTemp = ColorStateConverter.convertColorTempModelToView(state.getColorTemp());
        } else if (capability.dimmable > LampCapabilities.NONE) {
            // Type 2 (on/off, dim)
            viewHue = ColorStateConverter.VIEW_HUE_MIN;
            viewSaturation = ColorStateConverter.VIEW_SATURATION_MIN;
            viewBrightness = ColorStateConverter.convertBrightnessModelToView(state.getBrightness());
            viewColorTemp = ColorStateConverter.convertColorTempModelToView(modelColorTempDefault);
        } else {
            // Type 1 (on/off)
            viewHue = ColorStateConverter.VIEW_HUE_MIN;
            viewSaturation = ColorStateConverter.VIEW_SATURATION_MIN;
            viewBrightness = ColorStateConverter.VIEW_BRIGHTNESS_MAX;
            viewColorTemp = ColorStateConverter.convertColorTempModelToView(modelColorTempDefault);
        }

        int color;
        float[] hsv = { viewHue, (float) (viewSaturation / 100.0), (float) (viewBrightness / 100.0) };

        if ((viewColorTemp >= ColorStateConverter.VIEW_COLORTEMP_MIN) && (viewColorTemp <= ColorStateConverter.VIEW_COLORTEMP_MAX)) {
            color = calculate(viewColorTemp, hsv);
        } else {
            color = Color.HSVToColor(hsv);
        }

        return color;
    }

    private static int calculate(int intTmpKelvin, float[] hsv) {

        double red = 0f;
        double green = 0f;
        double blue = 0f;

        if (intTmpKelvin < ColorStateConverter.VIEW_COLORTEMP_MIN) {
            intTmpKelvin = ColorStateConverter.VIEW_COLORTEMP_MIN;
        } else if (intTmpKelvin > ColorStateConverter.VIEW_COLORTEMP_MAX) {
            intTmpKelvin = ColorStateConverter.VIEW_COLORTEMP_MAX;
        }

        double tmpKelvin = intTmpKelvin / 100f;

        red = calculateRed(tmpKelvin);
        green = calculateGreen(tmpKelvin);
        blue = calculateBlue(tmpKelvin);

        int sum = (int) (red + green + blue);

        // Compute factors for r, g, and b channels:
        final double ctR = (red / sum * 3);
        final double ctG = (green / sum * 3);
        final double ctB = (blue / sum * 3);

        // Convert the original color we want to apply to rgb format:
        int currentColor = Color.HSVToColor(hsv);
        int currentR = Color.red(currentColor);
        int currentG = Color.green(currentColor);
        int currentB = Color.blue(currentColor);

        // Multiply each channel in its factor
        int newR = (int) Math.round(ctR * currentR);
        int newG = (int) Math.round(ctG * currentG);
        int newB = (int) Math.round(ctB * currentB);

        // Fix values if needed
        if (newR > 255)
            newR = 255;
        if (newG > 255)
            newG = 255;
        if (newB > 255)
            newB = 255;

        return Color.argb(255, newR, newG, newB);
    }

    private static double calculateRed(double tmpKelvin) {
        double red = 0f;
        if (tmpKelvin <= 66) {
            red = 255;
        } else {
            // 'Note: the R-squared value for this approximation is .988
            double tmpCalc = tmpKelvin - 60;

            tmpCalc = 329.698727446 * (Math.pow(tmpCalc, -0.1332047592));
            red = tmpCalc;

            if (red < 0) {
                red = 0;
            } else if (red > 255) {
                red = 255;
            }
        }
        return red;
    }

    private static double calculateGreen(double tmpKelvin) {
        double green = 0f;

        if (tmpKelvin <= 66) {
            // 'Note: the R-squared value for this approximation is .996
            double tmpCalc = tmpKelvin;

            tmpCalc = 99.4708025861 * Math.log(tmpCalc) - 161.1195681661;
            green = tmpCalc;

            if (green < 0) {
                green = 0;
            } else if (green > 255) {
                green = 255;
            }

        } else {
            // 'Note: the R-squared value for this approximation is .987
            double tmpCalc = tmpKelvin - 60;
            tmpCalc = 288.1221695283 * (Math.pow(tmpCalc, -0.0755148492));
            green = tmpCalc;

            if (green < 0) {
                green = 0;
            } else if (green > 255) {
                green = 255;
            }
        }

        return green;
    }

    private static double calculateBlue(double tmpKelvin) {
        double blue = 0f;

        if (tmpKelvin >= 66) {
            blue = 255;
        } else if (tmpKelvin <= 19) {
            blue = 0;
        } else {
            // 'Note: the R-squared value for this approximation is .998
            double tmpCalc = tmpKelvin - 10;
            tmpCalc = 138.5177312231 * Math.log(tmpCalc) - 305.0447927307;
            blue = tmpCalc;

            if (blue < 0) {
                blue = 0;
            } else if (blue > 255) {
                blue = 255;
            }
        }

        return blue;
    }
}

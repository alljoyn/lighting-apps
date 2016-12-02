/* /* 
 *    Copyright (c) 2016 Open Connectivity Foundation and AllJoyn Open
 *    Source Project Contributors and others.
 *    
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0

 */
package org.allseen.lsf.sdk;

/**
 * Provides an interface for developers to implement and create their own LampState object.
 */
public interface LampState {

    /**
     * Returns the power state of the LampState object.
     *
     * @return Returns true if the power is on, false otherwise
     */
    public boolean getPowerOn();

    /**
     * Sets the power state of the LampState object.
     *
     * @param powerOn Specifies the power state
     */
    public void setPowerOn(boolean powerOn);

    /**
     * Returns the HSVT color of the LampState object
     *
     * @return Integer array containing the HSVT color
     */
    public int[] getColorHsvt();

    /**
     * Sets the color of the LampState object using the provided values.
     * <p>
     * <b>Note: If the provided HSVT values are outside the expected range, they will be normalized to the
     * expected range</b>
     *
     * @param hueDegrees The hue component of the desired color (0-360)
     * @param saturationPercent The saturation component of the desired color (0-100)
     * @param brightnessPercent The brightness component of the desired color (0-100)
     * @param colorTempDegrees The color temperature component of the desired color (1000-20000)
     */
    public void setColorHsvt(int hueDegrees, int saturationPercent, int brightnessPercent, int colorTempDegrees);
}
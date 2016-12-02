/*
 *  * 
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
 * Enum describing how the device running the controller service is powered.
 */
public enum RankPower {
    /**
     * Indicates a device that is battery powered and not chargeable.
     */
    BATTERY_POWERED_NOT_CHARGABLE,

    /**
     * Indicates a device that is battery powered and chargeable.
     */
    BATTERY_POWERED_CHARGABLE,

    /**
     * Indicates a device that is always connected to a power source.
     */
    ALWAYS_AC_POWERED,

    /**
     * If OEMs return this value, the Controller Service will use BATTERY_POWERED_NOT_CHARGABLE as this is not a valid value
     */
    OEM_CS_RANKPARAM_POWER_LAST_VALUE;

    /** Static lookup, used by the native code */
    @SuppressWarnings("unused")
    private static RankPower fromValue(int value) {
        for (RankPower r : RankPower.values()) {
            if (r.getValue() == value) {
                return r;
            }
        }

        return null;
    }

    /**
     * Gets the integer value of the enum.
     *
     * @return the integer value
     */
    public int getValue() { return ordinal(); }
}

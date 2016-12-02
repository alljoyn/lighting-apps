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
 * Enum describing how mobile the device that is running the controller service.
 */
public enum RankMobility {
    /**
     * Devices like smartphones will fall in this category
     */
    HIGH_MOBILITY,

    /**
     * Examples are tablets & laptops
     */
    INTERMEDIATE_MOBILITY,

    /**
     * Mostly stationary and proximal devices fall in this category. An example is wireless speaker
     */
    LOW_MOBILITY,

    /**
     * Examples are WiFi Access Point, TV
     */
    ALWAYS_STATIONARY,

    /**
     * If OEMs return this value, the Controller Service will use HIGH_MOBILITY as this is not a valid value
     */
    OEM_CS_RANKPARAM_MOBILITY_LAST_VALUE;

    /** Static lookup, used by the native code */
    @SuppressWarnings("unused")
    private static RankMobility fromValue(int value) {
        for (RankMobility r : RankMobility.values()) {
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

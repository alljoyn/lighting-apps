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
 * Enum describing the average uptime for the device running the controller service
 * over a 24 hour period.
 */
public enum RankAvailability {
    /**
     * Indicates uptime of 0-3 hours.
     */
    ZERO_TO_THREE_HOURS,

    /**
     * Indicates uptime of 3-6 hours.
     */
    THREE_TO_SIX_HOURS,

    /**
     * Indicates uptime of 6-9 hours.
     */
    SIX_TO_NINE_HOURS,

    /**
     * Indicates uptime of 9-12 hours.
     */
    NINE_TO_TWELVE_HOURS,

    /**
     * Indicates uptime of 12-15 hours.
     */
    TWELVE_TO_FIFTEEN_HOURS,

    /**
     * Indicates uptime of 15-18 hours.
     */
    FIFTEEN_TO_EIGHTEEN_HOURS,

    /**
     * Indicates uptime of 18-21 hours.
     */
    EIGHTEEN_TO_TWENTY_ONE_HOURS,

    /**
     * Indicates uptime of 24 hours.
     */
    TWENTY_ONE_TO_TWENTY_FOUR_HOURS,

    /**
     * If OEMs return this value, the Controller Service will use ZERO_TO_THREE_HOURS as this is not a valid value.
     */
    OEM_CS_RANKPARAM_AVAILABILITY_LAST_VALUE;

    /** Static lookup, used by the native code */
    @SuppressWarnings("unused")
    private static RankAvailability fromValue(int value) {
        for (RankAvailability r : RankAvailability.values()) {
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

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
 * Enum describing how the device running the controller service connects to the network.
 */
public enum RankNodeType {
    /**
     * Indicates device is connected to the access point over a wireless link
     */
    WIRELESS,
    /**
     * Indicates device is connected to the access point over a wired link
     */
    WIRED,

    /**
     * Indicates device running the Controller Service is the access point itself
     */
    ACCESS_POINT,

    /**
     * If OEMs return this value, the Controller Service will use WIRELESS as this is not a valid value
     */
    OEM_CS_RANKPARAM_NODETYPE_LAST_VALUE;

    /** Static lookup, used by the native code */
    @SuppressWarnings("unused")
    private static RankNodeType fromValue(int value) {
        for (RankNodeType r : RankNodeType.values()) {
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

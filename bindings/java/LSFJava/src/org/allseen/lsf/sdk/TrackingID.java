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
 * This class encapsulates the tracking ID that is returned when groups, presets, effect, and scenes are
 * created in the Lighting system. The tracking ID can be matched to objects created by the developer
 * themselves.
 */
public class TrackingID {
    /**
     * Defines a constant for an undefined tracking ID.
     */
    public static final long UNDEFINED = -1;

    /**
     * The value of the tracking ID.
     */
    public long value;

    /**
     * Constructs a TrackingID object.
     * <p>
     * <b>WARNING: This method is intended to be used internally. Client software should not instantiate
     * TrackingID directly.</b>
     */
    public TrackingID() {
        this(UNDEFINED);
    }

    /**
     * Constructs a TrackingID object using the provided value.
     * <p>
     * <b>WARNING: This method is intended to be used internally. Client software should not instantiate
     * TrackingID directly.</b>
     */
    public TrackingID(long value) {
        this.value = value;
    }
}
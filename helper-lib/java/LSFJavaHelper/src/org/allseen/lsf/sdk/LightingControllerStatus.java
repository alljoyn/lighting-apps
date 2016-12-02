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
 * Enum used to convey the status of a LightingController operation.
 */
public enum LightingControllerStatus {
    /**
     * LightingController operation was successful.
     */
    OK,

    /**
     * An error occurred during the LightingController operation.
     */
    ERROR,

    /**
     * LightingController was already started when start was called.
     */
    ERROR_ALREADY_RUNNING,

    /**
     * Error occurred while initializing the LightingController.
     */
    ERROR_INIT
}
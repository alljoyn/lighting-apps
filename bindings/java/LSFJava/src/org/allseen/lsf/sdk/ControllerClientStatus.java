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

package org.allseen.lsf.sdk;

/**
 * Enum describing the status returned by a controller client function call.
 */
public enum ControllerClientStatus {
    /**
     * Indicates that controller client operation was successful.
     */
    OK,

    /**
     * Indicates that the controller client operation failed because the controller
     * client is not connected to a controller service.
     */
    ERR_NOT_CONNECTED,

    /**
     * Indicates that the controller client operation failed. Look at the error logs
     * to determine why the failure occurred.
     */
    ERR_FAILURE,

    /**
     * Indicates that the controller client operation failed and should be retried.
     */
    ERR_RETRY;

    /** Static lookup, used by the native code */
    @SuppressWarnings("unused")
    private static ControllerClientStatus fromValue(int value) {
        for (ControllerClientStatus c : ControllerClientStatus.values()) {
            if (c.getValue() == value) {
                return c;
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

/*
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */

package org.allseen.lsf;

public enum ResponseCode {
    OK(0),                      /* Success status */
    ERR_NULL(1),                /* Unexpected NULL pointer */
    ERR_UNEXPECTED(2),          /* An operation was unexpected at this time */
    ERR_INVALID(3),             /* A value was invalid */
    ERR_UNKNOWN(4),             /* A unknown value */
    ERR_FAILURE(5),             /* A failure has occurred */
    ERR_BUSY(6),                /* An operation failed and should be retried later */
    ERR_REJECTED(7),            /* The request was rejected */
    ERR_RANGE(8),               /* Value provided was out of range */
    ERR_UNDEFINED1(9),          /* [This response code is not defined] */
    ERR_INVALID_FIELD(10),      /* Invalid param/state field */
    ERR_MESSAGE(11),            /* Invalid message */
    ERR_INVALID_ARGS(12),       /* The arguments were invalid */
    ERR_EMPTY_NAME(13),         /* The name is empty */
    ERR_RESOURCES(14),          /* not enough resources */
    ERR_PARTIAL(15),            /* The requested operation was only partially successful */
    ERR_NOT_FOUND(16),          /* The entity of interest was not found */
    ERR_NO_SLOT(17),            /* There is no slot for new entry */
    ERR_DEPENDENCY(18),         /* There is a dependency of the entity for which a delete request was received */
    RESPONSE_CODE_LAST(19);     /* The last LSF response code */

    /** Integer value */
    private int value;

    /** Constructor */
    private ResponseCode(int value) {
        this.value = value;
    }

    /** Static lookup, used by the native code */
    @SuppressWarnings("unused")
    private static ResponseCode fromValue(int value) {
        for (ResponseCode c : ResponseCode.values()) {
            if (c.getValue() == value) {
                return c;
            }
        }

        return null;
    }

    /**
     * Gets the integer value.
     *
     * @return the integer value
     */
    public int getValue() { return value; }
}
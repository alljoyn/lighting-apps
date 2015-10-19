/* Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
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
package org.allseen.lsf.sdk;

/**
 * This class encapsulates the AllJoyn about data of a Lamp in the Lighting System.
 * <p>
 * See the AllJoyn core documentation for more information on the AllJoyn about data.
 */
public class LampAbout extends org.allseen.lsf.sdk.model.LampAbout {

    /**
     * Specifies the string to use when an AllJoyn about field is indeterminate.
     *
     * @param dataNotFound String to use for indeterminate fields
     */
    public static void setDataNotFound(String dataNotFound) {
        if (dataNotFound != null) {
            org.allseen.lsf.sdk.model.LampAbout.dataNotFound = dataNotFound;
        }
    }

    /**
     * Constructs a LampAbout object using the provided LampAbout object.
     *
     * @param that A LampAbout object
     */
    public LampAbout(org.allseen.lsf.sdk.model.LampAbout that) {
        super(that);
    }
}
/* Copyright (c) AllSeen Alliance. All rights reserved.
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
 * A Lamp About object represents the About details of a Lamp in the Lighting System.
 */
public class LampAbout extends org.allseen.lsf.sdk.model.LampAbout {
    /**
     * Replaces the DataNotFound String in the LampAbout model.
     *
     * @param dataNotFound The replacement String.
     */
    public static void setDataNotFound(String dataNotFound) {
        if (dataNotFound != null) {
            org.allseen.lsf.sdk.model.LampAbout.dataNotFound = dataNotFound;
        }
    }

    /**
     * Instantiates a Lamp About object identical to the existing Lamp About
     * object passed as a parameter.
     *
     * @param that The model Lamp About object.
     */
    public LampAbout(org.allseen.lsf.sdk.model.LampAbout that) {
        super(that);
    }
}

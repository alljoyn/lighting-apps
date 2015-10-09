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
 * This class specifies the uniformity of lamp state for a given Lighting item. The uniformity is only useful
 * if you need to determine if a Group of lamps all have the same power and color state.
 */
public class LampStateUniformity extends org.allseen.lsf.sdk.model.LampStateUniformity {

    /**
     * Default constructor for a LampStateUniformity object.
     */
    public LampStateUniformity() {
        super();
    }

    /**
     * Constructs a LampStateUniformity object using the provided LampStateUniformity object.
     *
     * @param that A LampStateUniformity object
     */
    public LampStateUniformity(org.allseen.lsf.sdk.model.LampStateUniformity that) {
        super(that);
    }
}
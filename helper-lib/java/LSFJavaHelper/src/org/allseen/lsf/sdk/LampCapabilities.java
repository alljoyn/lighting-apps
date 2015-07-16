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
 * This class represents the current capabilities of a Lamp in the Lighting system.
 * Such capabilities include: dimmable, color, and color temperature.
 */
public class LampCapabilities extends org.allseen.lsf.sdk.model.LampCapabilities {

    /**
     * Default lamp capabilities all set to true.
     */
    public static final LampCapabilities allCapabilities = new LampCapabilities(true, true, true);

    /**
     * Default constructor for a LampCapabilities object.
     */
    public LampCapabilities() {
        super();
    }

    /**
     * Constructs a LampCapabilites object.
     *
     * @param dimmable Boolean true if your lamp is dimmable
     * @param color Boolean true if your lamp supports colors
     * @param temp Boolean true if your lamp supports color temperature
     */
    public LampCapabilities(boolean dimmable, boolean color, boolean temp) {
        super(dimmable, color, temp);
    }

    /**
     * Constructs a LampCapabilities object using the provided LampCapabilities object.
     *
     * @param that A LampCapabilities object
     */
    public LampCapabilities(org.allseen.lsf.sdk.model.LampCapabilities that) {
        super(that);
    }
}

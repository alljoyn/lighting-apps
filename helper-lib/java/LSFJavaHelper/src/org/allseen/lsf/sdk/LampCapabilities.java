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
 * A Lamp Capabilities object represents the parameters supported
 * by a Lamp in the lighting system.
 * <p>
 * Such capabilities include: Dimmable, Color, Color Temperature.
 */
public class LampCapabilities extends org.allseen.lsf.sdk.model.LampCapabilities {
    public static final LampCapabilities allCapabilities = new LampCapabilities(true, true, true);

    /**
     * Default constructor for a LampCapabilities object.
     */
    public LampCapabilities() {
        super();
    }

    /**
     * Constructor for a LampCapabilites object.
     *
     * @param dimmable Boolean true if your lamp supports dimming.
     * @param color Boolean true if your lamp supports colors.
     * @param temp Boolean true if your lamp supports color temperature.
     */
    public LampCapabilities(boolean dimmable, boolean color, boolean temp) {
        super(dimmable, color, temp);
    }

    /**
     * Constructor for a LampCapabilities object.
     *
     * @param that A LampCapabilities object.
     */
    public LampCapabilities(org.allseen.lsf.sdk.model.LampCapabilities that) {
        super(that);
    }
}

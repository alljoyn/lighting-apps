/*
 * Copyright AllSeen Alliance. All rights reserved.
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
package org.allseen.lsf;

public enum RankAvailability {
    ZERO_TO_THREE_HOURS,
    THREE_TO_SIX_HOURS,
    SIX_TO_NINE_HOURS,
    NINE_TO_TWELVE_HOURS,
    TWELVE_TO_FIFTEEN_HOURS,
    FIFTEEN_TO_EIGHTEEN_HOURS,
    EIGHTEEN_TO_TWENTY_ONE_HOURS,
    /** Indicates 24 hours */
    TWENTY_ONE_TO_TWENTY_FOUR_HOURS,
    /** If OEMs return this value, the Controller Service will use ZERO_TO_THREE_HOURS as this is not a valid value */
    OEM_CS_RANKPARAM_AVAILABILITY_LAST_VALUE;

    /** Static lookup, used by the native code */
    @SuppressWarnings("unused")
    private static RankAvailability fromValue(int value) {
        for (RankAvailability r : RankAvailability.values()) {
            if (r.getValue() == value) {
                return r;
            }
        }

        return null;
    }

    /**
     * Gets the integer value.
     *
     * @return the integer value
     */
    public int getValue() { return ordinal(); }
}


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
 * An object representing information pertaining to an error with a Lighting Item.
 */
public class LightingItemErrorEvent {
    public String name;
    public ResponseCode responseCode;
    public String itemID;
    public TrackingID trackingID;
    public ErrorCode[] errorCodes;

    /**
     * Constructs a Lighting Item Error Event object.
     *
     * @param name The name of the error.
     * @param responseCode The response code of the error.
     * @param itemID The item ID of the Lighting Object.
     * @param trackingID The tracking ID of the Lighting Object.
     * @param errorCodes An array of ErrorCodes.
     */
    public LightingItemErrorEvent(String name, ResponseCode responseCode, String itemID, TrackingID trackingID, ErrorCode[] errorCodes) {
        this.name = name;
        this.responseCode = responseCode;
        this.itemID = itemID;
        this.trackingID = trackingID;
        this.errorCodes = errorCodes;
    }
}

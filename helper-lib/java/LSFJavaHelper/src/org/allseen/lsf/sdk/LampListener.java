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

import org.allseen.lsf.sdk.listener.LampCollectionListener;

//TODO-DOC
/**
 * The listener interface for receiving information about lamps in the lighting
 * system.
 */
public interface LampListener extends LampCollectionListener<Lamp, LightingItemErrorEvent> {
    /**
     * Called when the SDK has retrieved all the information about a lamp
     * from the controller service/
     *
     * @param lamp The lamp that was fully initialized
     */
    @Override
    public void onLampInitialized(Lamp lamp);

    @Override
    public void onLampChanged(Lamp lamp);

    @Override
    public void onLampRemoved(Lamp lamp);

    @Override
    public void onLampError(LightingItemErrorEvent error);
}

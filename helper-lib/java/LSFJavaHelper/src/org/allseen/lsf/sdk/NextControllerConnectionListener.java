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
 * The listener interface for managing callbacks triggered on the
 * connection of a lighting Controller.
 */
/**
 * Provides an interface for developers to implement and receive a callback when a connection is
 * established with a LightingController.
 * <p>
 * <b>Note: Once implemented, the listener must be registered with the LightingDirector in order
 * to receive a connection callback. See {@link LightingDirector#postOnNextControllerConnection(NextControllerConnectionListener, int) postOnNextControllerConnection}
 * for more information.</b>
 */
public interface NextControllerConnectionListener extends org.allseen.lsf.sdk.listener.NextControllerConnectionListener {

    /**
     * Triggered when a connection to a LightingController has been established
     * <p>
     * <b>Note: This listener will fire only once when a controller connection is established.</b>
     */
    @Override
    public void onControllerConnected();
}

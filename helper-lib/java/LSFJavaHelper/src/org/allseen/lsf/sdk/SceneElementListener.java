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

import org.allseen.lsf.sdk.listener.SceneElementCollectionListener;

/**
 * Provides an interface for developers to implement and receive all scene element related events in the
 * Lighting system. Developers will be notified when scene elements are added, modified, initialized, and
 * deleted from the lighting controller. Scene elements are considered initialized when all scene element data has
 * been received from the lighting controller.
 * <p>
 * <b>Note: Once implemented, the listener must be registered with the LightingDirector in order
 * to receive SceneElement callbacks. See {@link LightingDirector#addSceneElementListener(SceneElementListener) addSceneElementListener}
 * for more information.</b>
 */
public interface SceneElementListener extends SceneElementCollectionListener<SceneElement, LightingItemErrorEvent> {

    /**
     * Triggered when all data has been received from the lighting controller for a
     * particular SceneElement.
     * <p>
     * <b>Note: This callback will fire only once for each SceneElement when all data has been received from
     * the lighting controller.</b>
     * <p>
     * <b>Note: The tracking ID is only valid for scene elements created within your application.</b>
     *
     * @param trackingId Reference to TrackingID
     * @param element Reference to SceneElement
     */
    @Override
    public void onSceneElementInitialized(TrackingID trackingId, SceneElement element);

    /**
     * Triggered every time new data is received from the lighting controller for a
     * particular SceneElement.
     *
     * @param element Reference to SceneElement
     */
    @Override
    public void onSceneElementChanged(SceneElement element);

    /**
     * Triggered when a particular SceneElement has been deleted from the lighting controller.
     * <p>
     * <b>Note: This callback will fire only once for each SceneElement when it is deleted from
     * the lighting controller.</b>
     *
     * @param element Reference to SceneElement
     */
    @Override
    public void onSceneElementRemoved(SceneElement element);

    /**
     * Triggered when an error occurs on a SceneElement operation.
     *
     * @param error Reference to LightingItemErrorEvent
     */
    @Override
    public void onSceneElementError(LightingItemErrorEvent error);
}
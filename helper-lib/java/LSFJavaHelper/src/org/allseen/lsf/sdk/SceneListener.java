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

import org.allseen.lsf.sdk.listener.SceneCollectionListener;

/**
 * Provides an interface for developers to implement and receive all scenes related events in the
 * Lighting system. Developers will be notified when scenes are added, modified, initialized, and
 * deleted from the lighting controller. Scenes are considered initialized when all scene data has
 * been received from the lighting controller.
 * <p>
 * <b>Note: Once implemented, the listener must be registered with the LightingDirector in order
 * to receive Scene callbacks. See {@link LightingDirector#addSceneListener(SceneListener) addSceneListener}
 * for more information.</b>
 */
public interface SceneListener extends SceneCollectionListener<Scene, LightingItemErrorEvent> {

    /**
     * Triggered when all data has been received from the lighting controller for a
     * particular Scene.
     * <p>
     * <b>Note: This callback will fire only once for each Scene when all data has been received from
     * the lighting controller.</b>
     * <p>
     * <b>Note: The tracking ID is only valid for scenes created within your application.</b>
     *
     * @param trackingId Reference to TrackingID
     * @param scene Reference to Scene
     */
    @Override
    public void onSceneInitialized(TrackingID trackingId, Scene scene);

    /**
     * Triggered every time new data is received from the lighting controller for a
     * particular Scene.
     *
     * @param scene Reference to Scene
     */
    @Override
    public void onSceneChanged(Scene scene);

    /**
     * Triggered when a particular Scene has been deleted from the lighting controller.
     * <p>
     * <b>Note: This callback will fire only once for each Scene when it is deleted from
     * the lighting controller.</b>
     *
     * @param scene Reference to Scene
     */
    @Override
    public void onSceneRemoved(Scene scene);

    /**
     * Triggered when an error occurs on a Scene operation.
     *
     * @param error Reference to LightingItemErrorEvent
     */
    @Override
    public void onSceneError(LightingItemErrorEvent error);
}

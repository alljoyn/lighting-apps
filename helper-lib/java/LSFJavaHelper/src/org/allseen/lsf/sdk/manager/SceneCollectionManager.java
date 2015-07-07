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
package org.allseen.lsf.sdk.manager;

import java.util.Collection;
import java.util.Iterator;

import org.allseen.lsf.TrackingID;
import org.allseen.lsf.sdk.LightingItemErrorEvent;
import org.allseen.lsf.sdk.SceneListener;
import org.allseen.lsf.sdk.SceneV1;
import org.allseen.lsf.sdk.model.LightingItemFilter;
import org.allseen.lsf.sdk.model.SceneDataModel;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class SceneCollectionManager extends LightingItemCollectionManager<SceneV1, SceneListener, SceneDataModel> {

    public SceneCollectionManager(LightingSystemManager director) {
        super(director);
    }

    public SceneV1 addScene(String sceneID) {
        return addScene(sceneID, new SceneV1(sceneID));
    }

    public SceneV1 addScene(SceneDataModel sceneModel) {
        return addScene(sceneModel.id, new SceneV1(sceneModel));
    }

    public SceneV1 addScene(String sceneID, SceneV1 scene) {
        return itemAdapters.put(sceneID, scene);
    }

    public SceneV1 getScene(String sceneID) {
        return getAdapter(sceneID);
    }

    public SceneV1[] getScenes() {
        return getAdapters().toArray(new SceneV1[size()]);
    }

    public SceneV1[] getScenes(LightingItemFilter<SceneV1> filter) {
        Collection<SceneV1> filteredScenes = getAdapters(filter);
        return filteredScenes.toArray(new SceneV1[filteredScenes.size()]);
    }

    public Iterator<SceneV1> getSceneIterator() {
        return getAdapters().iterator();
    }

    public Collection<SceneV1> removeScenes() {
        return removeAllAdapters();
    }

    public SceneV1 removeScene(String sceneID) {
        return removeAdapter(sceneID);
    }

    @Override
    protected void sendInitializedEvent(SceneListener listener, SceneV1 scene, TrackingID trackingID) {
        listener.onSceneInitialized(trackingID, scene);
    }

    @Override
    protected void sendChangedEvent(SceneListener listener, SceneV1 scene) {
        listener.onSceneChanged(scene);
    }

    @Override
    protected void sendRemovedEvent(SceneListener listener, SceneV1 scene) {
        listener.onSceneRemoved(scene);
    }

    @Override
    protected void sendErrorEvent(SceneListener listener, LightingItemErrorEvent errorEvent) {
        listener.onSceneError(errorEvent);
    }

    @Override
    public SceneDataModel getModel(String sceneID) {
        SceneV1 scene = getAdapter(sceneID);

        return scene != null ? scene.getSceneDataModel() : null;
    }
}
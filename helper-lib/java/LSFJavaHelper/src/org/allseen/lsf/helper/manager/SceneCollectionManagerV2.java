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
package org.allseen.lsf.helper.manager;

import java.util.Collection;
import java.util.Iterator;

import org.allseen.lsf.TrackingID;
import org.allseen.lsf.helper.facade.SceneV2;
import org.allseen.lsf.helper.listener.LightingItemErrorEvent;
import org.allseen.lsf.helper.listener.SceneListener;
import org.allseen.lsf.helper.model.LightingItemFilter;
import org.allseen.lsf.helper.model.SceneDataModelV2;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class SceneCollectionManagerV2 extends LightingItemCollectionManager<SceneV2, SceneListener, SceneDataModelV2> {

    public SceneCollectionManagerV2(LightingSystemManager director) {
        super(director);
    }

    public SceneV2 addScene(String sceneID) {
        return addScene(sceneID, new SceneV2(sceneID));
    }

    public SceneV2 addScene(SceneDataModelV2 sceneModel) {
        return addScene(sceneModel.id, new SceneV2(sceneModel));
    }

    public SceneV2 addScene(String sceneID, SceneV2 scene) {
        return itemAdapters.put(sceneID, scene);
    }

    public SceneV2 getScene(String sceneID) {
        return getAdapter(sceneID);
    }

    public SceneV2[] getScenes() {
        return getAdapters().toArray(new SceneV2[size()]);
    }

    public SceneV2[] getScenes(LightingItemFilter<SceneV2> filter) {
        Collection<SceneV2> filteredScenes = getAdapters(filter);
        return filteredScenes.toArray(new SceneV2[filteredScenes.size()]);
    }

    public Iterator<SceneV2> getSceneIterator() {
        return getAdapters().iterator();
    }

    public Collection<SceneV2> removeScenes() {
        return removeAllAdapters();
    }

    public SceneV2 removeScene(String sceneID) {
        return removeAdapter(sceneID);
    }

    @Override
    protected void sendInitializedEvent(SceneListener listener, SceneV2 scene, TrackingID trackingID) {
        listener.onSceneInitialized(trackingID, scene);
    }

    @Override
    protected void sendChangedEvent(SceneListener listener, SceneV2 scene) {
        listener.onSceneChanged(scene);
    }

    @Override
    protected void sendRemovedEvent(SceneListener listener, SceneV2 scene) {
        listener.onSceneRemoved(scene);
    }

    @Override
    protected void sendErrorEvent(SceneListener listener, LightingItemErrorEvent errorEvent) {
        listener.onSceneError(errorEvent);
    }

    @Override
    public SceneDataModelV2 getModel(String sceneID) {
        SceneV2 scene = getAdapter(sceneID);

        return scene != null ? scene.getSceneDataModel() : null;
    }
}

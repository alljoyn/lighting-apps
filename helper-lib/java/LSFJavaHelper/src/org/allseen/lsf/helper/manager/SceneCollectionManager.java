/*
 *    Copyright (c) Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright (c) Open Connectivity Foundation and Contributors to AllSeen
 *    Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *    THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *    WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *    WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *    AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *    DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *    PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *    TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *    PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.helper.manager;

import java.util.Collection;
import java.util.Iterator;

import org.allseen.lsf.helper.facade.Scene;
import org.allseen.lsf.helper.listener.LightingItemErrorEvent;
import org.allseen.lsf.helper.listener.SceneCollectionListener;
import org.allseen.lsf.helper.model.SceneDataModel;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class SceneCollectionManager extends LightingItemCollectionManager<Scene, SceneCollectionListener, SceneDataModel> {

    public SceneCollectionManager(LightingSystemManager director) {
        super(director);
    }

    public Scene addScene(String sceneID) {
        return addScene(sceneID, new Scene(sceneID));
    }

    public Scene addScene(SceneDataModel sceneModel) {
        return addScene(sceneModel.id, new Scene(sceneModel));
    }

    public Scene addScene(String sceneID, Scene scene) {
        return itemAdapters.put(sceneID, scene);
    }

    public Scene getScene(String sceneID) {
        return getAdapter(sceneID);
    }

    public Scene[] getScenes() {
        return getAdapters().toArray(new Scene[size()]);
    }

    public Iterator<Scene> getSceneIterator() {
        return getAdapters().iterator();
    }

    public Collection<Scene> removeScenes() {
        return removeAllAdapters();
    }

    public Scene removeScene(String sceneID) {
        return removeAdapter(sceneID);
    }

    @Override
    protected void sendChangedEvent(SceneCollectionListener listener, Scene scene) {
        listener.onSceneChanged(scene);
    }

    @Override
    protected void sendRemovedEvent(SceneCollectionListener listener, Scene scene) {
        listener.onSceneRemoved(scene);
    }

    @Override
    protected void sendErrorEvent(SceneCollectionListener listener, LightingItemErrorEvent errorEvent) {
        listener.onSceneError(errorEvent);
    }

    @Override
    public SceneDataModel getModel(String sceneID) {
        Scene scene = getAdapter(sceneID);

        return scene != null ? scene.getSceneDataModel() : null;
    }
}
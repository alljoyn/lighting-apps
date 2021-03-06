/*
 *    Copyright (c) Open Connectivity Foundation (OCF), AllJoyn Open Source
 *    Project (AJOSP) Contributors and others.
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
package org.allseen.lsf.sdk.manager;

import java.util.Collection;
import java.util.Iterator;

import org.allseen.lsf.sdk.TrackingID;
import org.allseen.lsf.sdk.factory.SceneV2Factory;
import org.allseen.lsf.sdk.listener.SceneCollectionListener;
import org.allseen.lsf.sdk.model.LightingItemFilter;
import org.allseen.lsf.sdk.model.SceneDataModelV2;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class SceneCollectionManagerV2<SCENEV2, ERROR> extends SceneCollectionManager<SCENEV2, SceneDataModelV2, ERROR> { //extends LightingItemCollectionManager<SCENEV2, SceneCollectionListener<? super SCENEV2, ? super ERROR>, SceneDataModelV2, ERROR> {

    protected final SceneV2Factory<SCENEV2, ERROR> factory;

    public SceneCollectionManagerV2(LightingSystemManager<?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?> manager, SceneV2Factory<SCENEV2, ERROR> factory) {
        super(manager, factory);

        this.factory = factory;
    }

    @Override
    public SCENEV2 addScene(String sceneID) {
        return addScene(sceneID, factory.createSceneV2(sceneID));
    }

    public SCENEV2 addScene(String sceneID, SCENEV2 scene) {
        return itemAdapters.put(sceneID, scene);
    }

    public SCENEV2 getScene(String sceneID) {
        return getAdapter(sceneID);
    }

    public SCENEV2[] getScenes() {
        return getAdapters().toArray(factory.createScenesV2(size()));
    }

    public SCENEV2[] getScenes(LightingItemFilter<SCENEV2> filter) {
        Collection<SCENEV2> filteredScenes = getScenesCollection(filter);
        return filteredScenes.toArray(factory.createScenesV2(filteredScenes.size()));
    }

    public Collection<SCENEV2> getScenesCollection(LightingItemFilter<SCENEV2> filter) {
        return getAdapters(filter);
    }

    public Iterator<SCENEV2> getSceneIterator() {
        return getAdapters().iterator();
    }

    public Collection<SCENEV2> removeScenes() {
        return removeAllAdapters();
    }

    @Override
    public SCENEV2 removeScene(String sceneID) {
        return removeAdapter(sceneID);
    }

    @Override
    protected void sendInitializedEvent(SceneCollectionListener<? super SCENEV2, ? super ERROR> listener, SCENEV2 scene, TrackingID trackingID) {
        listener.onSceneInitialized(trackingID, scene);
    }

    @Override
    protected void sendChangedEvent(SceneCollectionListener<? super SCENEV2, ? super ERROR> listener, SCENEV2 scene) {
        listener.onSceneChanged(scene);
    }

    @Override
    protected void sendRemovedEvent(SceneCollectionListener<? super SCENEV2, ? super ERROR> listener, SCENEV2 scene) {
        listener.onSceneRemoved(scene);
    }

    @Override
    protected void sendErrorEvent(SceneCollectionListener<? super SCENEV2, ? super ERROR> listener, ERROR error) {
        listener.onSceneError(error);
    }

    @Override
    public SceneDataModelV2 getModel(String sceneID) {
        return getModel(getAdapter(sceneID));
    }

    @Override
    public SceneDataModelV2 getModel(SCENEV2 scene) {
        return scene != null ? factory.findSceneDataModelV2(scene) : null;
    }
}
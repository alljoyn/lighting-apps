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

import org.allseen.lsf.helper.facade.MasterScene;
import org.allseen.lsf.helper.listener.LightingItemErrorEvent;
import org.allseen.lsf.helper.listener.MasterSceneCollectionListener;
import org.allseen.lsf.helper.model.MasterSceneDataModel;

/**
 * <b>WARNING: This class is not intended to be used by clients, and its interface may change
 * in subsequent releases of the SDK</b>.
 */
public class MasterSceneCollectionManager extends LightingItemCollectionManager<MasterScene, MasterSceneCollectionListener, MasterSceneDataModel> {

    public MasterSceneCollectionManager(LightingSystemManager director) {
        super(director);
    }

    public MasterScene addMasterScene(String masterSceneID) {
        return addMasterScene(masterSceneID, new MasterScene(masterSceneID));
    }

    public MasterScene addMasterScene(String masterSceneID, MasterScene scene) {
        return itemAdapters.put(masterSceneID, scene);
    }

    public MasterScene getMasterScene(String masterSceneID) {
        return getAdapter(masterSceneID);
    }

    public MasterScene[] getMasterScenes() {
        return getAdapters().toArray(new MasterScene[size()]);
    }

    public Iterator<MasterScene> getMasterSceneIterator() {
        return getAdapters().iterator();
    }

    public Collection<MasterScene> removeMasterScenes() {
        return removeAllAdapters();
    }

    public MasterScene removeMasterScene(String masterSceneID) {
        return removeAdapter(masterSceneID);
    }

    @Override
    protected void sendChangedEvent(MasterSceneCollectionListener listener, MasterScene masterScene) {
        listener.onMasterSceneChanged(masterScene);
    }

    @Override
    protected void sendRemovedEvent(MasterSceneCollectionListener listener, MasterScene masterScene) {
        listener.onMasterSceneRemoved(masterScene);
    }

    @Override
    protected void sendErrorEvent(MasterSceneCollectionListener listener, LightingItemErrorEvent errorEvent) {
        listener.onMasterSceneError(errorEvent);
    }

    @Override
    public MasterSceneDataModel getModel(String masterSceneID) {
        MasterScene scene = getAdapter(masterSceneID);

        return scene != null ? scene.getMasterSceneDataModel() : null;
    }
}
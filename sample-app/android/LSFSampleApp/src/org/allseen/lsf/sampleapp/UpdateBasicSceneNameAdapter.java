/*
 * Copyright (c) 2016 Open Connectivity Foundation (OCF) and AllJoyn Open
 *    Source Project (AJOSP) Contributors and others.
 *
 *    SPDX-License-Identifier: Apache-2.0
 *
 *    All rights reserved. This program and the accompanying materials are
 *    made available under the terms of the Apache License, Version 2.0
 *    which accompanies this distribution, and is available at
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Copyright 2016 Open Connectivity Foundation and Contributors to
 *    AllSeen Alliance. All rights reserved.
 *
 *    Permission to use, copy, modify, and/or distribute this software for
 *    any purpose with or without fee is hereby granted, provided that the
 *    above copyright notice and this permission notice appear in all
 *    copies.
 *
 *     THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
 *     WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
 *     WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
 *     AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 *     DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 *     PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
 *     TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 *     PERFORMANCE OF THIS SOFTWARE.
 */
package org.allseen.lsf.sampleapp;

import java.util.Iterator;

import org.allseen.lsf.helper.facade.Scene;
import org.allseen.lsf.helper.manager.AllJoynManager;
import org.allseen.lsf.helper.model.SceneDataModel;

public class UpdateBasicSceneNameAdapter extends UpdateItemNameAdapter {

    public UpdateBasicSceneNameAdapter(SceneDataModel basicSceneModel, SampleAppActivity activity) {
        super(basicSceneModel, activity);
    }

    @Override
    protected void doUpdateName() {
        AllJoynManager.sceneManager.setSceneName(itemModel.id, itemModel.getName(), SampleAppActivity.LANGUAGE);
    }

    @Override
    protected String getDuplicateNameMessage() {
        return activity.getString(R.string.duplicate_name_message_scene);
    }

    @Override
    protected boolean duplicateName(String sceneName) {
        Iterator<Scene> i = activity.systemManager.getSceneCollectionManager().getSceneIterator();

        while (i.hasNext()){
            SceneDataModel sceneModel = i.next().getSceneDataModel();

            if (sceneModel.getName().equals(sceneName) && !sceneName.equals(itemModel.getName())) {
                return true;
            }
        }

        return false;
    }
}